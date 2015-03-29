//
//  ViewController.m
//  MXActionSheet
//
//  Created by Michael Tianlin on 3/29/15.
//  Copyright (c) 2015 TianLinlin. All rights reserved.
//

#import "ViewController.h"
#import "MXActionSheet.h"

@interface ViewController ()<MXActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *chickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chickButton setFrame:CGRectMake(0, 0, 60, 34)];
    [chickButton setTitle:@"Show" forState:UIControlStateNormal];
    [chickButton setBackgroundColor:[UIColor redColor]];
    [chickButton addTarget:self action:@selector(chickAction) forControlEvents:UIControlEventTouchUpInside];
    [chickButton setCenter:self.view.center];
    [self.view addSubview:chickButton];
}

- (void)chickAction {
    
    MXActionSheet *sheet = [[MXActionSheet alloc] initWithTitle:@"This is the main title"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@[@"WeChat", @"Weibo", @"Twitter", @"QQ"]];
    [sheet showInView:self.view];
}

#pragma mark - MXActionSheetDelegate

- (void)actionSheet:(MXActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%@",@(buttonIndex));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
