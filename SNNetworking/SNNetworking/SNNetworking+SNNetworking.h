//
//  SNNetworking+SNNetworking.h
//  SNNetworking
//
//  Created by snlo on 2018/5/21.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "SNNetworking.h"

@interface SNNetworking (SNNetworking)

/**
 下载一张图，建议自行实现
 */
+ (void)getImageWithimgurl:(NSString *)imgurl
                  progress:(void(^)(double percentage))progress
                   success:(void(^)(id responseObject))success
                   failure:(void(^)(NSError *error))failure;

/**
 设置cookies
 @param name 字段名
 @param value 字段值
 */
+ (void)setCookieWithName:(NSString *)name value:(NSString *)value;

/**
 获取cookies中某字段值
 */
+ (NSString *)fetchCookieValueFrom:(NSString *)name;

@end
