//
//  ABCDViewController.m
//  TestUrlNavigation
//
//  Created by jitu keshri on 3/6/14.
//  Copyright (c) 2014 NowFloats. All rights reserved.
//

#import "ABCDViewController.h"
#import "ABCDAppDelegate.h"

@interface ABCDViewController ()<DownloadProtocolDelegate, AsyncDownloadDelegate>{
    UIImageView *subview;
    NSMutableArray *imageList;
    NSMutableArray *indexList;
}

@end

@implementation ABCDViewController
@synthesize ScrollView;
@synthesize ClickMe, muteData;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    
    [self setClickMe:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)ClickMe:(id)sender{
    ABCDDownloadControl *downloadCntl =[[ABCDDownloadControl alloc]init];
    downloadCntl.delegate = self;
    [downloadCntl startSampleProcess];
}

-(void)downloadDidSucceed:(NSDictionary *) data
{
    
    NSMutableArray *argsArray = [[NSMutableArray alloc] initWithArray:[data objectForKey:@"SecondaryTileImages"]];
    
     imageList = [[NSMutableArray alloc] init];
    subview = [[UIImageView alloc] init];
    indexList = [[NSMutableArray alloc] init];
    int height=80;
    for(int i= 0; i < argsArray.count; i++)
    {
    
        NSString *urlstring = [NSString stringWithFormat:@"%@%@",UrlVar,[argsArray objectAtIndex:i]];
     
        [imageList addObject:urlstring];
        NSUInteger imageIndex = [argsArray indexOfObject:[NSNumber numberWithInt:i]];
        CGRect frame;
        frame.origin.x = 100 * imageIndex;
        frame.size.height = 75;
        frame.size.width = 90;
        
        if(frame.origin.x > 200.000000 )
        {
            int j = imageIndex % 3;
            frame.origin.x = 100 * j;
            if( j == 0)
            {
                height +=80;
                frame.origin.y += 80;
            }
        }
        
        self.ScrollView.pagingEnabled = YES;
        subview.tag = imageIndex;
        subview.frame = frame;

        [self.ScrollView addSubview:subview];
        [indexList addObject:[NSNumber numberWithInt:imageIndex]];
    }
    self.ScrollView.contentSize =  CGSizeMake(self.ScrollView.frame.size.width, height);
    ABCDAsyncDownload *downloadCntl = [[ABCDAsyncDownload alloc] init];
    downloadCntl.delegate = self;
    [downloadCntl downloadImage:imageList];
    
    NSLog(@"SubView Count:%d",self.ScrollView.subviews.count);

}

-(void) AsyncDownloadDidFail:(NSUInteger *) imageIndex{
    NSLog(@"Downloading image failed");
    [subview setImage:[UIImage imageNamed:@"notfound.jpg"]];
    [self.ScrollView addSubview:subview];
    
}

-(void) AsyncDownloadDidFinishWithImage:(UIImage *)downloadedImage atIndex:(NSNumber *)imageIndex
{
//    NSLog(@"Index is %d", imageIndex.intValue);
  //  NSLog(@"Subview tag:%d",subview.tag);
    
    
    for(int i = 0; i< indexList.count;i++)
    {
        if(i == imageIndex.intValue)
        {
            NSLog(@"image index is %d", i);
            [subview setImage:downloadedImage];

            //[self.ScrollView addSubview:[self.ScrollView.subviews objectAtIndex:imageIndex.intValue]];

        }
        
    }
    
//    if (imageIndex.intValue == subview.tag) {
//        [subview setImage:downloadedImage];
//        [self.ScrollView addSubview:subview];
//    }
  
    
}


-(void)downloadDidFail  
{
    NSLog(@"Delegate method failure block");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
