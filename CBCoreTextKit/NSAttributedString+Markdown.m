//
//  NSAttributedString+Markdown.m
//  CBCoreTextKit
//
//  Created by Christian Beer on 09.11.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import "NSAttributedString+Markdown.h"

#import "NSAttributedString+CBCoreTextKit.h"



// NOTE: this is work in progress!! Switching to Regular Expressions...



/** This Markdown scanner currently only supports the following:

 EMPHASIS
 
 Markdown treats asterisks (*) and underscores (_) as indicators of emphasis. Text wrapped with one * or _ will be wrapped with an HTML <em> tag; double *’s or _’s will be wrapped with an HTML <strong> tag.
 (where <em> is treated as italic; <strong> as bold)
 */

@implementation NSAttributedString (Markdown)

- (id)initWithMarkdownData:(NSData *)data options:(NSDictionary*)dict;
{
    return [self initWithMarkdownString:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]
                                options:dict];
}
- (id)initWithMarkdownString:(NSString *)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize textColor:(UIColor*)textColor
{
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner setCharactersToBeSkipped:nil];
    
    NSCharacterSet *markdownBasicSyntaxCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"*/_'"];
    
    if (!textColor) {
        textColor = [UIColor darkTextColor];
    }
    
    CBNSAttributedStringFontAttributes attributes = {NO, NO, NO, NO, [textColor CGColor]};
    
    NSString *temp = nil;
    while (![scanner isAtEnd]) {
        
        BOOL readCharacters = [scanner scanUpToCharactersFromSet:markdownBasicSyntaxCharacterSet
                                                      intoString:&temp];
        
        if (readCharacters) {
            [result appendAttributedString:[NSAttributedString attributedStringWithString:temp fontFamilyName:fontFamily fontSize:fontSize
                                                                           fontAttributes:attributes]];
        }
        
        // characters need to be paired to form a tag
        if ([scanner scanString:@"*" intoString:NULL]) {
            attributes.bold = !attributes.bold;
        } else if ([scanner scanString:@"/" intoString:NULL]) {
            attributes.italic = !attributes.italic;
        } else if ([scanner scanString:@"_" intoString:NULL]) {
            attributes.underline = !attributes.underline;
        } else if ([scanner scanString:@"'" intoString:NULL]) {
            attributes.monospace = !attributes.monospace;
        } else {
            NSString *character = nil;
            if ([scanner scanCharactersFromSet:markdownBasicSyntaxCharacterSet
                                    intoString:&character]) {
                [result appendAttributedString:[NSAttributedString attributedStringWithString:character fontFamilyName:fontFamily fontSize:fontSize
                                                                               fontAttributes:attributes]];
            }
        }
        
    }
    
    if (![scanner isAtEnd]) {
        [result appendAttributedString:[NSAttributedString attributedStringWithString:temp fontFamilyName:fontFamily fontSize:fontSize
                                                                       fontAttributes:attributes]];
    }
    
    return result;
}
- (id)initWithMarkdownString:(NSString *)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
{
    return [self initWithMarkdownString:string fontFamilyName:fontFamily fontSize:fontSize textColor:nil];
}

- (id)initWithMarkdownString:(NSString *)string options:(NSDictionary*)dict;
{
    NSString *fontFamily = @"Helvetica";
    CGFloat fontSize = 12;
    
    if ([dict objectForKey:@"FontFamily"]) {
        fontFamily = [dict objectForKey:@"FontFamily"];
    }
    if ([dict objectForKey:@"FontSize"]) {
        fontSize = [[dict objectForKey:@"FontSize"] floatValue];
    }
    
    return [self initWithMarkdownString:string fontFamilyName:fontFamily fontSize:fontSize];
}

// convenience methods
+ (NSAttributedString *)attributedStringWithMarkdownString:(NSString *)string options:(NSDictionary *)options;
{
    return [[self alloc] initWithMarkdownString:string options:options];
}
+ (NSAttributedString *)attributedStringWithMarkdownString:(NSString *)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize textColor:(UIColor*)color;
{
    return [[self alloc] initWithMarkdownString:string fontFamilyName:fontFamily fontSize:fontSize textColor:color];
}
+ (NSAttributedString *)attributedStringWithMarkdownString:(NSString *)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize;
{
    return [[self alloc] initWithMarkdownString:string fontFamilyName:fontFamily fontSize:fontSize];
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
+ (NSRegularExpression*) markdownRegularExpressionForStrong:(NSError*__autoreleasing*)error
{
    return [NSRegularExpression regularExpressionWithPattern:@"(\\*\\*|__)(?=\\S)(.+?[*_]*)(?<=\\S)\\1"
                                                     options:0 error:error];
}

@end
