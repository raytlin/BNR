//
//  BNRCoursesViewController.m
//  NerdFeed
//
//  Created by Ray Lin on 5/8/15.
//  Copyright (c) 2015 Ray Lin. All rights reserved.
//

#import "BNRCoursesViewController.h"
#import "BNRWebViewController.h"

@interface BNRCoursesViewController () <UITableViewDataSource, UITableViewDelegate, NSURLSessionDataDelegate>

@property (nonatomic)NSURLSession* session;
@property (nonatomic, copy) NSArray *courses;

@end

@implementation BNRCoursesViewController

-(instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"BNR Courses";
        NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        [self fetchFeed];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    
}

-(void)fetchFeed{
    NSString * requestString = @"https://bookapi.bignerdranch.com/private/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest* req = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask* dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse* response, NSError* error){
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.courses = jsonObject[@"courses"];
        
        NSLog(@"%@", self.courses);
        
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [[self tableView]reloadData];
        });
    }];
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.courses count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.courses[indexPath.row][@"title"];
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* course = self.courses[indexPath.row];
    NSURL* url = [NSURL URLWithString:course[@"url"]];
    
    self.webViewController.url = url;
    self.webViewController.title = course[@"title"];
    if (!self.splitViewController) {
        [self.navigationController pushViewController:self.webViewController animated:YES];
    }
    
}

#pragma mark - URL Session Delegate
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{
    NSURLCredential* cred = [NSURLCredential credentialWithUser:@"BigNerdRanch" password:@"AchieveNerdvana" persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
}

@end
