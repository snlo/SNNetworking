//
//  SNTransformer.m
//  AFNetworkingTest
//
//  Created by sunDong on 16/7/1.
//  Copyright © 2016年 sunDong. All rights reserved.
//

#import "SNTransformer.h"

@implementation SNTransformer

+ (NSString *)stringFromResponseObject:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        
        responseObject = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    } else if ([responseObject isKindOfClass:[NSURL class]]) {
        
        responseObject = [NSString stringWithFormat:@"%@",responseObject];
        
    } else {
        
        responseObject = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    }
    return responseObject;
}

+ (NSDictionary *)dictionaryFromDataPath:(NSString *)path
{
    NSData *data = [[NSMutableData alloc]initWithContentsOfFile:path];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    
    NSDictionary *dic = [unarchiver decodeObjectForKey:@"talkData"];
    
    [unarchiver finishDecoding];
    
    return dic;
}

+ (NSDictionary *)dictionaryFromData:(NSData *)data
{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    
    NSDictionary *dic = [unarchiver decodeObjectForKey:@"talkData"];
    
    [unarchiver finishDecoding];
    
    return dic;
}

//遍历error，找出错误信息
+ (NSMutableDictionary *)valueFromError:(NSError *)error
{
    NSMutableDictionary * errorDic = [NSMutableDictionary dictionary];
    
    if (error.userInfo.allKeys.count == 0) {
        
        [errorDic setObject:@"unknown error" forKey:@"unknown error"];
        
        return errorDic;
    }
    for (NSString * key in error.userInfo.allKeys) {
        
        //if key begin with "com.alamofire", break;
        if (![key hasPrefix:@"com.alamofire"]) [errorDic setObject:error.userInfo[key] forKey:key];
        
    }
    return errorDic;
}

@end
