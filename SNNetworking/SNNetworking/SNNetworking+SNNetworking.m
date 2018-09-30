//
//  SNNetworking+SNNetworking.m
//  SNNetworking
//
//  Created by snlo on 2018/5/21.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNetworking+SNNetworking.h"

#import "SNNetworkTool.h"

@implementation SNNetworking (SNNetworking)

#pragma mark -- 测试样例
+ (void)getImageWithimgurl:(NSString *)imgurl
                  progress:(void(^)(double percentage))progress
                   success:(void(^)(id responseObject))success
                   failure:(void(^)(NSError *error))failure {
    
    [SNNetworking getWithUrl:imgurl parameters:nil progress:progress success:success failure:failure];
    
    [SNNetworking sharedManager].manager.responseSerializer = [AFImageResponseSerializer serializer];
    
}

#pragma mark -- cookies相关
+ (void)setCookieWithName:(NSString *)name value:(NSString *)value
{
    if ([self isChinese:value]) {
        NSData * data = [value dataUsingEncoding:NSUTF8StringEncoding];
        value = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    
    [cookieProperties setObject:name forKey:NSHTTPCookieName];
    [cookieProperties setObject:value forKey:NSHTTPCookieValue];
    
    NSString * stringOriginURL = [SNNetworking sharedManager].baseUrl;
    NSString * stringDomain = [stringOriginURL substringFromIndex:[stringOriginURL rangeOfString:@"://"].location + 3];
    
    [cookieProperties setObject:[NSString stringWithFormat:@"%@:888",stringDomain] forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:[NSString stringWithFormat:@"%@:888",stringOriginURL] forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
}

+ (void)setAllCookies {
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"coo - -: %@,  value - :%@",SNString(@"%@",obj.name), SNString(@"%@",obj.value));
        [self setCookieWithName:obj.name value:obj.value];
    }];
}

+ (NSString *)fetchCookieValueFrom:(NSString *)name {
    __block NSString * string = @"NO VALUE FROM NAME";
    [[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([SNString(@"%@",obj.name) isEqualToString:name]) {
            string = SNString(@"%@",obj.value);
            *stop = YES;
        }
    }];
    return string;
}

+ (BOOL)isChinese:(NSString *)aString
{
    if (aString.length < 1) {
        return NO;
    }
    NSString * string = [aString substringToIndex:1];
    int strlength = 0;
    char * p = (char*)[string cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return ((strlength/2)==1) ? YES : NO;
}

@end
