//
//  BNRWebViewController.m
//  NerdFeed
//
//  Created by Ray Lin on 5/10/15.
//  Copyright (c) 2015 Ray Lin. All rights reserved.
//

#import "BNRWebViewController.h"

@interface BNRWebViewController ()

@end

@implementation BNRWebViewController

-(void)loadView{
    UIWebView* webView = [[UIWebView alloc]init];
    webView.scalesPageToFit = YES;
    self.view = webView;
    
    //add the stupid back button
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height - 44, [[UIScreen mainScreen]bounds].size.width, 44)];
    UIBarButtonItem* backButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(backButtonPressed:)];
    UIBarButtonItem* forwardButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(forwardButtonPressed:)];
    NSArray* buttonItems = [[NSArray alloc]initWithObjects:backButton, forwardButton, nil];
    [toolbar setItems:buttonItems];
    [self.view addSubview:toolbar];
}

-(void)backButtonPressed:(id)sender{
    [(UIWebView*)self.view goBack];
}

-(void)forwardButtonPressed:(id)sender{
    [(UIWebView*)self.view goForward];
}

-(void)setUrl:(NSURL *)url{
    _url = url;
    if (_url) {
        NSURLRequest *req = [NSURLRequest requestWithURL:_url];
        [(UIWebView*)self.view loadRequest:req];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
