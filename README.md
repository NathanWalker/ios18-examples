## iOS 18 Highlights with NativeScript

Requires Xcode 16 Beta with iOS 18 simulator.

https://github.com/NathanWalker/ios18-examples/assets/457187/6b7862cb-cb25-401e-a39e-d62f3c4640e3

https://github.com/NathanWalker/ios18-examples/assets/457187/4b859090-e684-4718-97d5-e4b96ac41a7b

### Metal + SwiftUI

Example from WWDC24 10151:
https://developer.apple.com/videos/play/wwdc2024/10151/

#### Try with HMR (Hot Module Replacement):

Adjust `app-routing.module` from:

```ts
{ path: '', redirectTo: '/items', pathMatch: 'full' },
```

to:

```ts
{ path: '', redirectTo: '/metal', pathMatch: 'full' },
```

Run with: `ns debug ios`

Try changing `imageSrc` to different included assets in `App_Resources/iOS/Assets.xcassets` such as:
`Lily Pads`, `Fish`, `Succulent`, `palm_tree`.

```html
<SwiftUI
    swiftId="rippleView"
    [data]="{ imageSrc: 'Lily Pads' }"
```

#### Try without HMR:

```bash
ns debug ios --no-hmr
```

### SF Symbols 6

https://developer.apple.com/sf-symbols/

#### Try with HMR (Hot Module Replacement):

Adjust `app-routing.module` from:

```ts
{ path: '', redirectTo: '/items', pathMatch: 'full' },
```

to:

```ts
{ path: '', redirectTo: '/sf-symbols', pathMatch: 'full' },
```

Now run with: `ns debug ios`

#### Try without HMR:

```bash
ns debug ios --no-hmr
```

### Font weight animation

https://x.com/MengTo/status/1802651973344456822

#### Try with HMR (Hot Module Replacement):

Adjust `app-routing.module` from:

```ts
{ path: '', redirectTo: '/items', pathMatch: 'full' },
```

to:

```ts
{ path: '', redirectTo: '/animated-text', pathMatch: 'full' },
```

Now run with: `ns debug ios`

#### Try without HMR:

```bash
ns debug ios --no-hmr
```
