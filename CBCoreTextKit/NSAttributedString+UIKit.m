//
//  NSAttributedString+UIKit.m
//  CBCoreTextKit
//
//  Created by Christian Beer on 31.01.13.
//  Copyright (c) 2013 Christian Beer. All rights reserved.
//

#import "NSAttributedString+UIKit.h"

@implementation NSAttributedString (CBCTK_UIKit)

+ (NSDictionary*) attributesDictionaryConvertedToUIKitAttributes:(NSDictionary*)dict
{
    NSMutableDictionary *mutable = [dict mutableCopy];
    
    for (NSString *key in [mutable allKeys]) {
        
        id value = [mutable objectForKey:key];
        
        CFTypeID typeID = CFGetTypeID((__bridge CFTypeRef)value);
        
        if (typeID == CTFontGetTypeID()) {
            CTFontRef ctFont = (__bridge CTFontRef)(value);
            NSString *fontName = (__bridge NSString *)CTFontCopyName(ctFont, kCTFontPostScriptNameKey);
            CGFloat fontSize = CTFontGetSize(ctFont);
            UIFont *font = [UIFont fontWithName:fontName size:fontSize];
            
            [mutable setObject:font forKey:key];

        } else if (typeID == CTParagraphStyleGetTypeID()) {
            CTParagraphStyleRef ctParagraphStyle = (__bridge CTParagraphStyleRef)(value);
            NSParagraphStyle *paragraphStyle = CBCTKNSParagraphStyleFromCTParagraphStyle(ctParagraphStyle);
            
            [mutable setObject:paragraphStyle forKey:key];
            
        } else if (typeID == CGColorGetTypeID()) {
            CGColorRef cgColorRef = (__bridge CGColorRef)(value);
            UIColor *color = [UIColor colorWithCGColor:cgColorRef];
            
            [mutable setObject:color forKey:key];

        } else if (typeID == CFNumberGetTypeID()) {
            // intentionally do nothing because of bridging

        } else if ([value isKindOfClass:[NSNull class]]) {
            // intentionally do nothing because it's clean
            
        } else {
#ifdef DEBUG
            NSLog(@"value: %@ (%@)", value, NSStringFromClass([value class]));
#endif
        }
        
        
    }
    
    return mutable;
}

- (NSAttributedString*) copyWithUIKitAttributes
{
    NSMutableAttributedString *mutable = [self mutableCopy];
    
    [mutable enumerateAttributesInRange:NSMakeRange(0, mutable.length)
                                options:0
                             usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
                                 NSDictionary *converted = [[self class] attributesDictionaryConvertedToUIKitAttributes:attrs];
                                 [mutable setAttributes:converted range:range];
                             }];
    
    return mutable;
}

#pragma mark -

NSParagraphStyle *CBCTKNSParagraphStyleFromCTParagraphStyle(CTParagraphStyleRef ctParagraphStyle)
{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    
    CTTextAlignment alignment;
    CTParagraphStyleGetValueForSpecifier(ctParagraphStyle, kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment);
    paragraphStyle.alignment = (NSTextAlignment)alignment;
    
    CGFloat firstLineHeadIndent;
    CTParagraphStyleGetValueForSpecifier(ctParagraphStyle, kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(firstLineHeadIndent), &firstLineHeadIndent);
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent;
    
    CGFloat headIndent;
    CTParagraphStyleGetValueForSpecifier(ctParagraphStyle, kCTParagraphStyleSpecifierHeadIndent, sizeof(headIndent), &headIndent);
    paragraphStyle.headIndent = headIndent;
    
    CGFloat tailIndent;
    CTParagraphStyleGetValueForSpecifier(ctParagraphStyle, kCTParagraphStyleSpecifierTailIndent, sizeof(tailIndent), &tailIndent);
    paragraphStyle.tailIndent = tailIndent;
    
    CGFloat paragraphSpacing;
    CTParagraphStyleGetValueForSpecifier(ctParagraphStyle, kCTParagraphStyleSpecifierParagraphSpacing, sizeof(paragraphSpacing), &paragraphSpacing);
    paragraphStyle.paragraphSpacing = paragraphSpacing;
    
    CGFloat paragraphSpacingBefore;
    CTParagraphStyleGetValueForSpecifier(ctParagraphStyle, kCTParagraphStyleSpecifierParagraphSpacingBefore,sizeof(paragraphSpacingBefore), &paragraphSpacingBefore);
    paragraphStyle.paragraphSpacingBefore = paragraphSpacingBefore;

    CTWritingDirection baseWritingDirection;
    CTParagraphStyleGetValueForSpecifier(ctParagraphStyle, kCTParagraphStyleSpecifierBaseWritingDirection, sizeof(baseWritingDirection), &baseWritingDirection);
    paragraphStyle.baseWritingDirection = (NSWritingDirection)baseWritingDirection;
    
    CGFloat minimumLineHeight, maximumLineHeight;
    CTParagraphStyleGetValueForSpecifier(ctParagraphStyle, kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(minimumLineHeight), &minimumLineHeight);
    CTParagraphStyleGetValueForSpecifier(ctParagraphStyle, kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(maximumLineHeight), &maximumLineHeight);
    paragraphStyle.minimumLineHeight = minimumLineHeight;
    paragraphStyle.maximumLineHeight = maximumLineHeight;
    
    CGFloat lineHeightMultiple;
    CTParagraphStyleGetValueForSpecifier(ctParagraphStyle, kCTParagraphStyleSpecifierLineHeightMultiple, sizeof(lineHeightMultiple), &lineHeightMultiple);
    paragraphStyle.lineHeightMultiple = lineHeightMultiple;
    
    return paragraphStyle;
}

@end
