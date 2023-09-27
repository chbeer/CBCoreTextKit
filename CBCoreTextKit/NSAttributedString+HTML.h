//
//  NSAttributedString+HTML.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 19.10.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
@import UIKit;
#else
@import AppKit;
#endif

@interface NSAttributedString (CBCTK_HTML)

+ (NSAttributedString*) parseHTMLString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize;

@end
