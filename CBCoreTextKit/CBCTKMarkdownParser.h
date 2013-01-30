//
//  CBCTKMarkdownParser.h
//  CBCoreTextKit
//
//  Created by Christian Beer on 09.11.12.
//  Copyright (c) 2012 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCTKGlobals.h"


typedef NSAttributedString*(^CBCTKMarkdownFormatHandler)(NSTextCheckingResult *result, NSAttributedString *attributedString, NSString *markdownString, NSRange *replacementRange);

@interface CBCTKMarkdownParser : NSObject

@property (nonatomic, strong, readonly) NSArray *formatPatterns;

@property (nonatomic, strong) NSString  *fontFamilyName;
@property (nonatomic, assign) CGFloat   fontSize;
@property (nonatomic, strong) CBColor   *textColor;


- (id) init;
- (id) initWithFontFamilyName:(NSString*)fontFamily fontSize:(CGFloat)fontSize textColor:(CBColor*)textColor;

- (NSAttributedString*) parseMarkdownString:(NSString*)string;

- (void) registerFormatPatternWithRegularExpression:(NSRegularExpression*)regularExpression handler:(CBCTKMarkdownFormatHandler)handler;

@end


@interface CBCTKMarkdownFormatPattern : NSObject

@property (nonatomic, strong)   NSRegularExpression         *regularExpression;
@property (nonatomic, copy)     CBCTKMarkdownFormatHandler  handler;

@end
