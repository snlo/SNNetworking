//
//  SNNetworking.h
//  SNNetworking
//
//  Created by sunDong on 16/6/30.
//  Copyright © 2016年 sunDong. All rights reserved.
//

#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

#import <Foundation/Foundation.h>

#import "Singletion.h"
#import "NSString+HASH.h"
#import "NSString+JSON.h"
#import "SNTransformer.h"
#import "SNFileManager.h"
#import "SNCachePool.h"

/////////////////////////////////////////////////////////////////////////////////////////////
#if TARGET_IPHONE_SIMULATOR
#define SNLog( s, ... ) NSLog( @"[%@:%d] %@", [[NSString stringWithUTF8String:__FILE__] \
lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define SNLog( s, ... )
#endif

#define SNString( s, ... ) [NSString stringWithCString:[[NSString stringWithFormat:(s), ##__VA_ARGS__] cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding]

/////////////////////////////////////////////////////////////////////////////////////////////

@interface SNNetworking : NSObject

singletonInterface(SNNetworking)

/**
 *  对于http这种非安全的链接
 *
 *  在info.plist中添加
 *  App Transport Security Settings
 *  Allow Arbitrary Loads 属设置为 YES
 */

/**
 *  指定返回数据类型 manager.responseSerializer = [X serializer];
 *  X
 *  AFHTTPResponseSerializer            //data 二进制格式
 *  AFJSONResponseSerializer            //JSON 默认返回的是json数据
 *  AFXMLParserResponseSerializer       //XML,只能返回XMLParser,还需要NSParser自己通过代理方法解析
 *  AFXMLDocumentResponseSerializer     //XML(Mac:OS X)
 *  AFPropertyListResponseSerializer    //属性列表PList(是一种特殊的XML,解析起来相对容易)
 *  AFImageResponseSerializer           //image
 *  AFCompoundResponseSerializer        //组合的形式
 */

@property (nonatomic) AFHTTPSessionManager * manager;

//GET
+ (void)getWithUrl:(NSString *)url
        parameters:(id)parameters
          progress:(void(^)(double percentage))progress
           success:(void(^)(id responseObject))success
           failure:(void(^)(NSError *error))failure;

//POST
+ (void)postWithUrl:(NSString *)url
         parameters:(id)parameters
           progress:(void(^)(double percentage))progress
            success:(void(^)(id responseObject))success
            failure:(void(^)(NSError *error))failure;

//upload
+ (void)uploadWithUrl:(NSString *)url
           parameters:(id)parameters
                 data:(NSData *)data
       fileSuffixName:(NSString *)fileSuffixName
             progress:(void(^)(double percentage))progress
              success:(void(^)(id responseObject))success
              failure:(void(^)(NSError *error))failure;

//download
+ (void)downloadWithUrl:(NSString *)url
           fileDownPath:(NSString *)fileDownPath
               progress:(void(^)(double percentage))progress
                success:(void(^)(id responseObject))success
                failure:(void(^)(NSError *error))failure;

//cancel request
+ (void)cancelRequest;

//开始监听网络，建议延时开始；
+ (void)startNetMonitoring;

//监听结果
+ (void)netMonitoringWithResultBlock:(void(^)(AFNetworkReachabilityStatus status, NSString * statusValue))resultBlock;

//结束监听
+ (void)stopNetMonitoring;

@end

#define kBASEURL @"http://192.168..."
