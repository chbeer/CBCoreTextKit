//
//  CBCTKFontManager.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 07.11.12.
//
//

#import <Foundation/Foundation.h>

@class CBCTKFontDescription;


@interface CBCTKFontManager : NSObject

+ (void) registerFontWithName:(NSString*)fontName withFamilyName:(NSString*)family italic:(BOOL)italic bold:(BOOL)bold monospace:(BOOL)monospace;
+ (NSString*) fontNameForFontWithFamilyName:(NSString*)family italic:(BOOL)italic bold:(BOOL)bold monospace:(BOOL)monospace;

@end
