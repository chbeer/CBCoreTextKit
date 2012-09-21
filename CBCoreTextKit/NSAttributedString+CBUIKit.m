//
//  NSAttributedString+CBUIKit.m
//  CBUIKit
//
//  Created by Christian Beer on 24.08.12.
//
//

#import <CoreText/CoreText.h>

#import "NSAttributedString+CBUIKit.h"

const CBNSAttributedStringParagraphAttributes kCBNSParagraphAttributesDefault = { kCTNaturalTextAlignment, 0.0, 0.0, 0.0, 0.0, kCTLineBreakByWordWrapping, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, kCTWritingDirectionNatural};
const CBNSAttributedStringParagraphAttributes kCBNSParagraphAttributesZero = { 0, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0};

BOOL CBNSAttributedStringParagraphAttributesEqual(CBNSAttributedStringParagraphAttributes a, CBNSAttributedStringParagraphAttributes b) {
    return (a.alignment == b.alignment &&
            a.firstLineHeadIndent == b.firstLineHeadIndent &&
            a.headIndent == b.headIndent &&
            a.tailIndent == b.tailIndent &&
            a.defaultTabInterval == b.defaultTabInterval &&
            a.lineBreakMode == b.lineBreakMode &&
            a.lineHeightMultiple == b.lineHeightMultiple &&
            a.maximumLineHeight == b.maximumLineHeight &&
            a.minimumLineHeight == b.minimumLineHeight &&
            a.lineSpacing == b.lineSpacing &&
            a.paragraphSpacing == b.paragraphSpacing &&
            a.paragraphSpacingBefore == b.paragraphSpacingBefore &&
            a.baseWritingDirection == b.baseWritingDirection);
}
BOOL CBNSAttributedStringParagraphAttributesZero(CBNSAttributedStringParagraphAttributes a) {
    return (a.alignment == 0 &&
            a.firstLineHeadIndent == 0.0 &&
            a.headIndent == 0.0 &&
            a.tailIndent == 0.0 &&
            a.defaultTabInterval == 0.0 &&
            a.lineBreakMode == 0 &&
            a.lineHeightMultiple == 0.0 &&
            a.maximumLineHeight == 0.0 &&
            a.minimumLineHeight == 0.0 &&
            a.lineSpacing == 0.0 &&
            a.paragraphSpacing == 0.0 &&
            a.paragraphSpacingBefore == 0.0 &&
            a.baseWritingDirection == 0);
}

@implementation NSAttributedString (CBUIKit)

+ (CTParagraphStyleRef) createParagraphStyleFromParagraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
{
    if (CBNSAttributedStringParagraphAttributesZero(paragraphAttributes)) return NULL;
    if (CBNSAttributedStringParagraphAttributesEqual(paragraphAttributes, kCBNSParagraphAttributesDefault)) return NULL;
    
    CTParagraphStyleSetting settings[kCTParagraphStyleSpecifierCount];
    int settingsCount = 0;
    
    if (paragraphAttributes.alignment != 0 && paragraphAttributes.alignment != kCTNaturalTextAlignment) {
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
    if (paragraphAttributes.lineSpacing != 0.0) {
        settings[settingsCount++] = (CTParagraphStyleSetting){kCTParagraphStyleSpecifierLineSpacing, sizeof(paragraphAttributes.lineSpacing), &paragraphAttributes.lineSpacing};
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
                   fontAttributes:(CBNSAttributedStringFontAttributes)fontAttributes paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
             additionalAttributes:(NSDictionary*)additionalAttributes
{
    /// ---  FONT ---
    
    CTFontSymbolicTraits traits = 0;
    if (fontAttributes.bold)
	{
		traits |= kCTFontBoldTrait;
	}
	if (fontAttributes.italic)
	{
		traits |= kCTFontItalicTrait;
	}
	if (fontAttributes.monospace)
	{
		traits |= kCTFontMonoSpaceTrait;
	}
    
    NSDictionary *fontAttr = [NSDictionary dictionaryWithObjectsAndKeys:
                              fontFamily, kCTFontFamilyNameAttribute,
                              [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:traits]
                                                          forKey:(id)kCTFontSymbolicTrait], kCTFontTraitsAttribute,
                              nil];
    
    CTFontDescriptorRef descriptor = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)fontAttr);
    CTFontRef font = CTFontCreateWithFontDescriptor(descriptor, fontSize, NULL);
    CFRelease(descriptor);
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    [attr setObject:(__bridge id)font
             forKey:(id)kCTFontAttributeName];
    
    if (fontAttributes.underline) {
        [attr setObject:[NSNumber numberWithInteger:kCTUnderlineStyleSingle]
                 forKey:(id)kCTUnderlineStyleAttributeName];
    }
    
    /// --- PARAGRAPH ---
    
    CTParagraphStyleRef paragraphStyle = [self createParagraphStyleFromParagraphAttributes:paragraphAttributes];
    if (paragraphStyle) {
        [attr setObject:(__bridge id)paragraphStyle forKey:(id)kCTParagraphStyleAttributeName];
        CFRelease(paragraphStyle);
    }
    
    /// --- COLOR ---
    
    if (fontAttributes.textColor) {
        [attr setObject:(__bridge id)fontAttributes.textColor forKey:(id)kCTForegroundColorAttributeName];
    }
    
    [attr setObject:[NSNull null] forKey:@"NSKernAttributeName"];
    [attr setObject:[NSNumber numberWithInt:1] forKey:@"NSLigatureAttributeName"];
    
    if (additionalAttributes) {
        [attr addEntriesFromDictionary:additionalAttributes];
    }
    
    NSAttributedString *attrString = [[self alloc] initWithString:string
                                                       attributes:attr];
    
    CFRelease(font);
    
    return attrString;
}
+ (id) attributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
                   fontAttributes:(CBNSAttributedStringFontAttributes)fontAttributes paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
{
    return [self attributedStringWithString:string fontFamilyName:fontFamily fontSize:fontSize fontAttributes:fontAttributes
                        paragraphAttributes:paragraphAttributes additionalAttributes:nil];
}
+ (id) attributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
                   fontAttributes:(CBNSAttributedStringFontAttributes)fontAttributes
{
    return [self attributedStringWithString:string fontFamilyName:fontFamily fontSize:fontSize fontAttributes:fontAttributes
                        paragraphAttributes:kCBNSParagraphAttributesZero additionalAttributes:nil];
}

#pragma mark - By font name

+ (id) attributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize
                        underline:(BOOL)underline textColor:(UIColor*)textColor paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
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
    
    CTParagraphStyleRef paragraphStyle = [self createParagraphStyleFromParagraphAttributes:paragraphAttributes];
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
                        underline:(BOOL)underline textColor:(UIColor*)textColor paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
{
    return [self attributedStringWithString:string fontName:fontName fontSize:fontSize underline:underline textColor:textColor paragraphAttributes:paragraphAttributes additionalAttributes:nil];
}
+ (id) attributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize
                        underline:(BOOL)underline textColor:(UIColor*)textColor
{
    return [self attributedStringWithString:string fontName:fontName fontSize:fontSize underline:underline textColor:textColor paragraphAttributes:kCBNSParagraphAttributesZero additionalAttributes:nil];
}

#pragma mark html

+ (NSAttributedString*) parseHTMLString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
{
    NSScanner *scanner = [NSScanner scannerWithString:string];
    scanner.charactersToBeSkipped = nil;
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    
    NSString *scanned = nil;
    CBNSAttributedStringFontAttributes attributes = {NO, NO, NO, NO};
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


@implementation NSMutableAttributedString (CBUIKit)

- (void) appendAttributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize fontAttributes:(CBNSAttributedStringFontAttributes)attributes
                      paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
                     additionalAttributes:(NSDictionary*)additionalAttributes
{
    [self appendAttributedString:[NSAttributedString attributedStringWithString:string fontFamilyName:fontFamily fontSize:fontSize fontAttributes:attributes paragraphAttributes:paragraphAttributes additionalAttributes:additionalAttributes]];
}
- (void) appendAttributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize fontAttributes:(CBNSAttributedStringFontAttributes)attributes
                      paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
{
    [self appendAttributedString:[NSAttributedString attributedStringWithString:string fontFamilyName:fontFamily fontSize:fontSize fontAttributes:attributes paragraphAttributes:paragraphAttributes additionalAttributes:nil]];
}
- (void) appendAttributedStringWithString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize fontAttributes:(CBNSAttributedStringFontAttributes)attributes
{
    [self appendAttributedString:[NSAttributedString attributedStringWithString:string fontFamilyName:fontFamily fontSize:fontSize fontAttributes:attributes paragraphAttributes:kCBNSParagraphAttributesZero additionalAttributes:nil]];
}

- (void) appendAttributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize underline:(BOOL)underline textColor:(UIColor*)textColor
                      paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
                     additionalAttributes:(NSDictionary*)additionalAttributes
{
    [self appendAttributedString:[NSAttributedString attributedStringWithString:string fontName:fontName fontSize:fontSize underline:underline textColor:textColor paragraphAttributes:paragraphAttributes additionalAttributes:additionalAttributes]];
}
- (void) appendAttributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize underline:(BOOL)underline textColor:(UIColor*)textColor
                      paragraphAttributes:(CBNSAttributedStringParagraphAttributes)paragraphAttributes
{
    [self appendAttributedString:[NSAttributedString attributedStringWithString:string fontName:fontName fontSize:fontSize underline:underline textColor:textColor paragraphAttributes:paragraphAttributes additionalAttributes:nil]];
}
- (void) appendAttributedStringWithString:(NSString*)string fontName:(NSString*)fontName fontSize:(CGFloat)fontSize underline:(BOOL)underline textColor:(UIColor*)textColor
{
    [self appendAttributedString:[NSAttributedString attributedStringWithString:string fontName:fontName fontSize:fontSize underline:underline textColor:textColor paragraphAttributes:kCBNSParagraphAttributesZero additionalAttributes:nil]];
}

@end