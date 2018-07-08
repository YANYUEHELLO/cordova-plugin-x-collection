/*
 * @Author: 玖叁(N.T) 
 * @Date: 2017-10-17 13:43:05 
 * @Last Modified by: 玖叁(N.T)
 * @Last Modified time: 2017-11-15 14:15:35
 */

#import "CDVCollection.h"

@implementation CDVCollection
- (void)goCommentPage:(CDVInvokedUrlCommand *)command {
    NSNumber *appID;
    NSDictionary *params = [command.arguments objectAtIndex:0];
    if ([params objectForKey:@"appID"]) {
        appID = [params objectForKey:@"appID"];
    } else {
        appID = [self getAppInfoByBundleID:@"trackId"];;
    }
    
    if (appID != nil) {
        // 跳轉到評價頁面
        NSString *str2 = [NSString stringWithFormat: @"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",
                          appID];
        //跳转到评论撰写界面
        //NSString *str2 = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", appID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str2]];
    } else {
        [self failWithCallbackID:command.callbackId withMessage:@"Not find application in app store!"];
    }
}

- (void)goUpdateVersionPage:(CDVInvokedUrlCommand *)command {
    NSNumber *appID;
    NSDictionary *params = [command.arguments objectAtIndex:0];
    if ([params objectForKey:@"appID"]) {
        appID = [params objectForKey:@"appID"];
    } else {
        appID = [self getAppInfoByBundleID:@"trackId"];;
    }
    
    if (appID != nil) {
        // 跳轉到應用頁面
        NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/cn/app/id%@?mt=8", appID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    } else {
        [self failWithCallbackID:command.callbackId withMessage:@"Not find application in app store!"];
    }
}

- (void)getVersion:(CDVInvokedUrlCommand *)command {
    NSString *version = [self getAppInfoByBundleID:@"version"];
    
    if (version != nil) {
        [self successWithCallbackID:command.callbackId withMessage:version];
    } else {
        [self failWithCallbackID:command.callbackId withMessage:@"Not find application in app store!"];
    }
}

- (id)getAppInfoByBundleID {
    return [self getAppInfoByBundleID:@""];
}

- (id)getAppInfoByBundleID:(NSString *)key {
    NSDictionary *appInfo = nil;
    NSString *bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleIdentifierKey];
    //添加时间戳解决缓存
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];//转为字符型
    NSString *strURL = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?bundleId=%@&timeString=%@", bundleID,timeString];
    // NSString *strURL = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?bundleId=%@", bundleID];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];



    NSDictionary *dic = [self objectFromJSONDat:data];
    NSArray *resultArray = [dic objectForKey:@"results"];
    if ([resultArray count] > 0 && resultArray != nil) {
        appInfo = [resultArray objectAtIndex:0];
    }
    
    if (appInfo != nil) {
        return [appInfo objectForKey:key];
    }
    
    return appInfo;
}

- (id)objectFromJSONDat:(NSData *)data {
    NSError *decodingError = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&decodingError];
    if (object == nil && decodingError != nil) {
        NSLog(@"Error decoding JSON data");
    }
    return object;
}

- (void)successWithCallbackID:(NSString *)callbackID withMessage:(NSString *)message {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    [self.commandDelegate sendPluginResult:result callbackId:callbackID];
}

- (void)failWithCallbackID:(NSString *)callbackID withMessage:(NSString *)message {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:message];
    [self.commandDelegate sendPluginResult:result callbackId:callbackID];
}

@end
