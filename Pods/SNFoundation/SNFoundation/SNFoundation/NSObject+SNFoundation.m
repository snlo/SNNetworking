//
//  NSObject+SNFoundation.m
//  SNFoundation
//
//  Created by snlo on 2018/5/23.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "NSObject+SNFoundation.h"

#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (SNFoundation)

void sn_replaceMethodFromNew(Class aClass, SEL aMethod, SEL newMethod) {
    Method aMethods = class_getInstanceMethod(aClass, aMethod);
    Method newMethods = class_getInstanceMethod(aClass, newMethod);
    
    if(class_addMethod(aClass, aMethod, method_getImplementation(newMethods), method_getTypeEncoding(newMethods))) {
        class_replaceMethod(aClass, newMethod, method_getImplementation(aMethods), method_getTypeEncoding(aMethods));
    } else {
        method_exchangeImplementations(aMethods, newMethods);
    }
}

@end
