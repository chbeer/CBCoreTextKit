//
//  NSAttributedString+Glyphs.m
//  CBCoreTextKit
//
//  Created by Christian Beer on 19.10.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import "NSAttributedString+Glyphs.h"

@implementation NSAttributedString (CBCTK_Glyphs)

+ (id) attributedStringWithGlpyhWithName:(NSString*)glyphName font:(id)font
                               textColor:(CBColor*)textColor paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
                    additionalAttributes:(NSDictionary*)additionalAttributes
{
    if (!glyphName) return nil;
    
    CTGlyphInfoRef glyphInfo = CTGlyphInfoCreateWithGlyphName((__bridge CFStringRef)glyphName, (__bridge CTFontRef)(font), (__bridge CFStringRef)@"x");
    if (!glyphInfo) {
        return nil;
    }
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    [attr setObject:font
             forKey:(id)kCTFontAttributeName];
    
    if (textColor) {
        [attr setObject:(id)[textColor CGColor] forKey:(id)kCTForegroundColorAttributeName];
    }
    
    /// --- PARAGRAPH ---
    
    CTParagraphStyleRef paragraphStyle = CBCTKCreateParagraphStyleFromParagraphAttributes(paragraphAttributes);
    if (paragraphStyle) {
        [attr setObject:(__bridge id)paragraphStyle forKey:(id)kCTParagraphStyleAttributeName];
        CFRelease(paragraphStyle);
    }
    
    if (additionalAttributes) {
        [attr addEntriesFromDictionary:additionalAttributes];
    }
    
    [attr setObject:(__bridge id)glyphInfo forKey:(id)kCTGlyphInfoAttributeName];
    
    NSAttributedString *attrString = [[self alloc] initWithString:@"x"
                                                       attributes:attr];
    
    CFRelease(glyphInfo);
    
    return attrString;
}
+ (id) attributedStringWithGlpyhWithName:(NSString*)glyphName fontName:(NSString*)fontName size:(CGFloat)fontSize
                               textColor:(CBColor*)textColor paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
                    additionalAttributes:(NSDictionary*)additionalAttributes
{
    if (!glyphName) return nil;
    
    CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)fontName, fontSize, NULL);
    
    id attrString = [self attributedStringWithGlpyhWithName:glyphName font:(__bridge id)(font) textColor:textColor paragraphAttributes:paragraphAttributes
                                       additionalAttributes:additionalAttributes];
    
    CFRelease(font);
    
    return attrString;
}

+ (id) attributedStringWithGlpyhWithName:(NSString*)glyphName fontName:(NSString*)fontName size:(CGFloat)size textColor:(CBColor*)textColor
{
    return [self attributedStringWithGlpyhWithName:glyphName fontName:fontName size:size textColor:textColor
                               paragraphAttributes:kCBNSParagraphAttributesZero additionalAttributes:nil];
}
+ (id) attributedStringWithGlpyhWithName:(NSString*)glyphName fontName:(NSString*)fontName size:(CGFloat)size
{
    return [self attributedStringWithGlpyhWithName:glyphName fontName:fontName size:size textColor:nil
                               paragraphAttributes:kCBNSParagraphAttributesZero additionalAttributes:nil];
}

@end


@implementation NSMutableAttributedString (CBCTK_Glyphs)

- (void) appendAttributedStringWithGlpyhWithName:(NSString*)glyphName fontName:(NSString*)fontName size:(CGFloat)fontSize
                                       textColor:(CBColor*)textColor paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
                            additionalAttributes:(NSDictionary*)additionalAttributes;
{
    [self appendAttributedString:[NSAttributedString attributedStringWithGlpyhWithName:glyphName fontName:fontName size:fontSize
                                                                             textColor:textColor paragraphAttributes:paragraphAttributes
                                                                  additionalAttributes:additionalAttributes]];
}
- (void) appendAttributedStringWithGlpyhWithName:(NSString*)glyphName fontName:(NSString*)fontName size:(CGFloat)size textColor:(CBColor*)textColor;
{
    [self appendAttributedString:[NSAttributedString attributedStringWithGlpyhWithName:glyphName fontName:fontName size:size
                                                                             textColor:textColor paragraphAttributes:kCBNSParagraphAttributesZero
                                                                  additionalAttributes:nil]];
}
- (void) appendAttributedStringWithGlpyhWithName:(NSString*)glyphName fontName:(NSString*)fontName size:(CGFloat)size;
{
    [self appendAttributedString:[NSAttributedString attributedStringWithGlpyhWithName:glyphName fontName:fontName size:size
                                                                             textColor:nil paragraphAttributes:kCBNSParagraphAttributesZero
                                                                  additionalAttributes:nil]];
}

@end

