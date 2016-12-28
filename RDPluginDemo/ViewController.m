//
//  ViewController.m
//  RDPluginDemo
//
//  Created by Radar on 2016/12/28.
//  Copyright © 2016年 Radar. All rights reserved.
//

#import "ViewController.h"
#import <Dylib/Dylib.h>
#import <MyFramework/MyFramework.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Person *per = [[Person alloc] init];
    [per run];
    
    [MyUtils runLibWith:@"我是一个嵌入的动态库" completion:^(NSString *status) {
        NSLog(@"status: %@", status);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
