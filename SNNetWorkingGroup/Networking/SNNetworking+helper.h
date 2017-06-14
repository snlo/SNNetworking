//
//  SNNetworking+helper.h
//  Ljiamm
//
//  Created by sunDong on 16/11/23.
//  Copyright © 2016年 sunDong. All rights reserved.
//

#import "SNNetworking.h"

@interface SNNetworking (helper)


/**
 登录列表

 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getStoreListSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;

+ (void)httpsTest;

@end
