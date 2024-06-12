import { NativeScriptConfig } from '@nativescript/core';

export default {
  id: 'org.nativescript.ios18examples',
  appPath: 'src',
  appResourcesPath: 'App_Resources',
  android: {
    v8Flags: '--expose_gc',
    markingMode: 'none'
  }
} as NativeScriptConfig;