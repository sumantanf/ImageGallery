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

-(void) downloadImage:(NSString *) imageUrl andIndex:(NSNumber *)imageIndex{
    
    dispatch_queue_t imageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(imageQueue, ^{
        
        NSURL *url = [NSURL URLWithString:imageUrl];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(image == NULL){
                if ([delegate respondsToSelector:@selector(AsyncDownloadDidFail:)])
                {
                    [delegate performSelector:@selector(AsyncDownloadDidFail:) withObject:imageIndex];
                }
                
            }
            else{
                if ([delegate respondsToSelector:@selector(AsyncDownloadDidFinishWithImage:atIndex:)])
                {
                    [delegate performSelector:@selector(AsyncDownloadDidFinishWithImage: atIndex:) withObject:image withObject:imageIndex];
                }
            }
        });
    });
    
}

@end
