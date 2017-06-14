//
//  SNNetworking+image.m
//  Ljiamm
//
//  Created by sunDong on 16/11/23.
//  Copyright © 2016年 sunDong. All rights reserved.
//

#import "SNNetworking+image.h"

@implementation SNNetworking (image)

/**
 *  sn_test_image
 */
+ (void)getSN_TEST_ImageWithimgProgress:(void(^)(double percentage))progress
                           success:(void(^)(id responseObject))success
                           failure:(void(^)(NSError *error))failure
{
    [SNNetworking sharedManager].manager.responseSerializer = [AFImageResponseSerializer serializer];
    
    [[SNNetworking sharedManager].manager GET:[NSString stringWithFormat:@"%@%@",kBASEURL,@"verificationCode.jpg"]
                                        parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
         
         if (progress) progress(downloadProgress.fractionCompleted);
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         NSLog(@"responseObject -- image -- \n%@",responseObject);
         
         if (success) success(responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         NSLog(@"get error --> %@",[SNTransformer valueFromError:error]);
         
         if (failure) failure(error);
         
     }];
}

//image_test :http://img.blog.csdn.net/20130506190214009

+ (void)getImageWithimgurl:(NSString *)imgurl
                  progress:(void(^)(double percentage))progress
                   success:(void(^)(id responseObject))success
                   failure:(void(^)(NSError *error))failure
{
    [SNNetworking sharedManager].manager.responseSerializer = [AFImageResponseSerializer serializer];
    
    [[SNNetworking sharedManager].manager
     GET:imgurl parameters:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) progress(downloadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject -- image -- \n%@",responseObject);
        
        if (success) success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"get error --> %@",[SNTransformer valueFromError:error]);
        
        if (failure) failure(error);
        
    }];
    
}


@end
