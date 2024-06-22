import { Component } from "@angular/core";
import { registerElement } from "@nativescript/angular";
import { SwiftUI, UIDataDriver, registerSwiftUI } from "@nativescript/swift-ui";

registerElement("SwiftUI", () => SwiftUI);

// Note: we could run `ns typings ios` to generate types if we needed to
declare var RippleViewProvider: any;
registerSwiftUI('rippleView', view => new UIDataDriver(RippleViewProvider.alloc().init(), view));
declare var WWDC24AnimatedViewProvider: any;
registerSwiftUI('animatedText', view => new UIDataDriver(WWDC24AnimatedViewProvider.alloc().init(), view));
declare var SiriViewProvider: any;
registerSwiftUI('siri', view => new UIDataDriver(SiriViewProvider.alloc().init(), view));
declare var ParallaxProvider: any;
registerSwiftUI('parallax', view => new UIDataDriver(ParallaxProvider.alloc().init(), view));
declare var MeshGradientProvider: any;
registerSwiftUI('meshGradient', view => new UIDataDriver(MeshGradientProvider.alloc().init(), view));

@Component({
  selector: "ns-app",
  templateUrl: "./app.component.html",
})
export class AppComponent {}
