//
//  NSAttributedString+Markdown.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 09.11.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Markdown)

- (id)initWithMarkdownData:(NSData *)data options:(NSDictionary*)dict;
- (id)initWithMarkdownString:(NSString *)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize textColor:(UIColor*)textColor;
- (id)initWithMarkdownString:(NSString *)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize;
- (id)initWithMarkdownString:(NSString *)string options:(NSDictionary*)dict;

// convenience methods
+ (NSAttributedString *)attributedStringWithMarkdownString:(NSString *)string options:(NSDictionary *)options;
+ (NSAttributedString *)attributedStringWithMarkdownString:(NSString *)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize;
+ (NSAttributedString *)attributedStringWithMarkdownString:(NSString *)string fontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize textColor:(UIColor*)textColor;


+ (NSRegularExpression*) markdownRegularExpressionForStrong:(NSError*__autoreleasing*)error;

@end
