//
//  ABCDFrameSetter.m
//  TestUrlNavigation
//
//  Created by jitu keshri on 3/19/14.
//  Copyright (c) 2014 NowFloats. All rights reserved.
//

#import "ABCDFrameSetter.h"

@implementation ABCDFrameSetter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setFrame:(int)i{
    CGRect frame;
    frame.origin.x = 100*i;
    frame.size.height = 75;
    frame.size.width = 90;
    
    if(frame.origin.x > 200.000000 )
    {
        int j = i % 3;
        frame.origin.x = 100 * j;
        if( j == 0)
        {
            frame.origin.y += 80;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
