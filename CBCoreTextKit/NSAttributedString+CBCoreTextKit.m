//
//  NSAttributedString+CBCoreTextKit.m
//  CBCoreTextKit
//
//  Created by Christian Beer on 24.08.12.
//
//

#import <CoreText/CoreText.h>

#import "NSAttributedString+CBCoreTextKit.h"

#import "CBCTKFontManager.h"


@implementation NSAttributedString (CBCoreTextKit)

CTParagraphStyleRef CBCTKCreateParagraphStyleFromParagraphAttributes(CBNSAttributedStringParagraphAttributes paragraphAttributes)
{
    if (CBNSAttributedStringParagraphAttributesZero(paragraphAttributes)) return NULL;
    if (CBNSAttributedStringParagraphAttributesEqual(paragraphAttributes, kCBNSParagraphAttributesDefault)) return NULL;
    
    CTParagraphStyleSetting settings[kCTParagraphStyleSpecifierCount];
    int settingsCount = 0;
    
    if (paragraphAttributes.alignment != 0 && paragraphAttributes.alignment != kCTTextAlignmentNatural) {
        settings[settingsCount++] = (CTParagraphStyleSetting){kCTParagraphStyleSpecifierAlignment, sizeof(paragraphAttributes.alignment), &paragraphAttributes.alignment};
    }
    if (paragraphAttributes.firstLineHeadIndent != 0.0) {
        settings[settingsCount++] = (CTParagraphStyleSetting){kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(paragraphAttributes.firstLineHeadIndent), &paragraphAttributes.firstLineHeadIndent};
    }
    if (paragraphAttributes.headIndent != 0.0) {
        settings[settingsCount++] = (CTParagraphStyleSetting){kCTParagraphStyleSpecifierHeadIndent, sizeof(paragraphAttributes.headIndent), &paragraphAttributes.headIndent};
    }
    if (paragraphAttributes.tailIndent != 0.0) {
        settings[settingsCount++] = (CTParagraphStyleSetting){kCTParagraphStyleSpecifierTailIndent, sizeof(paragraphAttributes.tailIndent), &paragraphAttributes.tailIndent};
    }
    if (paragraphAttributes.defaultTabInterval != 0.0) {
        settings[settingsCount++] = (CTParagraphStyleSetting){kCTParagraphStyleSpecifierDefaultTabInterval, sizeof(paragraphAttributes.defaultTabInterval), &paragraphAttributes.defaultTabInterval};
    }
    if (paragraphAttributes.lineBreakMode != kCTLineBreakByWordWrapping) {
        settings[settingsCount++] = (CTParagraphStyleSetting){kCTParagraphStyleSpecifierLineBreakMode, sizeof(paragraphAttributes.lineBreakMode), &paragraphAttributes.lineBreakMode};
    }
    if (paragraphAttributes.lineHeightMultiple != 0.0) {
        settings[settingsCount++] = (CTParagraphStyleSetting){kCTParagraphStyleSpecifierLineHeightMultiple, sizeof(paragraphAttributes.lineHeightMultiple), &paragraphAttributes.lineHeightMultiple};
    }
    if (paragraphAttributes.minimumLineHeight != 0.0) {
        settings[settingsCount++] = (CTParagraphStyleSetting){kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(paragraphAttributes.minimumLineHeight), &paragraphAttributes.minimumLineHeight};
    }
    if (paragraphAttributes.maximumLineHeight != 0.0) {
        settings[settingsCount++] = (CTParagraphStyleSetting){kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(paragraphAttributes.maximumLineHeight), &paragraphAttributes.maximumLineHeight};
    }
    if (paragraphAttributes.paragraphSpacing != 0.0) {
        settings[settingsCount++] = (CTParagraphStyleSetting){kCTParagraphStyleSpecifierParagraphSpacing, sizeof(paragraphAttributes.paragraphSpacing), &paragraphAttributes.paragraphSpacing};
    }
    if (paragraphAttributes.paragraphSpacingBefore != 0.0) {
        settings[settingsCount++] = (CTParagraphStyleSetting){kCTParagraphStyleSpecifierParagraphSpacingBefore, sizeof(paragraphAttributes.paragraphSpacingBefore), &paragraphAttributes.paragraphSpacingBefore};
    }
    if (paragraphAttributes.baseWritingDirection != 0.0) {
        settings[settingsCount++] = (CTParagraphStyleSetting){kCTParagraphStyleSpecifierBaseWritingDirection, sizeof(paragraphAttributes.baseWritingDirection), &paragraphAttributes.baseWritingDirection};
    }

    if (settingsCount == 0) {
        return NULL;
    }
    
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, settingsCount);
    return paragraphStyle;
}

#pragma mark - By font family name

+ (id) attributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
                   fontAttributes:(CBCTKFontAttributes)fontAttributes paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
             additionalAttributes:(NSDictionary*)additionalAttributes
{
    if (!string) return nil;
    
    /// ---  FONT ---
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    [attr setObject:[CBCTKFontManager createFontWithFamilyName:fontFamily fontSize:fontSize fontAttributes:fontAttributes]
             forKey:(id)kCTFontAttributeName];
    
    if (fontAttributes.underline) {
        [attr setObject:[NSNumber numberWithInteger:kCTUnderlineStyleSingle]
                 forKey:(id)kCTUnderlineStyleAttributeName];
    }
    
    /// --- PARAGRAPH ---
    
    CTParagraphStyleRef paragraphStyle = CBCTKCreateParagraphStyleFromParagraphAttributes(paragraphAttributes);
    if (paragraphStyle) {
        [attr setObject:(__bridge id)paragraphStyle forKey:(id)kCTParagraphStyleAttributeName];
        CFRelease(paragraphStyle);
    }
    
    /// --- COLOR ---
    
    if (fontAttributes.textColor) {
        [attr setObject:fontAttributes.textColor forKey:NSForegroundColorAttributeName];
    }
    
    [attr setObject:[NSNull null] forKey:@"NSKernAttributeName"];
    [attr setObject:[NSNumber numberWithInt:1] forKey:@"NSLigatureAttributeName"];
    
    if (additionalAttributes) {
        [attr addEntriesFromDictionary:additionalAttributes];
    }
    
    NSAttributedString *attrString = [[self alloc] initWithString:string
                                                       attributes:attr];
    
    return attrString;
}
+ (id) attributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
                   fontAttributes:(CBCTKFontAttributes)fontAttributes paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
{
    return [self attributedStringWithString:string fontFamilyName:fontFamily fontSize:fontSize fontAttributes:fontAttributes
                        paragraphAttributes:paragraphAttributes additionalAttributes:nil];
}
+ (id) attributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
                   fontAttributes:(CBCTKFontAttributes)fontAttributes
{
    return [self attributedStringWithString:string fontFamilyName:fontFamily fontSize:fontSize fontAttributes:fontAttributes
                        paragraphAttributes:kCBNSParagraphAttributesZero additionalAttributes:nil];
}

#pragma mark - By font name

+ (id) attributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize
                        underline:(BOOL)underline textColor:(CBColor*)textColor paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
             additionalAttributes:(NSDictionary*)additionalAttributes
{
    if (!string) return nil;
    
    CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)fontName, fontSize, NULL);
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    [attr setObject:(__bridge id)font
             forKey:(id)kCTFontAttributeName];
    
    if (underline) {
        [attr setObject:[NSNumber numberWithInteger:kCTUnderlineStyleSingle]
                 forKey:(id)kCTUnderlineStyleAttributeName];
    }
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
    
    
    [attr setObject:[NSNull null] forKey:@"NSKernAttributeName"];
    [attr setObject:[NSNumber numberWithInt:1] forKey:@"NSLigatureAttributeName"];
    
    
    NSAttributedString *attrString = [[self alloc] initWithString:string
                                                       attributes:attr];
    
    CFRelease(font);
    
    return attrString;
}
+ (id) attributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize
                        underline:(BOOL)underline textColor:(CBColor*)textColor paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
{
    return [self attributedStringWithString:string fontName:fontName fontSize:fontSize underline:underline textColor:textColor paragraphAttributes:paragraphAttributes additionalAttributes:nil];
}
+ (id) attributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize
                        underline:(BOOL)underline textColor:(CBColor*)textColor
{
    return [self attributedStringWithString:string fontName:fontName fontSize:fontSize underline:underline textColor:textColor paragraphAttributes:kCBNSParagraphAttributesZero additionalAttributes:nil];
}

@end


@implementation NSMutableAttributedString (CBCoreTextKit)

- (void) appendAttributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize fontAttributes:(CBCTKFontAttributes)attributes
                      paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
                     additionalAttributes:(NSDictionary*)additionalAttributes
{
    [self appendAttributedString:[NSAttributedString attributedStringWithString:string fontFamilyName:fontFamily fontSize:fontSize fontAttributes:attributes paragraphAttributes:paragraphAttributes additionalAttributes:additionalAttributes]];
}
- (void) appendAttributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize fontAttributes:(CBCTKFontAttributes)attributes
                      paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
{
    [self appendAttributedString:[NSAttributedString attributedStringWithString:string fontFamilyName:fontFamily fontSize:fontSize fontAttributes:attributes paragraphAttributes:paragraphAttributes additionalAttributes:nil]];
}
- (void) appendAttributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize fontAttributes:(CBCTKFontAttributes)attributes
{
    [self appendAttributedString:[NSAttributedString attributedStringWithString:string fontFamilyName:fontFamily fontSize:fontSize fontAttributes:attributes paragraphAttributes:kCBNSParagraphAttributesZero additionalAttributes:nil]];
}

- (void) appendAttributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize underline:(BOOL)underline textColor:(CBColor*)textColor
                      paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
                     additionalAttributes:(NSDictionary*)additionalAttributes
{
    [self appendAttributedString:[NSAttributedString attributedStringWithString:string fontName:fontName fontSize:fontSize underline:underline textColor:textColor paragraphAttributes:paragraphAttributes additionalAttributes:additionalAttributes]];
}
- (void) appendAttributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize underline:(BOOL)underline textColor:(CBColor*)textColor
                      paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
{
    [self appendAttributedString:[NSAttributedString attributedStringWithString:string fontName:fontName fontSize:fontSize underline:underline textColor:textColor paragraphAttributes:paragraphAttributes additionalAttributes:nil]];
}
- (void) appendAttributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize underline:(BOOL)underline textColor:(CBColor*)textColor
{
    [self appendAttributedString:[NSAttributedString attributedStringWithString:string fontName:fontName fontSize:fontSize underline:underline textColor:textColor paragraphAttributes:kCBNSParagraphAttributesZero additionalAttributes:nil]];
}

- (void) cbctk_applyFontSize:(CGFloat)fontSize
{
    [self enumerateAttributesInRange:NSMakeRange(0, self.length)
                               options:0
                            usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
                                CTFontRef font = (__bridge CTFontRef)([attrs objectForKey:(id)kCTFontAttributeName]);
                                
                                if (font) {
                                    CTFontDescriptorRef desc = CTFontCopyFontDescriptor(font);
                                    font = CTFontCreateWithFontDescriptor(desc, fontSize, NULL);
                                    CFRelease(desc);
                                } else {
                                    // from CTFont documentation: "Default is Helvetica 12."
                                    font = CTFontCreateWithName((CFStringRef)@"Helvetica", fontSize, NULL);
                                }
                                
                                [self addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:range];
                                CFRelease(font);
                            }];
}

- (void) addParagraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes range:(NSRange)range
{
    [self addAttribute:(id)kCTParagraphStyleAttributeName
                 value:(__bridge id)(CBCTKCreateParagraphStyleFromParagraphAttributes(paragraphAttributes))
                 range:range];
}
- (void) addParagraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
{
    [self addParagraphAttributes:paragraphAttributes
                             range:NSMakeRange(0, self.length)];
}

@end
