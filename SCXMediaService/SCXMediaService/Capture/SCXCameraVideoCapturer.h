//
//  SCXCameraVideoCapturer.h
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/8.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCXCapture.h"
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface SCXCameraVideoCapturer : SCXCapture
@property(readonly, nonatomic) AVCaptureSession *captureSession;
+ (NSArray<AVCaptureDevice *>*)currentDevices;
+ (NSArray<AVCaptureDeviceFormat *>*)supportedFormatsForDevice:(AVCaptureDevice *)device;
- (FourCharCode)preferredOutputPixelFormat;
@end

NS_ASSUME_NONNULL_END