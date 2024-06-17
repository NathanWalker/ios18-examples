import { NgModule } from '@angular/core'
import { Routes } from '@angular/router'
import { NativeScriptRouterModule } from '@nativescript/angular'

import { ItemsComponent } from './item/items.component'
import { MetalComponent } from './item/metal.component'
import { SFSymbolsComponent } from './item/sf-symbols.component'
import { AnimatedTextComponent } from './item/animated-text.component'

const routes: Routes = [
  { path: '', redirectTo: '/items', pathMatch: 'full' },
  { path: 'items', component: ItemsComponent },
  { path: 'metal', component: MetalComponent },
  { path: 'sf-symbols', component: SFSymbolsComponent },
  { path: 'animated-text', component: AnimatedTextComponent },
]

@NgModule({
  imports: [NativeScriptRouterModule.forRoot(routes)],
  exports: [NativeScriptRouterModule],
})
export class AppRoutingModule {}
