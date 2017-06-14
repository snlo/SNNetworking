//
//  SNFileManager.m
//  AFNetworkingTest
//
//  Created by sunDong on 16/7/1.
//  Copyright © 2016年 sunDong. All rights reserved.
//

#import "SNFileManager.h"

#define kSNCachePath @""

@implementation SNFileManager

// 获取沙盒路径
+ (NSString *)pathForDocumentWithComponent:(NSString *)fileName {
    
    NSString *fullPath = nil;
    
    if (fileName && [fileName length]) {
        
        NSString *path = NSHomeDirectory();
        
        NSString *cacheDiretory= [path stringByAppendingPathComponent:@"Library/Caches/"];
        
        cacheDiretory = [cacheDiretory stringByAppendingPathComponent:kSNCacheName];
        
        fullPath = [cacheDiretory stringByAppendingPathComponent:fileName];
        
    } else {
        
        fullPath = kSNCachePath;
        
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:fullPath]) {
        
        NSError *err = nil;
        
        if ([fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:&err]) {
            
            return [fullPath stringByAppendingPathComponent:fileName];
            
        } else {
            
            [fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:&err];
            
            return [fullPath stringByAppendingPathComponent:fileName];
        }
    }
    
    fullPath = [fullPath stringByAppendingPathComponent:fileName];
    
    return fullPath;
}



#pragma mark -- 小秘
+ (NSString *)currentTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

@end
