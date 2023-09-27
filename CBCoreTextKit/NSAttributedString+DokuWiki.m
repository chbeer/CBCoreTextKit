//
//  CBNSAttributedString+DokuWiki.m
//  CBCoreTextKit
//
//  Created by Christian Beer on 28.06.11.
//  Copyright 2011 Christian Beer. All rights reserved.
//

#import "NSAttributedString+DokuWiki.h"

#import "NSAttributedString+CBCoreTextKit.h"

// NOTE: this only supports the basic text formatting described here: http://www.dokuwiki.org/syntax
//
// "DokuWiki supports bold, italic, underlined and monospaced texts. Of course you 
// can combine all these.
// DokuWiki supports **bold**, //italic//, __underlined__ and ''monospaced'' texts.
// Of course you can **__//''combine''//__** all these."


@interface NSAttributedString (DokuWiki_Private) 
@end


@implementation NSAttributedString (DokuWiki)

- (id)initWithDokuWikiData:(NSData *)data options:(NSDictionary*)dict;
{
    return [self initWithDokuWikiString:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] 
                                options:dict];
}
- (id)initWithDokuWikiString:(NSString *)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
{
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
 
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner setCharactersToBeSkipped:nil];
    
    NSCharacterSet *dokuWikiBasicSyntaxCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"*/_'"];
    
    CBCTKFontAttributes attributes = {NO, NO, NO, NO};
    
    NSString *temp = nil;
    while (![scanner isAtEnd]) {
        
        BOOL readCharacters = [scanner scanUpToCharactersFromSet:dokuWikiBasicSyntaxCharacterSet
                                             intoString:&temp];
        
        if (readCharacters) {
            [result appendAttributedString:[NSAttributedString attributedStringWithString:temp fontFamilyName:fontFamily fontSize:fontSize
                                                                           fontAttributes:attributes]];
        }
        
        // characters need to be paired to form a tag
        if ([scanner scanString:@"**" intoString:NULL]) {
            attributes.bold = !attributes.bold;
        } else if ([scanner scanString:@"//" intoString:NULL]) {
            attributes.italic = !attributes.italic;
        } else if ([scanner scanString:@"__" intoString:NULL]) {
            attributes.underline = !attributes.underline;
        } else if ([scanner scanString:@"''" intoString:NULL]) {
            attributes.monospace = !attributes.monospace;
        } else {
            NSString *character = nil;
            if ([scanner scanCharactersFromSet:dokuWikiBasicSyntaxCharacterSet 
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
- (id)initWithDokuWikiString:(NSString *)string options:(NSDictionary*)dict;
{
    NSString *fontFamily = @"Helvetica";
    CGFloat fontSize = 12;
    
    if ([dict objectForKey:@"FontFamily"]) {
        fontFamily = [dict objectForKey:@"FontFamily"];
    }
    if ([dict objectForKey:@"FontSize"]) {
        fontSize = [[dict objectForKey:@"FontSize"] floatValue];
    }

    return [self initWithDokuWikiString:string fontFamilyName:fontFamily fontSize:fontSize];
}

// convenience methods
+ (NSAttributedString *)attributedStringWithDokuWikiString:(NSString *)string options:(NSDictionary *)options;
{
    return [[self alloc] initWithDokuWikiString:string options:options];
}
+ (NSAttributedString *)attributedStringWithDokuWikiString:(NSString *)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize;
{
    return [[self alloc] initWithDokuWikiString:string fontFamilyName:fontFamily fontSize:fontSize];
}

@end
