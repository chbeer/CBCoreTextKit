//
//  CBCTKFontManager.m
//  CBCoreTextKit
//
//  Created by Christian Beer on 07.11.12.
//
//

#import "CBCTKFontManager.h"

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
    return [[self fontDescriptors] objectForKey:[self keyForFontWithFamilyName:family italic:italic bold:bold monospace:monospace]];
}

@end
