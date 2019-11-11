//
//  SCXCaptureConfig.m
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/8.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import "SCXCaptureConfig.h"

@implementation SCXCaptureConfig
+(instancetype)defaultConfig{
    return [[self alloc] init];
}
-(instancetype)init{
    if (self = [super init]) {
        self.preset = SCXCaptureSessionPreset640x480;
        self.position = SCXCaptureDevicePositionFront;
        self.fps = SCXVideoFPS24;
    }
    return self;
}
@end
