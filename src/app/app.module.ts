import { NgModule, NO_ERRORS_SCHEMA } from '@angular/core'
import { NativeScriptModule } from '@nativescript/angular'

import { AppRoutingModule } from './app-routing.module'
import { AppComponent } from './app.component'
import { ItemsComponent } from './item/items.component'
import { MetalComponent } from './item/metal.component'
import { SFSymbolsComponent } from './item/sf-symbols.component'
import { AnimatedTextComponent } from './item/animated-text.component'
import { SiriComponent } from './item/siri.component'
import { ParallaxComponent } from "./item/parallax/parallax.component";

@NgModule({
  bootstrap: [AppComponent],
  imports: [NativeScriptModule, AppRoutingModule],
  declarations: [AppComponent, ItemsComponent, MetalComponent, SFSymbolsComponent, AnimatedTextComponent, SiriComponent, ParallaxComponent],
  providers: [],
  schemas: [NO_ERRORS_SCHEMA],
})
export class AppModule {}
