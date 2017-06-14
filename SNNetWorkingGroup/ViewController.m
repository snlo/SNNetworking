//
//  ViewController.m
//  SNNetWorkingGroup
//
//  Created by sunDong on 2017/2/22.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "ViewController.h"

#import "SNNetworking+Cookies.h"
#import "SNNetworking+image.h"
#import "SNNetworking+helper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [SNNetworking httpsTest];
    
    [SNNetworking getStoreListSuccess:^(id responseObject) {
        //处理成功
    } failure:^(NSError *error) {
        //处理失败
    }];
    
    //图片试例
    [SNNetworking getSN_TEST_ImageWithimgProgress:^(double percentage) {
        //下载进度
    } success:^(id responseObject) {
        //下载完成
    } failure:^(NSError *error) {
        //出现了错误
    }];
}



@end
