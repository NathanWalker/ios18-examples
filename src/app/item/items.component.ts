import { Component, inject } from "@angular/core";
import { RouterExtensions } from "@nativescript/angular";

@Component({
  selector: "ns-items",
  templateUrl: "./items.component.html",
})
export class ItemsComponent {
  routerExt = inject(RouterExtensions);

  goTo(route: string) {
    this.routerExt.navigate([route]);
  }
}
