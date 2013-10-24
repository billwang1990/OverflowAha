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

-(void)searchForQuestionWithTag:(NSString*)tag;

-(void)downloadInformationForQuestionWithID:(NSInteger)indentifier;

-(void)downloadAnswersToQuestionWithID:(NSInteger)identifier;

-(void)fetchBodyForQuestion:(NSInteger)identifier;

-(void)cancelAndDiscardURLConnection;

@end
