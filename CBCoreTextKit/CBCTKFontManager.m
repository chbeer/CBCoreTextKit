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

+ (NSString*) fontNameForFontWithFamilyName:(NSString *)family italic:(BOOL)italic bold:(BOOL)bold monospace:(BOOL)monospace
{
    return [[self fontDescriptors] objectForKey:[self keyForFontWithFamilyName:family italic:italic bold:bold monospace:monospace]];
}

@end
