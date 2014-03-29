//
//  ABCDViewController.h
//  TestUrlNavigation
//
//  Created by jitu keshri on 3/6/14.
//  Copyright (c) 2014 NowFloats. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABCDDownloadControl.h"
#import "ABCDAsyncDownload.h"

@interface ABCDViewController : UIViewController<DownloadProtocolDelegate, AsyncDownloadDelegate>{
    
    IBOutlet UIView *scrollImageView;
}

@property (strong, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (strong, nonatomic) IBOutlet UIButton *ClickMe;

@property (strong, nonatomic) NSDictionary *muteData;

@property (strong, nonatomic) IBOutlet UIScrollView *myScrollImage;

@property (strong, nonatomic) NSMutableArray *imageList;

@end
