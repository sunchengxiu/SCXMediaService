//
//  SCXCameraVideoCapturer.h
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/8.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCXVideoCapturer.h"
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface SCXCameraVideoCapturer : SCXVideoCapturer
@property(readonly, nonatomic) AVCaptureSession *captureSession;
+ (NSArray<AVCaptureDeviceFormat *>*)supportedFormatsForDevice:(AVCaptureDevice *)device;
- (FourCharCode)preferredOutputPixelFormat;
+ (NSArray<AVCaptureDevice *> *)captureDevices;
@property(nonatomic , assign , readonly)BOOL isRunning;
- (void)startCaptureWithDevice:(AVCaptureDevice *)device format:(AVCaptureDeviceFormat *)format fps:(NSInteger)fps completionHandler:(nullable void (^)(NSError *))completionHandler;
- (void)stopCapture;
@end

NS_ASSUME_NONNULL_END
