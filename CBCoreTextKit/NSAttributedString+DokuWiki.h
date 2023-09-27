//
//  CBNSAttributedString+DokuWiki.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 28.06.11.
//  Copyright 2011 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <CoreText/CoreText.h>
#endif


@interface NSAttributedString (DokuWiki)

- (id)initWithDokuWikiString:(NSString *)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize;

- (id)initWithDokuWikiString:(NSString *)data options:(NSDictionary *)dict;
- (id)initWithDokuWikiData:(NSData *)data options:(NSDictionary *)dict;

// convenience methods
+ (NSAttributedString *)attributedStringWithDokuWikiString:(NSString *)string options:(NSDictionary *)options;
+ (NSAttributedString *)attributedStringWithDokuWikiString:(NSString *)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize;

@end
