//
//  JavaScriptCallNativeViewController.m
//  JavaScriptCoreSample
//
//  Created by Albert Chu on 14-4-4.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

#import "JavaScriptCallNativeViewController.h"

#import "NextViewController.h"

@interface JavaScriptCallNativeViewController ()
<
UIWebViewDelegate
,TestJSExport
>

@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) JSContext *context;

@end


@implementation JavaScriptCallNativeViewController

#pragma mark - Action Methods

- (void)leftBarButtonItemPressed:(UIBarButtonItem *)barButtonItem
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.title = @"JavaScriptCallNative";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.8 blue:0.7 alpha:1.000];
    
    //-- leftItem ------------------------------------------------------------------------------
    UIBarButtonItem *leftButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"关闭"
                                    style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(leftBarButtonItemPressed:)];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    //----------------------------------------------------------------------------------------//
    
    
    
    //-- webView -----------------------------------------------------------------------------------
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    self.webView.scalesPageToFit = YES; // 自动对页面进行缩放以适应屏幕
    
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal; // 以正常速度滚动页面
    
    self.webView.autoresizingMask =
    (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight); // 旋转屏幕后自适应宽高
    
    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
    //--------------------------------------------------------------------------------------------//
    
    
    //-- 创建请求 -------------------------------------------------------------------------------
    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"JavaScriptCallNative.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    //----------------------------------------------------------------------------------------//
    
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 以 html title 设置 导航栏 title
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    // 禁用 页面元素选择
    //[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    // 禁用 长按弹出ActionSheet
    //[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    // Undocumented access to UIWebView's JSContext
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 打印异常
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    
    // 以 JSExport 协议关联 native 的方法
    self.context[@"native"] = self;
    
    // 以 block 形式关联 JavaScript function
    self.context[@"log"] =
    ^(NSString *str)
    {
        NSLog(@"%@", str);
    };
}

#pragma mark - JSExport Methods

- (void)handleFactorialCalculateWithNumber:(NSNumber *)number
{
    NSLog(@"%@", number);
    
    NSNumber *result = [self calculateFactorialOfNumber:number];
    
    NSLog(@"%@", result);
    
    [self.context[@"showResult"] callWithArguments:@[result]];
}

- (void)pushToNextViewControllerWithTitle:(NSString *)title
{
    NextViewController *nextVC = [NextViewController new];
    nextVC.title = title;
    [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark - Factorial Method

- (NSNumber *)calculateFactorialOfNumber:(NSNumber *)number
{
    NSInteger i = [number integerValue];
    if (i < 0)
    {
        return [NSNumber numberWithInteger:0];
    }
	if (i == 0)
    {
        return [NSNumber numberWithInteger:1];
    }
    
    NSInteger r = (i * [(NSNumber *)[self calculateFactorialOfNumber:[NSNumber numberWithInteger:(i - 1)]] integerValue]);
    
	return [NSNumber numberWithInteger:r];
}


@end
