//
//  CBCTKTextAttachment.m
//  CBCoreTextKit
//
//  Created by Christian Beer on 05.09.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import "CBCTKTextAttachment.h"


@implementation CBCTKTextAttachment

- (id) initWithGetAscent:(CBCTKTextAttachmentGetFloatValueCallback)getAscentCallback
              getDescent:(CBCTKTextAttachmentGetFloatValueCallback)getDescentCallback
                getWidth:(CBCTKTextAttachmentGetFloatValueCallback)getWidthCallback
                    draw:(CBCTKTextAttachmentDrawCallback)draw;
{
    self = [super init];
    if (!self) return nil;
    
    self.getAscentCallback = getAscentCallback;
    self.getDescentCallback = getDescentCallback;
    self.getWidthCallback = getWidthCallback;
    self.drawCallback = draw;
    
    return self;
}

- (id) initWithAscent:(CGFloat)ascent
              descent:(CGFloat)descent
                width:(CGFloat)width
                 draw:(CBCTKTextAttachmentDrawCallback)draw;
{
    return [self initWithGetAscent:^CGFloat{
                            return ascent;
                        }
                        getDescent:^CGFloat{
                            return descent;
                        }
                          getWidth:^CGFloat{
                              return width;
                          }
                              draw:draw];
}

@end


///// Callbacks /////

void CBCTKTextAttachmentRunDelegateDealloc(void *context)
{
}

CGFloat CBCTKTextAttachmentRunDelegateGetAscent(void *context)
{
    if ([(__bridge id)context isKindOfClass:[CBCTKTextAttachment class]]) {
        CBCTKTextAttachment *att = (__bridge CBCTKTextAttachment *)(context);
        
        if (att.getAscentCallback) {
            return att.getAscentCallback();
        }
        
    }
    return 0;
}
CGFloat CBCTKTextAttachmentRunDelegateGetDescent(void *context)
{
    if ([(__bridge id)context isKindOfClass:[CBCTKTextAttachment class]]) {
        CBCTKTextAttachment *att = (__bridge CBCTKTextAttachment *)(context);
        
        if (att.getDescentCallback) {
            return att.getDescentCallback();
        }

    }
    return 0;
}
CGFloat CBCTKTextAttachmentRunDelegateGetWidth(void *context)
{
    if ([(__bridge id)context isKindOfClass:[CBCTKTextAttachment class]]) {
        CBCTKTextAttachment *att = (__bridge CBCTKTextAttachment *)(context);
        
        if (att.getWidthCallback) {
            return att.getWidthCallback();
        }
    
    }
    return 0;
}

CTRunDelegateCallbacks CBCTKTextAttachmentRunDelegateCreate(CBCTKTextAttachment *attachment)
{
    CTRunDelegateCallbacks callbacks;
	callbacks.version = kCTRunDelegateCurrentVersion;
    callbacks.dealloc = CBCTKTextAttachmentRunDelegateDealloc;
    callbacks.getAscent = CBCTKTextAttachmentRunDelegateGetAscent;
    callbacks.getDescent = CBCTKTextAttachmentRunDelegateGetDescent;
    callbacks.getWidth = CBCTKTextAttachmentRunDelegateGetWidth;
    
    return callbacks;
}