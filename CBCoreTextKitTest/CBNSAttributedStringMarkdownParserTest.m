//
//  CBNSAttributedStringMarkdownParserTest.m
//  CBCoreTextKit
//
//  Created by Christian Beer on 05.12.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import "CBNSAttributedStringMarkdownParserTest.h"

#import "CBCTKMarkdownParser.h"

@interface CBCTKMarkdownParser ()

+ (NSRegularExpression*) markdownRegularExpressionForStrong;
+ (NSRegularExpression*) markdownRegularExpressionForEm;

@end


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
/*
    <strong> :
    **double asterisks**
    __double underscores__ 
 */

    NSError *error = nil;
    NSRegularExpression *regexp = [CBCTKMarkdownParser markdownRegularExpressionForStrong];
    STAssertNotNil(regexp, @"Regular expression creation failed: %@", error);
    
    NSString *string = @"**double asterisks**";
    NSArray *matches = [regexp matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    STAssertEquals((int)matches.count, (int)1, @"Should match 1 time");

    NSTextCheckingResult *result = [matches lastObject];
    STAssertEquals(result.range, NSMakeRange(0, string.length), @"Should match characters 0...%d", string.length);
    STAssertEquals(result.numberOfRanges, (NSUInteger)3, @"Result should have 3 ranges");
    STAssertEquals([result rangeAtIndex:2], NSMakeRange(2, string.length - 4), @"Second range should match containing text");
    
    
    string = @"__double underscores__";
    matches = [regexp matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    STAssertEquals((int)matches.count, (int)1, @"Should match 1 time");
    
    result = [matches lastObject];
    STAssertEquals(result.range, NSMakeRange(0, string.length), @"Should match characters 0...%d", string.length);
    STAssertEquals(result.numberOfRanges, (NSUInteger)3, @"Result should have 3 ranges");
    STAssertEquals([result rangeAtIndex:2], NSMakeRange(2, string.length - 4), @"Second range should match containing text");
}

- (void) testEmRegularExpresion
{
    /*
     <em> :
     *single asterisks*     
     _single underscores_
     */
    
    NSError *error = nil;
    NSRegularExpression *regexp = [CBCTKMarkdownParser markdownRegularExpressionForEm];
    STAssertNotNil(regexp, @"Regular expression creation failed: %@", error);
    
    NSString *string = @"*single asterisks*";
    NSArray *matches = [regexp matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    STAssertEquals((int)matches.count, (int)1, @"Should match 1 time");
    
    NSTextCheckingResult *result = [matches lastObject];
    STAssertEquals(result.range, NSMakeRange(0, string.length), @"Should match characters 0...%d", string.length);
    STAssertEquals(result.numberOfRanges, (NSUInteger)3, @"Result should have 3 ranges");
    STAssertEquals([result rangeAtIndex:2], NSMakeRange(1, string.length - 2), @"Second range should match containing text");

    
    string = @"_single underscores_";
    matches = [regexp matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    STAssertEquals((int)matches.count, (int)1, @"Should match 1 time");
    
    result = [matches lastObject];
    STAssertEquals(result.range, NSMakeRange(0, string.length), @"Should match characters 0...%d", string.length);
    STAssertEquals(result.numberOfRanges, (NSUInteger)3, @"Result should have 3 ranges");
    STAssertEquals([result rangeAtIndex:2], NSMakeRange(1, string.length - 2), @"Second range should match containing text");
}

- (void) testSimpleMarkdownFormats
{
    NSString *markdown = @"**strong1** _ __strong2__ * *em1* *em2*";
    
    CBCTKMarkdownParser *parser = [[CBCTKMarkdownParser alloc] initWithFontFamilyName:@"Helvetica" fontSize:12 textColor:nil];
    STAssertNotNil(parser, @"Parser creation should not result in nil");
    
    NSAttributedString *result = [parser parseMarkdownString:markdown];
    STAssertNotNil(result, @"Parsing result should not be nil");
    STAssertEqualObjects([result string], @"strong1 _ strong2 * em1 em2", @"Formatting tags should be removed from result");
    // TODO check formats
}

@end
