//
//  NSAttributedString+HTML.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 19.10.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (CBCTK_HTML)

+ (NSAttributedString*) parseHTMLString:(NSString*)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize;

@end
