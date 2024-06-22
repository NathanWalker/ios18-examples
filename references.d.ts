/// <reference path="./node_modules/@nativescript/types-android/lib/android-31.d.ts" />
/// <reference path="./node_modules/@nativescript/types-ios/index.d.ts" />
/// <reference path="./node_modules/@nativescript/types-ios/lib/ios/objc-x86_64/objc!Symbols.d.ts" />

// Provided by @nativescript/core since 8.7
declare class NativeScriptViewFactory extends NSObject {
    static shared: NativeScriptViewFactory;
    static initShared();
    views: NSMutableDictionary<string, any>;
    viewCreator: (id: string) => void;
    viewDestroyer: (id: string) => void;
  }