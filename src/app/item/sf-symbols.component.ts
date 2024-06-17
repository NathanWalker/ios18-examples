import { Component } from "@angular/core";
import { ImageSymbolEffect } from "@nativescript/core";

@Component({
  selector: "sf-symbols",
  templateUrl: "./sf-symbols.component.html",
})
export class SFSymbolsComponent {
  symbolWiggleEffect: ImageSymbolEffect;
  symbolBounceEffect: ImageSymbolEffect;
  symbolBreathEffect: ImageSymbolEffect;
  symbolRotateEffect: ImageSymbolEffect;
  symbolColorEffect: ImageSymbolEffect;
  currentMusicSymbol: string;
  musicSymbolOn = "apple.haptics.and.music.note";
  musicSymbolOff = "apple.haptics.and.music.note.slash";

  ngAfterViewInit() {
    // start effects whenever desired
    setTimeout(() => {
      if (__APPLE__) {
        this.symbolWiggleEffect = {
          effect: NSSymbolWiggleEffect.effect(),
          start: true,
        };
        this.symbolBounceEffect = {
          effect: NSSymbolBounceEffect.bounceDownEffect(),
          start: true,
        };
        this.symbolBreathEffect = {
          effect: NSSymbolBreatheEffect.effect(),
          start: true,
        };
        this.symbolRotateEffect = {
          effect: NSSymbolRotateEffect.effect(),
          start: true,
        };
        this.symbolColorEffect = {
          effect: NSSymbolVariableColorEffect.effect().effectWithCumulative(),
          start: true,
        };
        this.currentMusicSymbol = this.musicSymbolOn;
      }
    }, 1000);
  }

  startSymbolTransition(args) {
    const uiImageView = args.object.ios as UIImageView;
    this.currentMusicSymbol =
      this.currentMusicSymbol === this.musicSymbolOn
        ? this.musicSymbolOff
        : this.musicSymbolOn;
    uiImageView.setSymbolImageWithContentTransition(
      UIImage.systemImageNamed(this.currentMusicSymbol),
      NSSymbolReplaceContentTransition.magicTransitionWithFallback(
        NSSymbolReplaceContentTransition.transition()
      )
    );
  }
}
