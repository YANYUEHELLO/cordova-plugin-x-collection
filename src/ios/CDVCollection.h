/*
 * @Author: 玖叁(N.T) 
 * @Date: 2017-10-17 13:42:49 
 * @Last Modified by: 玖叁(N.T)
 * @Last Modified time: 2017-10-17 15:55:42
 */
 #import <Cordova/CDV.h>
 
 @interface CDVCollection : CDVPlugin
 
 - (void)getVersion:(CDVInvokedUrlCommand *)command;
 - (void)goUpdateVersionPage:(CDVInvokedUrlCommand *)command;
 - (void)goCommentPage:(CDVInvokedUrlCommand *)command;
 
 @end
 