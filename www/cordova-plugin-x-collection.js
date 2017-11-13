/*
 * @Author: 玖叁(N.T) 
 * @Date: 2017-10-17 13:48:23 
 * @Last Modified by: 玖叁(N.T)
 * @Last Modified time: 2017-11-11 21:40:46
 */
var exec = require('cordova/exec');

module.exports = {
    // 獲取APP 在App store的版本號
    getVersion: function (successCallback, failCallback) {
        exec(successCallback.bind(this), failCallback && failCallback.bind(this), 'CDVCollection', 'getVersion');
    },
    // 跳轉到App對應的評論頁面
    goCommentPage: function (param, failCallback) {
        if (!param) {
            failCallback = param;
            param = {};
        }

        exec(null, failCallback, 'CDVCollection', 'goCommentPage', [param]);
    },
    // 跳轉到App store的更新版本頁面
    goUpdateVersionPage: function (param, failCallback) {
        if (!param) {
            failCallback = param;
            param = {};
        }
        exec(null, failCallback, 'CDVCollection', 'goUpdateVersionPage', [param]);
    }
};
