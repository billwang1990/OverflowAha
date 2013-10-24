//
//  NonNetworkedStackOverflowCommunicator.h
//  OverflowAha
//
//  Created by niko on 13-10-23.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface NonNetworkedStackOverflowCommunicator : StackOverflowCommunicator
{
    
}

@property (copy) NSData *receivedData;

@end
