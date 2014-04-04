//
//  JavaScriptCallNativeViewController.h
//  JavaScriptCoreSample
//
//  Created by Albert Chu on 14-4-4.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestJSExport <JSExport>

JSExportAs
(functionNameForJS,
 
- (void)handleFactorialCalculateWithNumber:(NSNumber *)number
 
);

- (void)logSomething;

- (void)pushToNextViewControllerWithTitle:(NSString *)title;


@end


@interface JavaScriptCallNativeViewController : UIViewController

@end
