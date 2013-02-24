//
//  CBCTKGlobals.m
//  CBCoreTextKit
//
//  Created by Christian Beer on 05.09.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import "CBCTKGlobals.h"

const CBNSAttributedStringParagraphAttributes kCBNSParagraphAttributesDefault = { kCTNaturalTextAlignment, 0.0, 0.0, 0.0, 0.0, kCTLineBreakByWordWrapping, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, kCTWritingDirectionNatural};
const CBNSAttributedStringParagraphAttributes kCBNSParagraphAttributesZero = { 0, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0};

BOOL CBNSAttributedStringParagraphAttributesEqual(CBNSAttributedStringParagraphAttributes a, CBNSAttributedStringParagraphAttributes b)
{
    return (a.alignment == b.alignment &&
            a.firstLineHeadIndent == b.firstLineHeadIndent &&
            a.headIndent == b.headIndent &&
            a.tailIndent == b.tailIndent &&
            a.defaultTabInterval == b.defaultTabInterval &&
            a.lineBreakMode == b.lineBreakMode &&
            a.lineHeightMultiple == b.lineHeightMultiple &&
            a.maximumLineHeight == b.maximumLineHeight &&
            a.minimumLineHeight == b.minimumLineHeight &&
            a.lineSpacing == b.lineSpacing &&
            a.paragraphSpacing == b.paragraphSpacing &&
            a.paragraphSpacingBefore == b.paragraphSpacingBefore &&
            a.baseWritingDirection == b.baseWritingDirection);
}
BOOL CBNSAttributedStringParagraphAttributesZero(CBNSAttributedStringParagraphAttributes a)
{
    return (a.alignment == 0 &&
            a.firstLineHeadIndent == 0.0 &&
            a.headIndent == 0.0 &&
            a.tailIndent == 0.0 &&
            a.defaultTabInterval == 0.0 &&
            a.lineBreakMode == 0 &&
            a.lineHeightMultiple == 0.0 &&
            a.maximumLineHeight == 0.0 &&
            a.minimumLineHeight == 0.0 &&
            a.lineSpacing == 0.0 &&
            a.paragraphSpacing == 0.0 &&
            a.paragraphSpacingBefore == 0.0 &&
            a.baseWritingDirection == 0);
}