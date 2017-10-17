/*
 * @Author: 玖叁(N.T) 
 * @Date: 2017-10-17 13:43:05 
 * @Last Modified by: 玖叁(N.T)
 * @Last Modified time: 2017-10-17 16:12:51
 */

#import "CDVCollection.h"

@implementation CDVCollection
- (void)goCommentPage:(CDVInvokedUrlCommand *)command {
    NSNumber *appID = [self getAppInfoByBundleID:@"trackId"];
    
    if (appID != nil) {
        // 跳轉到評價頁面
        NSString *str2 = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id;=%@",
                          appID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str2]];
    }
}

- (void)goUpdateVersionPage:(CDVInvokedUrlCommand *)command {
    NSNumber *appID = [self getAppInfoByBundleID:@"trackId"];
    
    if (appID != nil) {
        // 跳轉到應用頁面
        NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@", appID];
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
        [self failWithCallbackID:command.callbackId withMessage:@"can't get app info"];
        [self failWithCallbackID:command.callbackId withMessage:@"Not find application in app store!"];
    }
}

- (id)getAppInfoByBundleID {
    return [self getAppInfoByBundleID:@""];
}

- (id)getAppInfoByBundleID:(NSString *)key {
    NSDictionary *appInfo = nil;
    NSString *bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleIdentifierKey];
    NSString *strURL = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?bundleId=%@", bundleID];
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
