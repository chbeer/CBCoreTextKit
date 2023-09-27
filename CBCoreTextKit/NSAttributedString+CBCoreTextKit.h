//
//  NSAttributedString+CBCoreTextKit.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 24.08.12.
//
//

#import <Foundation/Foundation.h>

#import "CBCTKGlobals.h"


extern CTParagraphStyleRef CBCTKCreateParagraphStyleFromParagraphAttributes(CBNSAttributedStringParagraphAttributes paragraphAttributes);


@interface NSAttributedString (CBCoreTextKit)

+ (id) attributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
                   fontAttributes:(CBCTKFontAttributes)fontAttributes paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
             additionalAttributes:(NSDictionary*)additionalAttributes;
+ (id) attributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
                   fontAttributes:(CBCTKFontAttributes)fontAttributes paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes;
+ (id) attributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
                   fontAttributes:(CBCTKFontAttributes)fontAttributes;

+ (id) attributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize
                        underline:(BOOL)underline textColor:(CBColor*)textColor paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
             additionalAttributes:(NSDictionary*)additionalAttributes;
+ (id) attributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize
                        underline:(BOOL)underline textColor:(CBColor*)textColor paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes;
+ (id) attributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize
                        underline:(BOOL)underline textColor:(CBColor*)textColor;

@end

@interface NSMutableAttributedString (CBCoreTextKit)

- (void) appendAttributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize fontAttributes:(CBCTKFontAttributes)attributes
                      paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
                     additionalAttributes:(NSDictionary*)additionalAttributes;
- (void) appendAttributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize fontAttributes:(CBCTKFontAttributes)attributes
                      paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes;
- (void) appendAttributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize fontAttributes:(CBCTKFontAttributes)attributes;

- (void) appendAttributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize underline:(BOOL)underline textColor:(CBColor*)textColor
                      paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
                     additionalAttributes:(NSDictionary*)additionalAttributes;
- (void) appendAttributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize underline:(BOOL)underline textColor:(CBColor*)textColor
                      paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes;
- (void) appendAttributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize underline:(BOOL)underline textColor:(CBColor*)textColor;

- (void) cbctk_applyFontSize:(CGFloat)fontSize;

- (void) addParagraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes range:(NSRange)range;
- (void) addParagraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes;

@end
