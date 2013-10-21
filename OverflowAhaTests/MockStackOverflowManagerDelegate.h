//
//  MockStackOverflowDelegate.h
//  OverflowAha
//
//  Created by niko on 13-10-21.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverFlowManager.h"

@interface MockStackOverflowManagerDelegate : NSObject<StackOverFlowManagerDelegate>

@property (nonatomic) NSError *fetchError;
@property (nonatomic) NSArray *receicedQuestions;


@end


