import { Component, ComponentRef, Injector, inject } from "@angular/core";
import { Page, View } from "@nativescript/core";
import { generateNativeScriptView } from "@nativescript/angular";
import { SwiftUIManager } from "@nativescript/swift-ui";
import { ParallaxImageComponent } from "./parallax-image.component";
import { ImageToken, data } from './data';

@Component({
  selector: "parallax",
  templateUrl: "./parallax.component.html",
})
export class ParallaxComponent {
  page = inject(Page);
  ngRefs: Map<string, ComponentRef<View>>;
  injector = inject(Injector);
  data = data;
  showMeshGradient = true;

  constructor() {
    this.page.actionBarHidden = true;
    // Registering Components for use within SwiftUI
    // Init the shared factory manually when not using SwiftUI app lifecycle boot setup
    NativeScriptViewFactory.initShared();
    const nsViews = {};
    for (const photo of data.photos) {
      nsViews[photo.id] = ParallaxImageComponent;
    }
    SwiftUIManager.registerNativeScriptViews(
      nsViews,
      {
        create: (id: string, component: any) => {
          const dataId = id.split('-')[0];
          if (!this.ngRefs) {
            this.ngRefs = new Map();
          }
          const injector = Injector.create({
            providers: [ {
              provide: ImageToken,
              useValue: data.photos.find(i => i.id === dataId),
            }],
            parent: this.injector,
          });
          const ngView = generateNativeScriptView(component, {
            injector,
          });
          this.ngRefs.set(id, ngView.ref as ComponentRef<View>);
          return ngView.firstNativeLikeView;
        },
        destroy: (id: string) => {
          if (this.ngRefs.has(id)) {
            this.ngRefs.get(id).destroy();
            this.ngRefs.delete(id);
          }
        },
      }
    );
  }
}
