//
//  ABCDDownloadControl.m
//  TestUrlNavigation
//
//  Created by jitu keshri on 3/6/14.
//  Copyright (c) 2014 NowFloats. All rights reserved.
//

#import "ABCDDownloadControl.h"
#import "ABCDAppDelegate.h"

@implementation ABCDDownloadControl
@synthesize receivedData;
@synthesize delegate;

- (void)Download
{
    
    NSLog(@"Clicked on button_login");
    NSString *loginScriptURL = [NSString stringWithFormat:@"%@",UrlVariable];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginScriptURL]];
    NSString *str = @"DB96EA35A6E44C0F8FB4A6BAA94DB017C0DFBE6F9944B14AA6C3C48641B3D70";
    NSString *postString = [NSString stringWithFormat:@"\"%@\"",str];
    
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPBody:postData];
    // Create the actual connection using the request.
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    // Capture the response
    if (theConnection)
    {
        NSLog(@"theConnection is succesful");
    } else
    {
        NSLog(@"theConnection failed");
    }
}

-(void)startSampleProcess{
    
    [self Download];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error in connecting");
    
    if ([delegate respondsToSelector:@selector(downloadDidFail)])
    {
        [delegate performSelector:@selector(downloadDidFail)];
    }
    // The request has failed for some reason!
    // Check the error var
}


- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response {
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = [httpResponse statusCode];
    if(responseStatusCode != 200){
        if ([delegate respondsToSelector:@selector(downloadDidFail)])
        {
            [delegate performSelector:@selector(downloadDidFail)];
        }
    }
    
    NSLog(@"response is %d", responseStatusCode);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSError *e = nil;
    receivedData = data;
    NSDictionary *fpDetails = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
    NSLog(@"dictionary is %@", fpDetails);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    NSDictionary *fpDetails = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"Downloaded data is  %@",fpDetails);
    
    if ([delegate respondsToSelector:@selector(downloadDidSucceed:)])
    {
        [delegate performSelector:@selector(downloadDidSucceed:) withObject:fpDetails];
    }
}



@end

