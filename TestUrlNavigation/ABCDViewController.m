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
    [self.ScrollView setShowsHorizontalScrollIndicator:NO];
    [self.ScrollView setShowsVerticalScrollIndicator:NO];
    NSMutableArray *argsArray = [[NSMutableArray alloc] initWithArray:[data objectForKey:@"SecondaryTileImages"]];
    int height=80;
    for(int i= 0; i < argsArray.count; i++)
    {
    
        NSString *urlstring = [NSString stringWithFormat:@"%@%@",UrlVar,[argsArray objectAtIndex:i]];
        UIImageView *subview = [[UIImageView alloc] init];
        NSUInteger imageIndex = i;
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
        ABCDAsyncDownload *downloadCntl = [[ABCDAsyncDownload alloc] init];
        downloadCntl.delegate = self;
        [downloadCntl downloadImage:urlstring andIndex:[NSNumber numberWithInt:imageIndex]];

        [self.ScrollView addSubview:subview];
       
    }
    self.ScrollView.contentSize =  CGSizeMake(self.ScrollView.frame.size.width, height);
    [self.view addSubview:ScrollView];
}

-(void) AsyncDownloadDidFail:(NSNumber *) imageIndex{
    for(UIImageView *view in self.ScrollView.subviews)
    {
        if(view.tag == imageIndex.intValue)
        {
            [view setImage:[UIImage imageNamed:@"notfound.jpg"]];
            [self.ScrollView addSubview:view];
            [self.view addSubview:ScrollView];
        }
    }
    
}

-(void) AsyncDownloadDidFinishWithImage:(UIImage *)downloadedImage atIndex:(NSNumber *)imageIndex
{
   for(UIImageView *view in self.ScrollView.subviews)
   {
       if(view.tag == imageIndex.intValue)
       {
           [view setImage:downloadedImage];
           [self.ScrollView addSubview:view];
       }
   }
}


-(void)downloadDidFail  
{
    NSLog(@"Delegate method failure block");
}


@end
