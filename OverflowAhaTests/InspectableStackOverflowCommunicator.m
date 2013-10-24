//
//  InspectableStackOverflowCommunicator.m
//  OverflowAha
//
//  Created by niko on 13-10-23.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "InspectableStackOverflowCommunicator.h"

@implementation InspectableStackOverflowCommunicator

-(NSURL *)URLToFetch{
    return fetchingURL;
}

-(NSURLConnection *)currentURLConnection
{
    return fetchingConnection;
}

@end
