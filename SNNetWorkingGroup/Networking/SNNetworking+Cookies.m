//
//  SNNetworking+Cookies.m
//  Ljiamm
//
//  Created by sunDong on 16/11/21.
//  Copyright © 2016年 sunDong. All rights reserved.
//

#import "SNNetworking+Cookies.h"

@implementation SNNetworking (Cookies)

+ (void)setCookieWithName:(NSString *)name value:(NSString *)value
{
    if ([self isChinese:value]) {
        NSData * data = [value dataUsingEncoding:NSUTF8StringEncoding];
        value = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    
    [cookieProperties setObject:name forKey:NSHTTPCookieName];
    
    [cookieProperties setObject:value forKey:NSHTTPCookieValue];
    
    [cookieProperties setObject:@"192.168..." forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"http://192.168..." forKey:NSHTTPCookieOriginURL];
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

//判断string是否为中文
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
