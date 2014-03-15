//
//  ABCDAsyncDownload.m
//  TestUrlNavigation
//
//  Created by jitu keshri on 3/15/14.
//  Copyright (c) 2014 NowFloats. All rights reserved.
//

#import "ABCDAsyncDownload.h"

@implementation ABCDAsyncDownload
@synthesize delegate;

-(void) downloadImage:(NSMutableArray *) imageArray{
    
    dispatch_queue_t imageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    for (NSString *urlString in imageArray) {
        
        NSUInteger imageIndex = [imageArray indexOfObject:urlString];
        //NSLog(@"%lu", (unsigned long)imageIndex);
        
        dispatch_async(imageQueue, ^{
            
            NSURL *url = [NSURL URLWithString:urlString];
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:imageData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if(image == NULL){
                    
                    if ([delegate respondsToSelector:@selector(AsyncDownloadDidFail:)])
                    {
                        [delegate performSelector:@selector(AsyncDownloadDidFail:) withObject:[NSNumber numberWithInteger:imageIndex]];
                    }
                    
                }
                else{
                    if ([delegate respondsToSelector:@selector(AsyncDownloadDidFinishWithImage:atIndex:)])
                    {
                        [delegate performSelector:@selector(AsyncDownloadDidFinishWithImage: atIndex:) withObject:image withObject:[NSNumber numberWithInteger:imageIndex]];
                    }
                }
            });
        });
        
    }
}

@end
