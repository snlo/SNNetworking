//
//  SNNetworking+image.h
//  Ljiamm
//
//  Created by sunDong on 16/11/23.
//  Copyright © 2016年 sunDong. All rights reserved.
//

#import "SNNetworking.h"
//#import "SDImageCache.h"
@interface SNNetworking (image)

/**
 *  下载单张图片
 */
+ (void)getImageWithimgurl:(NSString *)imgurl
                  progress:(void(^)(double percentage))progress
                   success:(void(^)(id responseObject))success
                   failure:(void(^)(NSError *error))failure;

/**
 *  sn_test_image
 */
+ (void)getSN_TEST_ImageWithimgProgress:(void(^)(double percentage))progress
                                success:(void(^)(id responseObject))success
                                failure:(void(^)(NSError *error))failure;


@end
