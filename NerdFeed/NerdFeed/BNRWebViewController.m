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
    
    self.navigationItem.leftBarButtonItem = [self.splitViewController displayModeButtonItem];
    
}

-(void)deleteBar:(id)sender{
    [self.toolbar removeFromSuperview];
}

-(void)viewWillAppear:(BOOL)animated{
    [self addToolbar:[[UIScreen mainScreen]bounds].size];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(deleteBar:)];
}

-(void)addToolbar:(CGSize)size{
    //add the stupid back button and toolbar
    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, size.height - 44, size.width, 44)];
    UIBarButtonItem* backButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(backButtonPressed:)];
    UIBarButtonItem* forwardButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(forwardButtonPressed:)];
    NSArray* buttonItems = [[NSArray alloc]initWithObjects:backButton, forwardButton, nil];
    [self.toolbar setItems:buttonItems];
    [self.view addSubview:self.toolbar];
    NSArray* hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[toolbar]|" options:0 metrics:nil views:@{@"toolbar" : self.toolbar}];
    [self.view addConstraints:hConstraints];
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



-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    //self.toolbar = nil;
    [self deleteBar:self];
    [self addToolbar:size];
}



@end
