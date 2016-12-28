//
//  MyUtils.h
//  MyFramework
//
//  Created by dang on 15/3/23.
//  Copyright (c) 2015年 Dangdang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUtils : NSObject

- (void)log:(NSString*)message;

+ (void)runLibWith:(NSString*)msg completion:(void (^)(NSString* status))completion;

@end
