//
//  ABCDDownloadControl.h
//  TestUrlNavigation
//
//  Created by jitu keshri on 3/6/14.
//  Copyright (c) 2014 NowFloats. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloadProtocolDelegate <NSObject>

@required
-(void) downloadDidSucceed:(NSDictionary *) r;
-(void) downloadDidFail;
@end

@interface ABCDDownloadControl : NSObject<NSURLConnectionDelegate>
{
    id <DownloadProtocolDelegate> delegate;
}

@property (nonatomic,strong) id <DownloadProtocolDelegate> delegate;

@property (nonatomic, retain) NSData *receivedData;


-(void)startSampleProcess;

@end
