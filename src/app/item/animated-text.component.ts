import { Component } from '@angular/core'

@Component({
  selector: 'animated-text',
  templateUrl: './animated-text.component.html',
})
export class AnimatedTextComponent {
  line1 = { 
    text: 'NativeScript provides',
    targetFontSize: 22,
    minimumFontSize: 22,
    delayBetweenCharacter: 1,
    toggle: false
  };
  line2 = {
    text: 'a best of all worlds approach',
    targetFontSize: 22,
    minimumFontSize: 22,
    delayBetweenCharacter: 1,
    toggle: false
  }
  line3 = {
    text: 'to development whether you',
    targetFontSize: 22,
    minimumFontSize: 22,
    delayBetweenCharacter: 1,
    toggle: false
  }
  line4 = {
    text: 'prefer JavaScript, TypeScript,',
    targetFontSize: 20,
    minimumFontSize: 20,
    delayBetweenCharacter: 8,
    toggle: false
  }
  line5 = {
    text: 'Swift, Obj-C, Kotlin, Java or Dart.',
    targetFontSize: 20,
    minimumFontSize: 20,
    delayBetweenCharacter: 1,
    toggle: false
  }
  tryIt() {
    this.line1 = {
      ...this.line1,
      toggle: !this.line1.toggle
    }
    this.line2 = {
      ...this.line2,
      toggle: !this.line2.toggle
    }
    this.line3 = {
      ...this.line3,
      toggle: !this.line3.toggle
    }
    this.line4 = {
      ...this.line4,
      toggle: !this.line4.toggle
    }
    this.line5 = {
      ...this.line5,
      toggle: !this.line5.toggle
    }
  }
}
