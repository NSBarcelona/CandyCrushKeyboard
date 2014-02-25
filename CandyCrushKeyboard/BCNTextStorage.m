//
//  BCNTextStorage.m
//  CandyCrushKeyboard
//
//  Created by Hermes on 25/02/14.
//  Copyright (c) 2014 Hermes Pique. All rights reserved.
//

#import "BCNTextStorage.h"

@implementation BCNTextStorage {
    NSMutableAttributedString *_backingStore;
    BOOL _needsUpdate;
}

- (id)init
{
    if (self = [super init])
    {
        _backingStore = [NSMutableAttributedString new];
    }
    return self;
}

#pragma mark NSAttributedString

- (NSString *)string
{
    return [_backingStore string];
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
    return [_backingStore attributesAtIndex:location effectiveRange:range];
}

#pragma mark NSMutableAttributedString

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    _needsUpdate = YES;
    [_backingStore replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters | NSTextStorageEditedAttributes range:range changeInLength:str.length - range.length];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range
{
    [_backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
}

#pragma mark NSTextStorage

- (void)processEditing
{
    if (_needsUpdate)
    {
        [_backingStore beginEditing];
        _needsUpdate = NO;
        NSRange extendedRange = [self extendedRangeForRange:self.editedRange];
        [self replaceLettersInRange:extendedRange];
        [_backingStore endEditing];
    }
    [super processEditing];
}

#pragma mark Private

- (void)replaceLettersInRange:(NSRange)range
{
    NSString *text = _backingStore.string;
    [text enumerateSubstringsInRange:range options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if (substring.length == 0) return;
        
        UIImage *image = [self imageForString:substring];
        if (!image) return;
        
        NSTextAttachment *textAttachment = [NSTextAttachment new];
        textAttachment.image = image;
        NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [_backingStore replaceCharactersInRange:substringRange withAttributedString:attributedString];
    }];
}

#pragma mark Utils

- (NSRange)extendedRangeForRange:(NSRange)range
{
    NSRange extendedRange = NSUnionRange(range, [self.string lineRangeForRange:NSMakeRange(range.location, 0)]);
    extendedRange = NSUnionRange(extendedRange, [self.string lineRangeForRange:NSMakeRange(NSMaxRange(range), 0)]);
    return extendedRange;
}

- (UIImage*)imageForString:(NSString*)string
{
    const unichar letter = [string characterAtIndex:0];
    NSString *imageName = [NSString stringWithFormat:@"00%02x", letter].uppercaseString;
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}

@end
