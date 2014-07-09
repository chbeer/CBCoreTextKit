//
//  CBCTKMarkdownParser.m
//  CBCoreTextKit
//
//  Created by Christian Beer on 09.11.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import "CBCTKMarkdownParser.h"

#import "NSAttributedString+CBCoreTextKit.h"
#import "CBCTKFontManager.h"



// NOTE: this is work in progress!! Switching to Regular Expressions...



/** This Markdown scanner currently only supports the following:

 EMPHASIS
 
 Markdown treats asterisks (*) and underscores (_) as indicators of emphasis. Text wrapped with one * or _ will be wrapped with an HTML <em> tag; double *’s or _’s will be wrapped with an HTML <strong> tag.
 (where <em> is treated as italic; <strong> as bold)
 */

@implementation CBCTKMarkdownParser
{
    NSMutableArray *_formatPatterns;
}

- (id) initWithFontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize textColor:(CBColor*)textColor;
{
    self = [super init];
    if (!self) return nil;
    
    self.fontFamilyName = fontFamily;
    self.fontSize = fontSize;
    self.textColor = textColor;
    
    _formatPatterns = [NSMutableArray array];
    
    [self registerDefaultFormatPatterns];
    
    return self;
}
- (id) init
{
    return [self initWithFontFamilyName:@"Helvetica" fontSize:12 textColor:nil];
}

- (void) registerFormatPatternWithRegularExpression:(NSRegularExpression*)regularExpression handler:(CBCTKMarkdownFormatHandler)handler
{
    CBCTKMarkdownFormatPattern *pattern = [CBCTKMarkdownFormatPattern new];
    pattern.regularExpression = regularExpression;
    pattern.handler = handler;
    [_formatPatterns addObject:pattern];
}

- (void) registerDefaultFormatPatterns
{
    [self registerFormatPatternWithRegularExpression:[[self class] markdownRegularExpressionForStrong]
                                             handler:^NSAttributedString*(NSTextCheckingResult *result, NSAttributedString *attributedString, NSString *markdownString, NSRange *replacementRange) {
                                                 NSRange textRange = [result rangeAtIndex:2];
                                                 
                                                 CTFontRef font = [CBCTKFontManager createFontWithFamilyName:self.fontFamilyName fontSize:self.fontSize
                                                                                        fontAttributes:(CBCTKFontAttributes){.bold = YES}];
                                                 
                                                 NSMutableAttributedString *resultString = [[attributedString attributedSubstringFromRange:textRange] mutableCopy];
                                                 [resultString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, resultString.length)];
                                                 
                                                 return resultString;
                                             }];
    [self registerFormatPatternWithRegularExpression:[[self class] markdownRegularExpressionForEm]
                                             handler:^NSAttributedString*(NSTextCheckingResult *result, NSAttributedString *attributedString, NSString *markdownString, NSRange *replacementRange) {
                                                 NSRange textRange = [result rangeAtIndex:2];
                                                 
                                                 CTFontRef font = [CBCTKFontManager createFontWithFamilyName:self.fontFamilyName fontSize:self.fontSize
                                                                                        fontAttributes:(CBCTKFontAttributes){.italic = YES}];
                                                 
                                                 NSMutableAttributedString *resultString = [[attributedString attributedSubstringFromRange:textRange] mutableCopy];
                                                 [resultString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, resultString.length)];

                                                 return resultString;
                                             }];
}

#pragma mark - parse

- (NSAttributedString*) parseMarkdownString:(NSString*)string
{
    if (!string) return nil;
    
    NSMutableAttributedString *result = [NSMutableAttributedString attributedStringWithString:string
                                                                               fontFamilyName:self.fontFamilyName fontSize:self.fontSize
                                                                               fontAttributes:(CBCTKFontAttributes){.textColor = self.textColor.CGColor}];
    
    for (CBCTKMarkdownFormatPattern *pattern in self.formatPatterns) {
        NSString *string = [result string];
        
        NSArray *matches = [pattern.regularExpression matchesInString:string options:0 range:NSMakeRange(0, string.length)];
        for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
            NSRange replacementRange = match.range;
            NSAttributedString *formatted = pattern.handler(match, result, string, &replacementRange);
            if (formatted) {
                [result replaceCharactersInRange:replacementRange withAttributedString:formatted];
            }
        }
    }
    
    return result;
}

#pragma mark - Regular Expressions

/* From Markdown 1.0.1
 sub _DoItalicsAndBold {
 my $text = shift;
 
 # <strong> must go first:
 $text =~ s{ (\*\*|__) (?=\S) (.+?[*_]*) (?<=\S) \1 }
 {<strong>$2</strong>}gsx;
 
 $text =~ s{ (\*|_) (?=\S) (.+?) (?<=\S) \1 }
 {<em>$2</em>}gsx;
 
 return $text;
 }
*/
+ (NSRegularExpression*) markdownRegularExpressionForStrong
{
    NSError *error;
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"(\\*\\*|__)(?=\\S)(.+?[*_]*)(?<=\\S)\\1"
                                                                            options:0 error:&error];
    return regexp;
}
+ (NSRegularExpression*) markdownRegularExpressionForEm
{
    NSError *error;
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"(\\*|_)(?=\\S)(.+?)(?<=\\S)\\1"
                                                                            options:0 error:&error];
    return regexp;
}

@end


@implementation CBCTKMarkdownFormatPattern

@end
