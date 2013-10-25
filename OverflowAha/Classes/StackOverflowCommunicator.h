//
//  StackOverflowCommunicator.h
//  OverflowAha
//
//  Created by niko on 13-10-21.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicatorDelegate.h"

extern NSString *StackOverflowCommunicatorErrorDomain;

@interface StackOverflowCommunicator : NSObject<NSURLConnectionDataDelegate>
{
    @protected
    NSURL *fetchingURL;
    NSURLConnection *fetchingConnection;
    NSMutableData *receivedData;
    
    @private
    void (^errorHandler)(NSError *);
    void (^successHandler)(NSString *);
}

@property (nonatomic, weak) id<StackOverflowCommunicatorDelegate> delegate;

/**
 * 根据tag搜索question的列表
 */
-(void)searchForQuestionWithTag:(NSString*)tag;

/**
 * 根据questionID下载其相关信息
 */
-(void)downloadInformationForQuestionWithID:(NSInteger)indentifier;

/**
 *根据questionID下载answer信息
 */
-(void)downloadAnswersToQuestionWithID:(NSInteger)identifier;

/**
 * 获取question的具体内容
 */

-(void)cancelAndDiscardURLConnection;

@end
