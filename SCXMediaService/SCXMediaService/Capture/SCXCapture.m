//
//  SCXCapture.m
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/8.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import "SCXCapture.h"
#import "SCXCameraVideoCapturer.h"
@interface SCXCapture()

/**
 video capture
 */
@property(nonatomic , strong)SCXCameraVideoCapturer *capture;
@end
@implementation SCXCapture
@synthesize config = _config;
-(instancetype)initWithConfig:(SCXCaptureConfig *)config delegate:(nonnull id<SCXVideoCaptureDelegate>)delegate{
    NSAssert(config != nil, @"config cant nil");
    if (self = [super init]) {
        _capture = [[SCXCameraVideoCapturer alloc] initWithDelegate:delegate];
        _config = config;
    }
    return self;
}
-(SCXCaptureConfig *)config{
    return _config;
}
-(void)startCapture{
    AVCaptureDevicePosition position = _config.position == SCXCaptureDevicePositionFront ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    AVCaptureDevice *device = [self findDeviceForPosition:position];
    AVCaptureDeviceFormat *format = [self selectFormatForDevice:device];
    if (format == nil) {
        NSAssert(NO, @"no select format");
        return;
    }
    [_capture startCaptureWithDevice:device format:format fps:_config.fps completionHandler:^(NSError * _Nonnull error) {
        
    }];
}
-(void)stopCapture{
    [_capture stopCapture];
}
- (void)switchCamera{
    _config.position = !_config.position;
    [self startCapture];
}
-(AVCaptureSession *)captureSession{
    return _capture.captureSession;
}
- (AVCaptureDevice *)findDeviceForPosition:(AVCaptureDevicePosition)position{
    NSArray<AVCaptureDevice *>*devices = [SCXCameraVideoCapturer captureDevices];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return devices.firstObject;
}
- (AVCaptureDeviceFormat *)selectFormatForDevice:(AVCaptureDevice *)device{
    CGSize resolution = [self resolutionForCaptureSessionPreset:_config.preset];
    NSArray<AVCaptureDeviceFormat *>*formats = [SCXCameraVideoCapturer supportedFormatsForDevice:device];
    AVCaptureDeviceFormat *selectFormat = nil;
    int currentDiff = INT_MAX;
    for (AVCaptureDeviceFormat *format in formats) {
        CMVideoDimensions dimension = CMVideoFormatDescriptionGetDimensions(format.formatDescription);
        FourCharCode pixelFormat = CMFormatDescriptionGetMediaSubType(format.formatDescription);
        int diff = abs(resolution.width - dimension.width) + abs(resolution.height - dimension.height);
        if (diff < currentDiff) {
            selectFormat = format;
            currentDiff = diff;
        } else if(diff == currentDiff && pixelFormat == ([_capture preferredOutputPixelFormat])){
            selectFormat = format;
        }
    }
    return selectFormat;
}
- (CGSize)resolutionForCaptureSessionPreset:(SCXCaptureSessionPreset)preset{
    CGSize size = CGSizeZero;
    switch (preset) {
        case SCXCaptureSessionPreset320x240:
            size = (CGSize){320,240};
            break;
            case SCXCaptureSessionPreset640x480:
            size = (CGSize){640,480};
            break;
            case SCXCaptureSessionPreset960x540:
            size = (CGSize){960,540};
            break;
            case SCXCaptureSessionPreset1280x720:
            size = (CGSize){1280,720};
            break;
            case SCXCaptureSessionPreset1920x1080:
            size = (CGSize){1920,1080};
            break;
        default:
            break;
    }
    NSLog(@"width : %@,height:%@",@(size.width),@(size.height));
    return size;
}



@end
