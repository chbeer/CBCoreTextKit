//
//  NSAttributedString+CBUIKit.h
//  CBUIKit
//
//  Created by Christian Beer on 24.08.12.
//
//

#import <Foundation/Foundation.h>

#import "CBCTKGlobals.h"


typedef struct {
    BOOL bold, italic, underline, monospace;
    CGColorRef textColor;
} CBNSAttributedStringFontAttributes;

typedef struct {
    CTTextAlignment alignment;
    CGFloat firstLineHeadIndent;
    CGFloat headIndent;
    CGFloat tailIndent;
    CGFloat defaultTabInterval;
    CTLineBreakMode lineBreakMode;
    CGFloat lineHeightMultiple;
    CGFloat maximumLineHeight;
    CGFloat minimumLineHeight;
    CGFloat lineSpacing;
    CGFloat paragraphSpacing;
    CGFloat paragraphSpacingBefore;
    CTWritingDirection baseWritingDirection;
} CBNSAttributedStringParagraphAttributes;

extern const CBNSAttributedStringParagraphAttributes kCBNSParagraphAttributesDefault;
extern const CBNSAttributedStringParagraphAttributes kCBNSParagraphAttributesZero;

extern CTParagraphStyleRef CBCTKCreateParagraphStyleFromParagraphAttributes(CBNSAttributedStringParagraphAttributes paragraphAttributes);


@interface NSAttributedString (CBUIKit)

+ (id) attributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
                   fontAttributes:(CBNSAttributedStringFontAttributes)fontAttributes paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
             additionalAttributes:(NSDictionary*)additionalAttributes;
+ (id) attributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
                   fontAttributes:(CBNSAttributedStringFontAttributes)fontAttributes paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes;
+ (id) attributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
                   fontAttributes:(CBNSAttributedStringFontAttributes)fontAttributes;

+ (id) attributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize
                        underline:(BOOL)underline textColor:(CBColor*)textColor paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
             additionalAttributes:(NSDictionary*)additionalAttributes;
+ (id) attributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize
                        underline:(BOOL)underline textColor:(CBColor*)textColor paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes;
+ (id) attributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize
                        underline:(BOOL)underline textColor:(CBColor*)textColor;

@end

@interface NSMutableAttributedString (CBUIKit)

- (void) appendAttributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize fontAttributes:(CBNSAttributedStringFontAttributes)attributes
                      paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
                     additionalAttributes:(NSDictionary*)additionalAttributes;
- (void) appendAttributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize fontAttributes:(CBNSAttributedStringFontAttributes)attributes
                      paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes;
- (void) appendAttributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize fontAttributes:(CBNSAttributedStringFontAttributes)attributes;

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