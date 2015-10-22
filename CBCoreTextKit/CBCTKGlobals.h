//
//  CBCTKGlobals.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 05.09.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>


#if TARGET_OS_IPHONE

#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

typedef UIColor CBColor;
typedef UIFont  CBFont;

#else

#import <AppKit/AppKit.h>

typedef NSColor CBColor;
typedef NSFont  CBFont;

#endif


typedef struct {
    BOOL bold, italic, underline, monospace;
    CGColorRef textColor;
} CBCTKFontAttributes;

typedef struct {
    CTTextAlignment alignment;
    CGFloat firstLineHeadIndent;
    CGFloat headIndent;
    CGFloat tailIndent;
    CGFloat defaultTabInterval;
    CTLineBreakMode lineBreakMode;
    CGFloat lineHeightMultiple;
    CGFloat maximumLineHeight;
    CGFloat minimumLineHeight;
    CGFloat lineSpacing;
    CGFloat paragraphSpacing;
    CGFloat paragraphSpacingBefore;
    CTWritingDirection baseWritingDirection;
} CBNSAttributedStringParagraphAttributes;

extern const CBNSAttributedStringParagraphAttributes kCBNSParagraphAttributesDefault;
extern const CBNSAttributedStringParagraphAttributes kCBNSParagraphAttributesZero;

BOOL CBNSAttributedStringParagraphAttributesEqual(CBNSAttributedStringParagraphAttributes a, CBNSAttributedStringParagraphAttributes b);
BOOL CBNSAttributedStringParagraphAttributesZero(CBNSAttributedStringParagraphAttributes a);

NSParagraphStyle *CBNSParagraphStyleWithAttributes(CBNSAttributedStringParagraphAttributes attr);
