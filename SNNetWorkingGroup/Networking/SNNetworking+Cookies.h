//
//  SNNetworking+Cookies.h
//  Ljiamm
//
//  Created by sunDong on 16/11/21.
//  Copyright © 2016年 sunDong. All rights reserved.
//

#import "SNNetworking.h"

@interface SNNetworking (Cookies)

+ (void)setCookieWithName:(NSString *)name value:(NSString *)value;

+ (void)setAllCookies;

@end
