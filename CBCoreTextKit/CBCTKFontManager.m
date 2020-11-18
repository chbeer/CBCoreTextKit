//
//  CBCTKFontManager.m
//  CBCoreTextKit
//
//  Created by Christian Beer on 07.11.12.
//
//

#import "CBCTKFontManager.h"

static NSString * const kCBCTKFontManagerSystemFontName = @"-system";


@implementation CBCTKFontManager

+ (NSMutableDictionary*) fontDescriptors
{
    static NSMutableDictionary *fontDescriptors;
    if (!fontDescriptors) {
        fontDescriptors = [NSMutableDictionary dictionary];
    }
    return fontDescriptors;
}

+ (NSString*) keyForFontWithFamilyName:(NSString*)family italic:(BOOL)italic bold:(BOOL)bold monospace:(BOOL)monospace
{
    return [NSString stringWithFormat:@"%@#%c%c%c", family, bold ? 'b' : '-', italic ? 'i' : '-', monospace ? 'm' : '-'];
}

+ (void) registerFontWithName:(NSString*)fontName withFamilyName:(NSString*)family italic:(BOOL)italic bold:(BOOL)bold monospace:(BOOL)monospace
{
    NSString *key = [self keyForFontWithFamilyName:family italic:italic bold:bold monospace:monospace];
    [[self fontDescriptors] setObject:fontName forKey:key];
}

+ (BOOL) isFontRegisteredWithName:(NSString*)fontName isItalic:(BOOL*)italic isBold:(BOOL*)bold monospace:(BOOL*)monospace
{
    NSSet *keys = [[self fontDescriptors] keysOfEntriesPassingTest:^BOOL(id key, id obj, BOOL *stop) {
        if ([obj isEqual:fontName]) {
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    
    if (keys.count > 0) {
        
        NSString *key = [keys anyObject];
        NSUInteger idx = [key rangeOfString:@"#"].location;
        NSString *desc = [key substringFromIndex:idx + 1];
        
        BOOL isBold = [desc characterAtIndex:0] == 'b';
        BOOL isItalic = [desc characterAtIndex:1] == 'i';
        BOOL isMonospace = [desc characterAtIndex:2] == 'm';
        
        if (italic) *italic = isItalic;
        if (bold) *bold = isBold;
        if (monospace) *monospace = isMonospace;
        
        return YES;
    } else {
        return NO;
    }
}

+ (NSString*) fontNameForFontWithFamilyName:(NSString *)family italic:(BOOL)italic bold:(BOOL)bold monospace:(BOOL)monospace
{
    CBFont *font = [self createFontWithFamilyName:family fontSize:12 fontAttributes:(CBCTKFontAttributes){.bold = bold, .italic = italic, .monospace = monospace}];
    return font.fontName;
}


+ (CBFont*) createFontWithFamilyName:(NSString*)family fontSize:(CGFloat)fontSize
                  fontAttributes:(CBCTKFontAttributes)fontAttributes
{
    
    if ([family isEqual:kCBCTKFontManagerSystemFontName]) {
        family = [CBFont systemFontOfSize:12].familyName;
    }
    
    #if TARGET_OS_IPHONE

    NSMutableDictionary *traits = [NSMutableDictionary new];
    if (fontAttributes.bold) {
        traits[UIFontSymbolicTrait] = @(UIFontDescriptorTraitBold);
    }
    if (fontAttributes.italic) {
        traits[UIFontSymbolicTrait] = @(UIFontDescriptorTraitItalic);
    }
    if (fontAttributes.monospace) {
        traits[UIFontSymbolicTrait] = @(UIFontDescriptorTraitMonoSpace);
    }
    UIFontDescriptor *descriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:@{
                                                                                        UIFontDescriptorFamilyAttribute: family,
                                                                                        UIFontDescriptorTraitsAttribute: traits
                                                                                        }];
    UIFont *font = [UIFont fontWithDescriptor:descriptor size:fontSize];
    if (font == nil) {
        descriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:@{
            UIFontDescriptorFamilyAttribute: [CBFont systemFontOfSize:12].familyName,
            UIFontDescriptorTraitsAttribute: traits
        }];
        font = [UIFont fontWithDescriptor:descriptor size:fontSize];
    }
    if (font == nil) {
        font = [CBFont systemFontOfSize:fontSize];
    }
    return font;

    #else

    NSMutableDictionary *traits = [NSMutableDictionary new];
    if (fontAttributes.bold) {
        traits[NSFontSymbolicTrait] = @(NSFontDescriptorTraitBold);
    }
    if (fontAttributes.italic) {
        traits[NSFontSymbolicTrait] = @(NSFontDescriptorTraitItalic);
    }
    if (fontAttributes.monospace) {
        traits[NSFontSymbolicTrait] = @(NSFontDescriptorTraitMonoSpace);
    }
    NSFontDescriptor *descriptor = [NSFontDescriptor fontDescriptorWithFontAttributes:@{
                                                                                        NSFontFamilyAttribute: family,
                                                                                        NSFontTraitsAttribute: traits
                                                                                        }];
    NSFont *font = [NSFont fontWithDescriptor:descriptor size:fontSize];
    if (font == nil) {
        descriptor = [NSFontDescriptor fontDescriptorWithFontAttributes:@{
            NSFontFamilyAttribute: [CBFont systemFontOfSize:12].familyName,
            NSFontTraitsAttribute: traits
        }];
        font = [NSFont fontWithDescriptor:descriptor size:fontSize];
    }
    if (font == nil) {
        font = [CBFont systemFontOfSize:fontSize];
    }
    return font;

    #endif
}

@end
