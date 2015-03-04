//
//  ViewController.m
//  TestCrashMail
//
//  Created by kaxiaoer on 15/3/2.
//  Copyright (c) 2015年 miaogaoliang. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (copy, nonatomic) NSString *baseURL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _baseURL = @"http://kxe.kaxiaobao.cn/adv/rightsNow.html";
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
    web.delegate = self;
    [self.view addSubview:web];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_baseURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    [web loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *relative = [request.URL relativeString];
    if (![relative isEqualToString:_baseURL]) {
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.htmlURL = relative;
        [self presentViewController:webVC animated:YES completion:^{
        }];
        return NO;
    }
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    /**
     *  在html 后面添加 js function，第一种，通过 string 添加；
     *  第二中，通过js 文件添加 json.js
     *
     *
     *  @return <#return value description#>
     */
    
//   NSString *js = @"function f()"
//    "{"
//    "window.reload();"
//    "}";
//    [webView stringByEvaluatingJavaScriptFromString:js];
//    [webView stringByEvaluatingJavaScriptFromString:@"f()"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"json.js" ofType:nil];
    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    [webView stringByEvaluatingJavaScriptFromString:jsCode];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"rootJSON.geojson" ofType:nil];
    NSString *string = [[NSString alloc] initWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
    NSString *json = [NSString stringWithFormat:@"json('%@')",string];
    NSString *what = [webView stringByEvaluatingJavaScriptFromString:json];

    NSLog(what,nil);
}
@end
