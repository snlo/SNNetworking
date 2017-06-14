//
//  SNNetworking+helper.m
//  Ljiamm
//
//  Created by sunDong on 16/11/23.
//  Copyright © 2016年 sunDong. All rights reserved.
//

#import "SNNetworking+helper.h"

@implementation SNNetworking (helper)

+ (void)getStoreListSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    [SNNetworking sharedManager].manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [SNNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",kBASEURL,@"store/getStoreList.data"]
                   parameters:@{@"opt":@"list",
                                @"cell":@"13888888888",
                                } progress:^(double percentage) {
                                    
                                } success:^(id responseObject) {
                                    NSLog(@"%s - responseObject - - %@",__func__,SNString(@"%@",responseObject));
                                    if (success) {
                                        success(responseObject);
                                    }
                                    
                                } failure:^(NSError *error) {
                                    NSLog(@"error - - - %@",error);
                                    if (error) {
                                        failure(error);
                                    }
                                }];
}
+ (void)httpsTest {
    [SNNetworking postWithUrl:[NSString stringWithFormat:@"%@%@",@"https://httpbin.org/",@"post"]
                   parameters:@{@"key": @"value"} progress:^(double percentage) {
                                    
                                } success:^(id responseObject) {
                                    NSLog(@"%s - responseObject - - %@",__func__,SNString(@"%@",responseObject));
                                    
                                } failure:^(NSError *error) {
                                    NSLog(@"error - - - %@",error);
                                }];

}

@end
