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

+ (NSString*) keyForFontWithFamilyName:(NSString*)family italic:(BOOL)italic bold:(BOOL)bold
{
    return [NSString stringWithFormat:@"%@#%c%c", family, bold ? 'b' : '-', italic ? 'i' : '-'];
}

+ (void) registerFontWithName:(NSString*)fontName withFamilyName:(NSString*)family italic:(BOOL)italic bold:(BOOL)bold
{
    NSString *key = [self keyForFontWithFamilyName:family italic:italic bold:bold];
    [[self fontDescriptors] setObject:fontName forKey:key];
}

+ (void) loadFontMappingFromPlistAtURL:(NSURL*)url
{
    NSArray *fonts = [NSArray arrayWithContentsOfURL:url];
    
    for (NSDictionary *font in fonts) {
        NSString *name = [font objectForKey:@"name"];
        NSString *fontName = [font objectForKey:@"fontName"];
        NSString *boldFontName = [font objectForKey:@"boldFontName"];
        NSString *italicFontName = [font objectForKey:@"italicFontName"];
        
    }
}

@end
