# cordova-plugin-x-collection

This is a cordova-plugin collection that include some common functions on our app development process.

# Feature

## iOS

- Get app version in the App Store.
- Go App Store page to update app version.
- Go application comment page.

# Install

```bash
cordova plugin add cordova-plugin-x-collection
```
or

```bash
cordova plugin add cordova-plugin-x-collection
```

# Usage

```Javascript
// check app version, needs install `cordova-plugin-dialogs` plugin
if (navigator && XCollection) {
    function onConfirm(buttonIndex) {
        if (buttonIndex === 1) {
            this.goUpdateVersionPage(function (error) {
                // error callback
            });
        }
    }

    XCollection.getVersion(function (version) {
        navigator.notification.confirm(
            '你的APPv' + version + '已上传，赶快去体验最新版本吧！', // message
            onConfirm.bind(this),            // callback to invoke with index of button pressed
            '发现新版本',           // title
            ['更新','取消']     // buttonLabels
        );
    });
}

```

![](http://oweglvqu7.bkt.clouddn.com/blog/2017-10-17-8798ED88-4EA6-4A4D-B0C0-15E16ADF4809.png)

```Javascript

if (XCollection) {
    XCollection.goCommentPage(function (error) {
        //error callback
    });
}

```

