//
//  NSObject+SNFoundation.h
//  SNFoundation
//
//  Created by snlo on 2018/5/23.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SNFoundation)

/**
 替换某个类中的某个方法
 */
void sn_replaceMethodFromNew(Class aClass, SEL aMethod, SEL newMethod);

@end
