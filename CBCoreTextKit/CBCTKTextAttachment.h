//
//  CBCTKTextAttachment.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 05.09.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef CGFloat(^CBCTKTextAttachmentGetFloatValueCallback)();
typedef CGFloat(^CBCTKTextAttachmentDrawCallback)(CGContextRef ctx);

@interface CBCTKTextAttachment : NSObject

@property (nonatomic, copy) CBCTKTextAttachmentGetFloatValueCallback getAscentCallback;
@property (nonatomic, copy) CBCTKTextAttachmentGetFloatValueCallback getDescentCallback;
@property (nonatomic, copy) CBCTKTextAttachmentGetFloatValueCallback getWidthCallback;
@property (nonatomic, copy) CBCTKTextAttachmentDrawCallback          drawCallback;

- (id) initWithGetAscent:(CBCTKTextAttachmentGetFloatValueCallback)getAscentCallback
              getDescent:(CBCTKTextAttachmentGetFloatValueCallback)getDescentCallback
                getWidth:(CBCTKTextAttachmentGetFloatValueCallback)getWidthCallback
                    draw:(CBCTKTextAttachmentDrawCallback)draw;
- (id) initWithAscent:(CGFloat)ascent
              descent:(CGFloat)descent
                width:(CGFloat)width
                 draw:(CBCTKTextAttachmentDrawCallback)draw;

@end
