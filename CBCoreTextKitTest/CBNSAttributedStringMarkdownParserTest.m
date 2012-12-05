//
//  CBNSAttributedStringMarkdownParserTest.m
//  CBCoreTextKit
//
//  Created by Christian Beer on 05.12.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import "CBNSAttributedStringMarkdownParserTest.h"

#import "NSAttributedString+Markdown.h"


@implementation CBNSAttributedStringMarkdownParserTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void) testStrongRegularExpresion
{
    NSError *error = nil;
    NSRegularExpression *regexp = [NSAttributedString markdownRegularExpressionForStrong:&error];
    STAssertNotNil(regexp, @"Regular expression creation failed: %@", error);
    
    NSString *string = @"**double asterisks**";
    NSArray *matches = [regexp matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    STAssertEquals((int)matches.count, (int)1, @"Should match 1 time");

    NSTextCheckingResult *result = [matches objectAtIndex:0];
    STAssertEquals(result.range, NSMakeRange(0, 20), @"Should match characters 2-18");
/*
 *single asterisks*
 
 _single underscores_
    
    **double asterisks**
    
    __double underscores__ */
}

@end
