//
//  EChartsWebViewController.m
//  JavaScriptCoreWithECharts
//
//  Created by Albert Chu on 14-4-9.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

#import "HighchartsWebViewController.h"

@interface HighchartsWebViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) JSContext *context;

@end


@implementation HighchartsWebViewController

#pragma mark - Action Method

- (void)leftBarButtonItemPressed:(UIBarButtonItem *)barButtonItem
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Highcharts VC";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
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
    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"HighchartsView.html"];
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
    
    
    // 关联 JSContext
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 打印异常
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    
    
    // 装载数据
    [self loadChartsData];
}

#pragma mark - Load Charts Data

- (void)loadChartsData
{
    // 装载数据
    NSArray *the1024Data = @[@33, @41, @32, @51, @42, @103, @136];
    NSDictionary *the1024Dict = @{@"name": @"1024", @"data": the1024Data};
    
    NSArray *theCCAVData = @[@8, @11, @21, @13, @20, @52, @43];
    NSDictionary *theCCAVDict = @{@"name": @"CCAV", @"data": theCCAVData};
    
    NSArray *seriesArray = @[the1024Dict, theCCAVDict];
    
    [self.context[@"drawChart"] callWithArguments:@[seriesArray]];
}

@end
