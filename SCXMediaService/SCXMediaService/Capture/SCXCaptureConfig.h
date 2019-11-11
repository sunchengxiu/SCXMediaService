//
//  SCXCaptureConfig.h
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/8.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,SCXCaptureDevicePosition) {
    SCXCaptureDevicePositionFront = 0,
    SCXCaptureDevicePositionBack
};
typedef NS_ENUM(NSInteger,SCXCaptureSessionPreset) {
    SCXCaptureSessionPreset320x240,
    SCXCaptureSessionPreset640x480,
    SCXCaptureSessionPreset960x540,
    SCXCaptureSessionPreset1280x720,
    SCXCaptureSessionPreset1920x1080
    
};
typedef NS_ENUM(NSInteger,SCXVideoFPS) {
    SCXVideoFPS15,
    SCXVideoFPS24,
    SCXVideoFPS30
};
@interface SCXCaptureConfig : NSObject
+ (instancetype)defaultConfig;

/**
 position
 */
@property(nonatomic , assign)SCXCaptureDevicePosition position;


/**
 CaptureSessionPreset
 */
@property(nonatomic , assign)SCXCaptureSessionPreset preset;

/**
 fps
 */
@property(nonatomic , assign)SCXVideoFPS fps;



@end

NS_ASSUME_NONNULL_END
