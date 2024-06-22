import { Component, NO_ERRORS_SCHEMA, inject } from '@angular/core'
import { ImageToken, data } from './data'
import { NativeScriptCommonModule } from '@nativescript/angular';

@Component({
  standalone: true,
  imports: [NativeScriptCommonModule],
  selector: 'parallax-image',
  templateUrl: './parallax-image.component.html',
  schemas: [NO_ERRORS_SCHEMA]
})
export class ParallaxImageComponent {
  image = inject(ImageToken);

  constructor() {
    console.log(this.image)
  }
}
