//
//  CBCoreTextKit.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 03.09.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE

#import <CoreText/CoreText.h>

#endif


#import "CBCTKGlobals.h"

#import "NSAttributedString+CBCoreTextKit.h"
#import "NSAttributedString+Glyphs.h"
#import "NSAttributedString+HTML.h"
#import "NSAttributedString+DokuWiki.h"

#import "CBCTKFontManager.h"

#import "CBCTKMarkdownParser.h"


#if TARGET_OS_IPHONE

#import "NSAttributedString+UIKit.h"

#endif