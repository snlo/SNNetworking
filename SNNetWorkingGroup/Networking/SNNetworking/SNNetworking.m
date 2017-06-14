//
//  SNNetworking.m
//  SNNetworking
//
//  Created by sunDong on 16/6/30.
//  Copyright © 2016年 sunDong. All rights reserved.
//

#import "SNNetworking.h"


@implementation SNNetworking

singletonImplemention(SNNetworking)

#pragma mark -- public methods

//GET
+ (void)getWithUrl:(NSString *)url parameters:(id)parameters progress:(void(^)(double percentage))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [[SNNetworking sharedManager].manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {

        if (progress) progress(downloadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (success) success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"get error --> %@",[SNTransformer valueFromError:error]);
        
        if (failure) failure(error);
        
    }];
    
}

//POST
+ (void)postWithUrl:(NSString *)url parameters:(id)parameters progress:(void(^)(double percentage))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [[SNNetworking sharedManager].manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        NSLog(@"post error --> %@",[SNTransformer valueFromError:error]);
        
        if (failure) failure(error);
        
    }];
}

//upload
+ (void)uploadWithUrl:(NSString *)url parameters:(id)parameters data:(NSData *)data fileSuffixName:(NSString *)fileSuffixName progress:(void(^)(double percentage))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    NSString * name = [[SNFileManager currentTime] md5String];
    
    NSString * fileName = [NSString stringWithFormat:@"%@.%@",name,fileSuffixName];
    
    [[SNNetworking sharedManager].manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"application/octet-stream"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"post error --> %@",[SNTransformer valueFromError:error]);
        
        if (failure) failure(error);
        
    }];
}

//download
+ (void)downloadWithUrl:(NSString *)url fileDownPath:(NSString *)fileDownPath progress:(void(^)(double percentage))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

    [[[SNNetworking sharedManager].manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:fileDownPath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"downloaded response --> %@",response);
            if (success) success(filePath);
            
        } else {
            
            NSLog(@"downloaded error --> %@",[SNTransformer valueFromError:error]);
            
            if (failure) failure(error);

        }
    }] resume];
    
}

//cancel request
+ (void)cancelRequest
{
    [[SNNetworking sharedManager].manager.operationQueue cancelAllOperations];
}

//开始监听网络，建议延时开始；
+ (void)startNetMonitoring
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)dealloc {
    if (_manager) {
        [_manager invalidateSessionCancelingTasks:YES];
    }
}

//监听结果
+ (void)netMonitoringWithResultBlock:(void(^)(AFNetworkReachabilityStatus status,NSString * statusValue))resultBlock
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString * statusValue = [NSString string];
        switch(status) {
            case AFNetworkReachabilityStatusNotReachable:{
                statusValue = @"无网络";
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                statusValue = @"WiFi网络";
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                statusValue = @"无线网络";
                break;
            }
            default:
                statusValue = @"无网络";
                break;
        }
        if (resultBlock) resultBlock(status, statusValue);
    }];
    
}

//结束监听
+ (void)stopNetMonitoring
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

#pragma mark -- getter

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer new];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain"
                                                              ,@"application/json"
                                                              ,@"text/json"
                                                              ,@"text/javascript"
                                                              ,@"text/html"
                                                              ,@"image/png"
                                                              ,@"image/jpeg"
                                                              ,@"application/rtf"
                                                              ,@"image/gif"
                                                              ,@"application/zip"
                                                              ,@"audio/x-wav"
                                                              ,@"image/tiff"
                                                              ,@"application/x-shockwave-flash"
                                                              ,@"application/vnd.ms-powerpoint"
                                                              ,@"video/mpeg"
                                                              ,@"video/quicktime"
                                                              ,@"application/x-javascript"
                                                              ,@"application/x-gzip"
                                                              ,@"application/x-gtar"
                                                              ,@"application/msword"
                                                              ,@"text/css"
                                                              ,@"video/x-msvideo"
                                                              ,@"text/xml"
                                                              , nil];
        _manager.requestSerializer.timeoutInterval = 20.f;
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _manager;
}


@end
