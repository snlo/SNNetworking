//
//  NSString+JSON.h
//  NeighborMom
//
//  Created by sunDong on 16/4/29.
//  Copyright © 2016年 WAYOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;
+ (NSString *)jsonStringWithArray:(NSArray *)array;
+ (NSString *)jsonStringWithString:(NSString *) string;
+ (NSString *)jsonStringWithObject:(id) object;

@end
