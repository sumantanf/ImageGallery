//
//  ABCDViewController.m
//  TestUrlNavigation
//
//  Created by jitu keshri on 3/6/14.
//  Copyright (c) 2014 NowFloats. All rights reserved.
//

#import "ABCDViewController.h"
#import "ABCDAppDelegate.h"
#import "ABCDFrameSetter.h"

@interface ABCDViewController ()<DownloadProtocolDelegate, AsyncDownloadDelegate>{
    UIImageView *scrollImage;
    UINavigationBar *bottomNav, *topNav;
    float viewHeight;
    NSString *version;
    UINavigationItem *navItem, *topNavItem;
    UIBarButtonItem *leftNav, *rightNav, *deleteImage, *backNav;
    UIView *detailView;
    UIScrollView *detailImage;
}

@end

@implementation ABCDViewController
@synthesize ScrollView, imageList;
@synthesize ClickMe, muteData;
@synthesize myScrollImage;


- (void)viewDidLoad
{
    [super viewDidLoad];
    version = [[UIDevice currentDevice] systemVersion];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        viewHeight = result.height;
        if(version.floatValue < 7.0)
        {
            topNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0,  0.0, self.view.frame.size.width, 44.0)];
            self.navigationController.navigationBarHidden = NO;
            bottomNav.barStyle = UIBarStyleDefault;
            topNav.barStyle = UIBarStyleDefault;
            if(viewHeight == 480)
            {
                bottomNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0,420, self.view.frame.size.width, 44.0)];
            }
            else
            {
                bottomNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0,self.view.frame.size.height+44, self.view.frame.size.width, 44.0)];
            }
            
        }
        else
        {
            topNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0,  0.0, self.view.frame.size.width, 46.0)];
            topNav.barTintColor = [UIColor colorWithRed:255/255.0f green:185/255.0f blue:0/255.0f alpha:1.0f];
            topNav.translucent = NO;
            topNav.tintColor = [UIColor whiteColor];
            
            
            
            if(viewHeight == 480)
            {
                bottomNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0,420, self.view.frame.size.width, 44.0)];
            }
            else
            {
                bottomNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0,  self.view.frame.size.height+40, self.view.frame.size.width, 48.0)];
            }
            bottomNav.barTintColor = [UIColor colorWithRed:255/255.0f green:185/255.0f blue:0/255.0f alpha:1.0f];
            bottomNav.translucent = NO;
            bottomNav.tintColor = [UIColor whiteColor];
        }
       
    }
    if(viewHeight == 480)
    {
        detailView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, 320, 480)];
        detailImage = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, 436)];
    }
    else{
        detailView = [[UIView alloc] initWithFrame: CGRectMake ( 0, 0, 320, 568)];
        detailImage = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, 460)];
    }
    
	navItem  = [[UINavigationItem alloc] init];
    
    topNavItem = [[UINavigationItem alloc] init];
    
    backNav = [[UIBarButtonItem alloc]
               initWithTitle:@"back"
               style:UIBarButtonItemStyleBordered
               target:self
               action:@selector(moveBack:)];
    
    leftNav = [[UIBarButtonItem alloc]
               initWithTitle:@"left"
               style:UIBarButtonItemStyleBordered
               target:self
               action:@selector(moveLeft:)];
    rightNav = [[UIBarButtonItem alloc]
                initWithTitle:@"right"
                style:UIBarButtonItemStyleBordered
                target:self
                action:@selector(moveRight:)];
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
    [self.ScrollView setUserInteractionEnabled:YES];
    //   [self.ScrollView setClipsToBounds:NO];
    NSMutableArray *argsArray = [[NSMutableArray alloc] initWithArray:[data objectForKey:@"SecondaryTileImages"]];
    int height=80;
    imageList = [[NSMutableArray alloc] init];
    for(int i= 0; i < argsArray.count; i++)
    {
        
        NSString *urlstring = [NSString stringWithFormat:@"%@%@",UrlVar,[argsArray objectAtIndex:i]];
        UIImageView *subview = [[UIImageView alloc] init];
        CGRect frame;
        frame.origin.x = 100 * i;
        frame.size.height = 75;
        frame.size.width = 90;
        
        if(frame.origin.x > 200.000000 )
        {
            int j = i % 3;
            frame.origin.x = 100 * j;
            if( j == 0)
            {
                height +=80;
                frame.origin.y += 80;
            }
        }
        
        self.ScrollView.pagingEnabled = YES;
        subview.tag = i;
        subview.frame = frame;
        [imageList addObject:urlstring];
        subview.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        [subview addGestureRecognizer:tap];
        ABCDAsyncDownload *downloadCntl = [[ABCDAsyncDownload alloc] init];
        downloadCntl.delegate = self;
        
        [downloadCntl downloadImage:urlstring andIndex:[NSNumber numberWithInt:i]];
        
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

-(void)imageTapped:(UITapGestureRecognizer *)gesture
{
    UIImageView *imgView = (UIImageView *)gesture.view;
   // NSString *url = [imageList objectAtIndex:imgView.tag];
    NSInteger index = imgView.tag;
   // NSLog(@"Index of image clicked is : %@", url);
    [self performSelector:@selector(scrollableImage:) withObject:[NSNumber numberWithInt:index]];
}

-(void)scrollableImage:(NSNumber *) index{
    
    NSString *url = [imageList objectAtIndex:index.intValue];
    NSURL *urlstring = [NSURL URLWithString:url];
    NSData *imageData = [NSData dataWithContentsOfURL:urlstring];
    UIImage *image = [UIImage imageWithData:imageData];
    
    if(viewHeight == 480)
    {
        scrollImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,320,392)];
    }
    else{
         scrollImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,myScrollImage.frame.size.width,myScrollImage.frame.size.height)];
    }
    
    [scrollImage setImage:image];
    detailImage.showsHorizontalScrollIndicator = YES;
   // myScrollImage.showsHorizontalScrollIndicator = YES;
   // [myScrollImage addSubview:scrollImage];
    [detailImage addSubview:scrollImage];
    detailImage.contentSize = CGSizeMake(detailImage.frame.size.width, detailImage.frame.size.height);
    //myScrollImage.contentSize = CGSizeMake(myScrollImage.frame.size.width, myScrollImage.frame.size.height);
    [detailView addSubview:detailImage];
    //[scrollImageView addSubview:myScrollImage];
    
    topNavItem.leftBarButtonItem = backNav;
    topNav.items = [NSArray arrayWithObject:topNavItem];
    
    navItem.leftBarButtonItem = leftNav;
    leftNav.tag = index.intValue;
    rightNav.tag = index.intValue;
    navItem.rightBarButtonItem = rightNav;
    
    
    if(index.intValue == imageList.count-1)
    {
        navItem.rightBarButtonItem.enabled = NO;
    }
    else{
        if(index.intValue == 0 )
        {
            navItem.leftBarButtonItem.enabled = NO;
        }
        else{
             navItem.rightBarButtonItem.enabled = YES;
             navItem.leftBarButtonItem.enabled = YES;
        }
    }
    
    bottomNav.items = [NSArray arrayWithObject:navItem];
    [detailView addSubview:bottomNav];
    [detailView addSubview:topNav];
    [self.view addSubview:detailView];
}

-(void)moveLeft:(id)sender{
    
    NSNumber *index = [NSNumber numberWithInt:leftNav.tag-1];
    
    [self performSelector:@selector(scrollableImage:) withObject:index];
    
}

-(void)moveRight:(id)sender{
    
    NSNumber *index = [NSNumber numberWithInt:rightNav.tag + 1];
    
    [self performSelector:@selector(scrollableImage:) withObject:index];
}

-(void)moveBack:(id)sender{
    
    [detailView removeFromSuperview];
    
    
}

-(void)downloadDidFail
{
    NSLog(@"Delegate method failure block");
}


@end
