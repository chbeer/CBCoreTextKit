//
//  CBCTKFontManager.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 07.11.12.
//
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <CoreText/CoreText.h>
#endif


#import "CBCTKGlobals.h"


@class CBCTKFontDescription;


@interface CBCTKFontManager : NSObject

+ (void) registerFontWithName:(NSString*)fontName withFamilyName:(NSString*)family italic:(BOOL)italic bold:(BOOL)bold monospace:(BOOL)monospace;
+ (NSString*) fontNameForFontWithFamilyName:(NSString*)family italic:(BOOL)italic bold:(BOOL)bold monospace:(BOOL)monospace;

+ (BOOL) isFontRegisteredWithName:(NSString*)fontName isItalic:(BOOL*)italic isBold:(BOOL*)bold monospace:(BOOL*)monospace;

+ (CTFontRef) createFontWithFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize
                  fontAttributes:(CBCTKFontAttributes)fontAttributes;

@end
