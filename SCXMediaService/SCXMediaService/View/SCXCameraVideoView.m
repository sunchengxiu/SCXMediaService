//
//  SCXCameraVideoView.m
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/11.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import "SCXCameraVideoView.h"

@implementation SCXCameraVideoView
@synthesize localView = _localView;
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _localView = [[SCXCameraPreviewView alloc] initWithFrame:frame];
        self.backgroundColor = [UIColor redColor];
        [self addSubview:_localView];
    }
    return self;
}

@end
