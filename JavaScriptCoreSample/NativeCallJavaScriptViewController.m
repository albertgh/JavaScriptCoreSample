//
//  NativeCallJavaScriptViewController.m
//  JavaScriptCoreSample
//
//  Created by Albert Chu on 14-4-4.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

#import "NativeCallJavaScriptViewController.h"

@interface NativeCallJavaScriptViewController ()

@property (strong, nonatomic) UITextField *inputNumberTextField;
@property (strong, nonatomic) UILabel *resultLabel;

@property (strong, nonatomic) JSContext *context;

@end


@implementation NativeCallJavaScriptViewController


#pragma mark - Action Methods

- (void)leftBarButtonItemPressed:(UIBarButtonItem *)barButtonItem
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buttonClicked:(id)sender
{
    NSNumber *inputNumber = [NSNumber numberWithInteger:[self.inputNumberTextField.text integerValue]];
    JSValue *function = [self.context objectForKeyedSubscript:@"test"];
    JSValue *result = [function callWithArguments:@[inputNumber]];
    
    self.resultLabel.text = [NSString stringWithFormat:@"%@", [result toNumber]];
}


#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"NativeCallJavaScript";
        
        NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"test.js"];
        
        NSString *testScript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        self.context = [[JSContext alloc] init];
        [self.context evaluateScript:testScript];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.7 green:0.8 blue:0.8 alpha:1.000];
    
    //-- leftItem ------------------------------------------------------------------------------
    UIBarButtonItem *leftButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"关闭"
                                    style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(leftBarButtonItemPressed:)];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    //----------------------------------------------------------------------------------------//
    
    
    //-- 输入 ---------------------------------------------------------------------------------------
    self.inputNumberTextField = [UITextField new];
    self.inputNumberTextField.frame = CGRectMake(60.0, 100.0, 200.0, 40.0);
    self.inputNumberTextField.backgroundColor = [UIColor whiteColor];
    
    self.inputNumberTextField.placeholder = @"输入一个整数";
    
    [self.view addSubview:self.inputNumberTextField];
    //---------------------------------------------------------------------------------------------;
    
    
    //-- 输出 ---------------------------------------------------------------------------------------
    self.resultLabel = [UILabel new];
    self.resultLabel.frame = CGRectMake(60.0, 160.0, 200.0, 40.0);
    //self.resultLabel.backgroundColor = [UIColor colorWithRed:0.24 green:0.48 blue:0.66 alpha:1.00];
    
    [self.view addSubview:self.resultLabel];
    //---------------------------------------------------------------------------------------------;
    
    
    //-- 按钮 ---------------------------------------------------------------------------------------
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100.0, 260.0, 120.0, 40.0);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"计算阶乘结果" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    //---------------------------------------------------------------------------------------------;
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.inputNumberTextField resignFirstResponder];
}

@end
