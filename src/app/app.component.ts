import { Component } from "@angular/core";
import { registerElement } from "@nativescript/angular";
import { SwiftUI, UIDataDriver, registerSwiftUI } from "@nativescript/swift-ui";

registerElement("SwiftUI", () => SwiftUI);
declare var RippleViewProvider: any;
registerSwiftUI('rippleView', view => new UIDataDriver(RippleViewProvider.alloc().init(), view));
declare var WWDC24AnimatedViewProvider: any;
registerSwiftUI('animatedText', view => new UIDataDriver(WWDC24AnimatedViewProvider.alloc().init(), view));

@Component({
  selector: "ns-app",
  templateUrl: "./app.component.html",
})
export class AppComponent {}
