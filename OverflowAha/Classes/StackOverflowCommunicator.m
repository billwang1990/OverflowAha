//
//  StackOverflowCommunicator.m
//  OverflowAha
//
//  Created by niko on 13-10-21.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@implementation StackOverflowCommunicator

-(void)dealloc{
    [self cancelAndDiscardURLConnection];
}

- (void)launchConnectionForRequest: (NSURLRequest *)request  {
    [self cancelAndDiscardURLConnection];
    fetchingConnection = [NSURLConnection connectionWithRequest: request delegate: self];
    
}

- (void)fetchContentAtURL:(NSURL *)url errorHandler:(void (^)(NSError *))errorBlock successHandler:(void (^)(NSString *))successBlock {
    fetchingURL = url;
    errorHandler = [errorBlock copy];
    successHandler = [successBlock copy];
    NSURLRequest *request = [NSURLRequest requestWithURL: fetchingURL];
    
    [self launchConnectionForRequest: request];

}

-(void)searchForQuestionWithTag:(NSString *)tag{

    [self fetchContentAtURL: [NSURL URLWithString:
                              [NSString stringWithFormat: @"http://api.stackoverflow.com/1.1/search?tagged=%@&pagesize=20", tag]]
               errorHandler: ^(NSError *error) {
                   [_delegate searchingForQuestionsFailedWithError: error];
               }
             successHandler: ^(NSString *objectNotation) {
                 [_delegate receivedQuestionsJSON: objectNotation];
             }];
}

-(void)downloadInformationForQuestionWithID:(NSInteger)identifier
{
    
    [self fetchContentAtURL: [NSURL URLWithString:
                              [NSString stringWithFormat: @"http://api.stackoverflow.com/1.1/questions/%d?body=true", identifier]]
               errorHandler: ^(NSError *error) {
                   [_delegate fetchingQuestionBodyFailedWithError: error];
               }
             successHandler: ^(NSString *objectNotation) {
                 [_delegate receivedQuestionBodyJSON: objectNotation];
             }];}

-(void)downloadAnswersToQuestionWithID:(NSInteger)identifier
{
    [self fetchContentAtURL: [NSURL URLWithString:
                              [NSString stringWithFormat: @"http://api.stackoverflow.com/1.1/questions/%d/answers?body=true", identifier]]
               errorHandler: ^(NSError *error) {
                   [_delegate fetchingAnswersFailedWithError: error];
               }
             successHandler: ^(NSString *objectNotation) {
                 [_delegate receivedAnswerListJSON: objectNotation];
             }];

}

-(void)fetchBodyForQuestion:(NSInteger)identifier
{
}

-(void)cancelAndDiscardURLConnection
{
    [fetchingConnection cancel];
    fetchingConnection = nil;
}


#pragma mark NSURLConnection Delegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedData = nil;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ([httpResponse statusCode] != 200) {
        NSError *error = [NSError errorWithDomain: StackOverflowCommunicatorErrorDomain code: [httpResponse statusCode] userInfo: nil];
        errorHandler(error);
        [self cancelAndDiscardURLConnection];
    }
    else {
        receivedData = [[NSMutableData alloc] init];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    receivedData = nil;
    fetchingConnection = nil;
    fetchingURL = nil;
    errorHandler(error);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    fetchingConnection = nil;
    fetchingURL = nil;
    NSString *receivedText = [[NSString alloc] initWithData: receivedData
                                                   encoding: NSUTF8StringEncoding];
    receivedData = nil;
    successHandler(receivedText);

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData: data];
}


NSString *StackOverflowCommunicatorErrorDomain = @"StackOverflowCommunicatorErrorDomain";

@end

