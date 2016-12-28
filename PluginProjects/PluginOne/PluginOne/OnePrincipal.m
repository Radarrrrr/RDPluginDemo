//
//  OnePrincipal.m
//  PluginOne
//
//  Created by Radar on 2016/12/28.
//  Copyright © 2016年 Radar. All rights reserved.
//

#import "OnePrincipal.h"
#import <UIKit/UIKit.h>

@implementation OnePrincipal

+ (void)run
{
    NSLog(@"plugin one runing!");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The PluginOne Alert" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"done", nil];
    [alert show];
}

@end
