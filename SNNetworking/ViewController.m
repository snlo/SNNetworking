//
//  ViewController.m
//  SNNetworking
//
//  Created by snlo on 2018/5/8.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "ViewController.h"

#import "SNNetworking.h"

#import "UIKit+AFNetworking.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonTest;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTest;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//	pod trunk push SNNetworking.podspec --verbose --allow-warnings --use-libraries
    
    NSString * url = @"http://i6.download.fd.pchome.net/t_320x520/g1/M00/05/05/oYYBAFIJtZWIT-o6AAPA_gqRV2gAAAxnQCO6R4AA8EW364.jpg";
    [SNNetworking sharedManager].baseUrl = @"http://i6.download.fd.pchome.net/";
    
    [self.buttonTest setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:url]];
//    [NSString stringWithFormat:@"%@%@",[SNNetworking sharedManager].baseUrl,url]
    [SNNetworking getImageWithimgurl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538297604133&di=d40c527784e7aeee3682f9ae986253b8&imgtype=0&src=http%3A%2F%2Fpic.pptbz.com%2F201506%2F2015070581208537.JPG" progress:^(double percentage) {
        NSLog(@"%f",percentage);
    } success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[UIImage class]]) {
            self.imageViewTest.image = responseObject;
        }
    } failure:^(NSError *error) {

    }];
    
    
    
}

- (IBAction)handleButtonTest:(UIButton *)sender {
    [sender setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538297604133&di=d40c527784e7aeee3682f9ae986253b8&imgtype=0&src=http%3A%2F%2Fpic.pptbz.com%2F201506%2F2015070581208537.JPG"]];
    
    [SNNetworking getImageWithimgurl:@"http://i6.download.fd.pchome.net/t_320x520/g1/M00/05/05/oYYBAFIJtZWIT-o6AAPA_gqRV2gAAAxnQCO6R4AA8EW364.jpg" progress:^(double percentage) {
        NSLog(@"%f",percentage);
    } success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[UIImage class]]) {
            self.imageViewTest.image = responseObject;
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
