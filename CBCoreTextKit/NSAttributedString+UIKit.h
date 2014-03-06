//
//  NSAttributedString+UIKit.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 31.01.13.
//  Copyright (c) 2013 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <CoreText/CoreText.h>
#endif


extern NSParagraphStyle *CBCTKNSParagraphStyleFromCTParagraphStyle(CTParagraphStyleRef ctParagraphStyle);

@interface NSAttributedString (CBCTK_UIKit)

- (NSAttributedString*) copyWithUIKitAttributes;

@end
