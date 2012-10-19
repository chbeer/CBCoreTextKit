//
//  NSAttributedString+Glyphs.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 19.10.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSAttributedString+CBCoreTextKit.h"

@interface NSAttributedString (CBCTK_Glyphs)

+ (id) attributedStringWithGlpyhWithName:(NSString*)glyphName font:(id)font
                               textColor:(CBColor*)textColor paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
                    additionalAttributes:(NSDictionary*)additionalAttributes;

+ (id) attributedStringWithGlpyhWithName:(NSString*)glyphName fontName:(NSString*)fontName size:(CGFloat)fontSize
                               textColor:(CBColor*)textColor paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
                    additionalAttributes:(NSDictionary*)additionalAttributes;
+ (id) attributedStringWithGlpyhWithName:(NSString*)glyphName fontName:(NSString*)fontName size:(CGFloat)size textColor:(CBColor*)textColor;
+ (id) attributedStringWithGlpyhWithName:(NSString*)glyphName fontName:(NSString*)fontName size:(CGFloat)size;

@end

@interface NSMutableAttributedString (CBCTK_Glyphs)

- (void) appendAttributedStringWithGlpyhWithName:(NSString*)glyphName fontName:(NSString*)fontName size:(CGFloat)fontSize
                                       textColor:(CBColor*)textColor paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
                            additionalAttributes:(NSDictionary*)additionalAttributes;
- (void) appendAttributedStringWithGlpyhWithName:(NSString*)glyphName fontName:(NSString*)fontName size:(CGFloat)size textColor:(CBColor*)textColor;
- (void) appendAttributedStringWithGlpyhWithName:(NSString*)glyphName fontName:(NSString*)fontName size:(CGFloat)size;

@end
