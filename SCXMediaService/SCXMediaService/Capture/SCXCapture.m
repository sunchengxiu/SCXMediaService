//
//  SCXCapture.m
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/7.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import "SCXCapture.h"

@implementation SCXCapture
@synthesize delegate = _delegate;
-(instancetype)initWithDelegate:(id<SCXCaptureDelegate>)delegate{
    if (self = [super init]) {
        _delegate = delegate;
    }
    return self;
}
@end
