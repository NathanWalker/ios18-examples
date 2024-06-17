## iOS 18 Highlights with NativeScript

Requires Xcode 16 Beta with iOS 18 simulator.

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