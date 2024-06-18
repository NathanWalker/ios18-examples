import { Component, inject } from "@angular/core";
import { CoreTypes, Label, Page } from "@nativescript/core";
@Component({
  selector: "siri",
  templateUrl: "./siri.component.html",
})
export class SiriComponent {
  page = inject(Page);
  label: Label;

  constructor() {
    this.page.actionBarHidden = true;
  }

  loadedAnswer(args) {
    this.label = args.object as Label;
    this.label.opacity = 0;
  }

  showAnswer() {
    this.label.animate({
      opacity: this.label.opacity === 0 ? 1 : 0,
      delay: this.label.opacity === 0 ? 1000 : 0,
      duration: 1000,
      curve: CoreTypes.AnimationCurve.easeInOut,
    });
  }
}
