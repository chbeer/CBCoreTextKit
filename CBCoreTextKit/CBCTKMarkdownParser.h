//
//  CBCTKMarkdownParser.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 09.11.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCTKGlobals.h"


typedef NSAttributedString*_Nonnull(^CBCTKMarkdownFormatHandler)(NSTextCheckingResult * _Nonnull result, NSAttributedString * _Nonnull attributedString, NSString * _Nonnull markdownString, NSRange * _Nonnull replacementRange);

@interface CBCTKMarkdownParser : NSObject

@property (nonatomic, strong, readonly) NSArray * _Nonnull formatPatterns;

@property (nonatomic, strong) NSString  * _Nonnull fontFamilyName;
@property (nonatomic, assign) CGFloat   fontSize;
@property (nonatomic, strong) CBColor   * _Nonnull textColor;


- (id _Nonnull ) init;
- (id _Nonnull ) initWithFontFamilyName:(NSString*_Nullable)fontFamily fontSize:(CGFloat)fontSize textColor:(CBColor*_Nullable)textColor;

- (NSAttributedString*_Nonnull) parseMarkdownString:(NSString*_Nonnull)string;

- (void) registerFormatPatternWithRegularExpression:(NSRegularExpression*_Nonnull)regularExpression handler:(CBCTKMarkdownFormatHandler _Nonnull )handler;

@end


@interface CBCTKMarkdownFormatPattern : NSObject

@property (nonatomic, strong)   NSRegularExpression         * _Nonnull regularExpression;
@property (nonatomic, copy)     CBCTKMarkdownFormatHandler _Nonnull  handler;

@end
