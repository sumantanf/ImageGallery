//
//  ABCDScrollImageViewController.m
//  TestUrlNavigation
//
//  Created by jitu keshri on 3/22/14.
//  Copyright (c) 2014 NowFloats. All rights reserved.
//

#import "ABCDScrollImageViewController.h"

@interface ABCDScrollImageViewController ()

@end

@implementation ABCDScrollImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notfound.jpg"]];
    [self.view addSubview:imgView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
