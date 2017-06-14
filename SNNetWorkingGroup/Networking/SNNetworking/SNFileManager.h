//
//  SNFileManager.h
//  AFNetworkingTest
//
//  Created by sunDong on 16/7/1.
//  Copyright © 2016年 sunDong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNFileManager : NSObject

/**
 *  通过创建的缓存文件夹名获取沙盒路径
 *
 *  @param fileName 要创建的缓存文件夹名称
 *  @return 缓存沙盒路径
 */
+ (NSString *)pathForDocumentWithComponent:(NSString *)fileName;


/**
 获取当前时间
 */
+ (NSString *)currentTime;

@end

#define kSNCacheName @"SNCache"
