//
//  SCXCameraVideoView.m
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/11.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import "SCXCameraVideoView.h"
static CGFloat const kButtonSize = 48;

static CGFloat const kButtonPadding = 16;
@interface SCXCameraVideoView()

/**
 hangup
 */
@property(nonatomic , strong)UIButton *hangupButton;
@end
@implementation SCXCameraVideoView
@synthesize localView = _localView;
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _localView = [[SCXCameraPreviewView alloc] initWithFrame:frame];
        self.backgroundColor = [UIColor redColor];
        [self addSubview:_localView];
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews{
    _hangupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _hangupButton.backgroundColor = [UIColor redColor];
    _hangupButton.layer.cornerRadius = kButtonSize / 2;
    _hangupButton.layer.masksToBounds = YES;
    [_hangupButton addTarget:self
                      action:@selector(onHangup:)
            forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_hangupButton];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    _hangupButton.frame =
    CGRectMake(CGRectGetMinX(bounds) + kButtonPadding,
               CGRectGetMaxY(bounds) - kButtonPadding -
                   kButtonSize - 50,
               kButtonSize,
               kButtonSize);
}

- (void)onHangup:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoViewDidHangup:)]) {
        [self.delegate videoViewDidHangup:self];
    }
}

@end
