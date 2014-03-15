//
//  ABCDAsyncDownload.h
//  TestUrlNavigation
//
//  Created by jitu keshri on 3/15/14.
//  Copyright (c) 2014 NowFloats. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AsyncDownloadDelegate <NSObject>

-(void) AsyncDownloadDidFinishWithImage: (UIImage *)downloadedImage atIndex:(NSNumber *) imageIndex;
-(void) AsyncDownloadDidFail:(NSUInteger *) imageIndex;

@end

@interface ABCDAsyncDownload : NSObject
{
    id <AsyncDownloadDelegate> delegate;
}

@property (strong, nonatomic) id <AsyncDownloadDelegate> delegate;

-(void) downloadImage:(NSMutableArray *) imageArray;
@end
