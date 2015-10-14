//
//  NSAttributedString+UIKit.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 31.01.13.
//  Copyright (c) 2013 Christian Beer. All rights reserved.
//

#if TARGET_OS_IPHONE

#import <Foundation/Foundation.h>

#import <CoreText/CoreText.h>


extern NSParagraphStyle *CBCTKNSParagraphStyleFromCTParagraphStyle(CTParagraphStyleRef ctParagraphStyle);

@interface NSAttributedString (CBCTK_UIKit)

- (NSAttributedString*) copyWithUIKitAttributes;

@end

#endif
