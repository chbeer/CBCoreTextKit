//
//  NSAttributedString+HTML.m
//  CBCoreTextKit
//
//  Created by Christian Beer on 19.10.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import "NSAttributedString+HTML.h"
#import "NSAttributedString+CBCoreTextKit.h"

@implementation NSAttributedString (CBCTK_HTML)

+ (NSAttributedString*) parseHTMLString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
{
    NSScanner *scanner = [NSScanner scannerWithString:string];
    scanner.charactersToBeSkipped = nil;
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    
    NSString *scanned = nil;
    CBCTKFontAttributes attributes = {NO, NO, NO, NO};
    BOOL found = YES;
    while (![scanner isAtEnd] && found) {
        found = NO;
        
        if ([scanner scanUpToString:@"<" intoString:&scanned]) {
            [result appendAttributedString:[self attributedStringWithString:scanned fontFamilyName:fontFamily fontSize:fontSize fontAttributes:attributes]];
            found = YES;
        }
        
        if ([scanner scanString:@"<" intoString:nil]) {
            NSString *tag = nil;
            BOOL tagScanned = [scanner scanUpToString:@">" intoString:&tag];
            
            if (tagScanned) {
                [scanner scanString:@">" intoString:nil];
                
                if ([@"br" isEqualToString:tag] || [@"br/" isEqualToString:tag]) {
                    NSAttributedString *br = [[NSAttributedString alloc] initWithString:@"\u2028"];
                    [result appendAttributedString:br];
                } else if ([@"b" isEqualToString:tag]) {
                    attributes.bold = YES;
                } else if ([@"/b" isEqualToString:tag]) {
                    attributes.bold = NO;
                } else if ([@"i" isEqualToString:tag]) {
                    attributes.italic = YES;
                } else if ([@"/i" isEqualToString:tag]) {
                    attributes.italic = NO;
                } else if ([@"u" isEqualToString:tag]) {
                    attributes.underline = YES;
                } else if ([@"/u" isEqualToString:tag]) {
                    attributes.underline = NO;
                } else if ([@"tt" isEqualToString:tag]) {
                    attributes.monospace = YES;
                } else if ([@"/tt" isEqualToString:tag]) {
                    attributes.monospace = NO;
                } else if ([@"code" isEqualToString:tag]) {
                    attributes.monospace = YES;
                } else if ([@"/code" isEqualToString:tag]) {
                    attributes.monospace = NO;
                }
                
                found = YES;
            }
        }
    }
    
    if (![scanner isAtEnd]) {
        NSString *string = [[scanner string] substringFromIndex:[scanner scanLocation]];
        [result appendAttributedString:[self attributedStringWithString:string fontFamilyName:fontFamily fontSize:fontSize fontAttributes:attributes]];
    }
    
    return  result;
}

@end
