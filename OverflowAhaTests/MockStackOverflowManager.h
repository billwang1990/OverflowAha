//
//  MockStackOverflowManager.h
//  OverflowAha
//
//  Created by niko on 13-10-23.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "StackOverFlowManager.h"

@interface MockStackOverflowManager : StackOverFlowManager<StackOverflowCommunicatorDelegate>
{
    @protected
    NSString *topicSearchStr;
    NSString *questionBodyStr;
    NSString *answerListStr;
}


- (NSString *)topicSearchString;
- (NSString *)questionBodyString;
- (NSString *)answerListString;

- (NSInteger)topicFailureErrorCode;
- (NSInteger)bodyFailureErrorCode;
- (NSInteger)answerFailureErrorCode;

@end
