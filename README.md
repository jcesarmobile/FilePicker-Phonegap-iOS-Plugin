FilePicker Phonegap iOS Plugin
================================

This plugin makes possible to pick files from iCloud or other document providers

The file is copied to a temp folder, if you want to keep it, copy the file to a persistent location

It's only available for iOS 8


Installation:
============

cordova plugin add https://github.com/jcesarmobile/FilePicker-Phonegap-iOS-Plugin.git


Usage:
=====

Pick a file
===========

If you don't pass any params, public.data UTI will be used

```
window.FilePicker.pickFile(successCallback,errorCallback);
```

You can pass the UTI as string
```
window.FilePicker.pickFile(successCallback,errorCallback,"public.data");
```

If you want to pass more than one UTI you can pass an array of strings
```
var utis = ["public.data", "public.audio"];
window.FilePicker.pickFile(successCallback,errorCallback,utis);
```

successCallback will bring the file url as string
errorCallback will bring an error message as string


See all the available UTIs https://developer.apple.com/library/ios/documentation/Miscellaneous/Reference/UTIRef/Articles/System-DeclaredUniformTypeIdentifiers.html

Prerequisites
=============

Before your app can use the document picker, you must turn on the iCloud Documents capabilities in Xcode.  

![](https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/DocumentPickerProgrammingGuide/Art/Enabling%20iCloud%20Documents_2x.png)

For more information: https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/DocumentPickerProgrammingGuide/Introduction/Introduction.html