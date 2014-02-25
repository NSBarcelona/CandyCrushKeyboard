//
//  BCNViewController.m
//  CandyCrushKeyboard
//
//  Created by Hermes on 25/02/14.
//  Copyright (c) 2014 Hermes Pique. All rights reserved.
//

#import "BCNViewController.h"
#import "BCNTextStorage.h"

@interface BCNViewController ()

@end

@implementation BCNViewController {
    UITextView *_textView;
    BCNTextStorage *_textStorage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _textStorage = [BCNTextStorage new];
    NSLayoutManager *layoutManager = [NSLayoutManager new];
    const CGSize containerSize = CGSizeMake(self.view.bounds.size.width, CGFLOAT_MAX);
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:containerSize];
    [layoutManager addTextContainer:textContainer];
    [_textStorage addLayoutManager:layoutManager];
    
    _textView = [[UITextView alloc] initWithFrame:self.view.bounds textContainer:textContainer];
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_textView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_textView becomeFirstResponder];
}

@end
