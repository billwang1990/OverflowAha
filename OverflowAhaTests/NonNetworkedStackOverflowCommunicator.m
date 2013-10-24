//
//  NonNetworkedStackOverflowCommunicator.m
//  OverflowAha
//
//  Created by niko on 13-10-23.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "NonNetworkedStackOverflowCommunicator.h"

@implementation NonNetworkedStackOverflowCommunicator

- (void)launchConnectionForRequest: (NSURLRequest *)request {
}

- (void)setReceivedData:(NSData *)data {
    receivedData = [data mutableCopy];
}

- (NSData *)receivedData {
    return [receivedData copy];
}

@end
