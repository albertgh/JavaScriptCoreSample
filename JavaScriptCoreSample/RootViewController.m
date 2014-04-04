//
//  RootViewController.m
//  JavaScriptCoreSample
//
//  Created by Albert Chu on 14-4-4.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

#import "RootViewController.h"

#import "NativeCallJavaScriptViewController.h"
#import "JavaScriptCallNativeViewController.h"

@interface RootViewController ()

@end


@implementation RootViewController

#pragma mark - Action Methods

- (void)nativeCallJavaScriptButtonTapped:(id)sender
{
    NativeCallJavaScriptViewController *viewController =  [NativeCallJavaScriptViewController new];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)javaScriptCallNativeButtonTapped:(id)sender
{
    JavaScriptCallNativeViewController *viewController =  [JavaScriptCallNativeViewController new];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Samples";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //-- 按钮 ---------------------------------------------------------------------------------------
    UIButton *nativeCallJavaScriptButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nativeCallJavaScriptButton.frame = CGRectMake(70.0, 150.0, 180.0, 40.0);
    nativeCallJavaScriptButton.backgroundColor = [UIColor colorWithRed:0.1 green:0.7 blue:1.0 alpha:1.0];
    
    [nativeCallJavaScriptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nativeCallJavaScriptButton setTitle:@"Native Call JavaScript" forState:UIControlStateNormal];
    [nativeCallJavaScriptButton addTarget:self action:@selector(nativeCallJavaScriptButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nativeCallJavaScriptButton];
    //---------------------------------------------------------------------------------------------;
    
    
    //-- 按钮 ---------------------------------------------------------------------------------------
    UIButton *javaScriptCallNativeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    javaScriptCallNativeButton.frame = CGRectMake(70.0, 300.0, 180.0, 40.0);
    javaScriptCallNativeButton.backgroundColor = [UIColor orangeColor];
    
    [javaScriptCallNativeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [javaScriptCallNativeButton setTitle:@"JavaScript Call Native" forState:UIControlStateNormal];
    [javaScriptCallNativeButton addTarget:self action:@selector(javaScriptCallNativeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:javaScriptCallNativeButton];
    //---------------------------------------------------------------------------------------------;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
