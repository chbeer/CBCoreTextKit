//
//  CBCTKGlobals.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 05.09.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>


#if TARGET_OS_IPHONE
typedef UIColor CBColor;
#else

#import <AppKit/AppKit.h>

typedef NSColor CBColor;
#endif
