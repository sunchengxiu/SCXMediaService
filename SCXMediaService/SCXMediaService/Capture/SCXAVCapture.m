//
//  SCXAVCapture.m
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/7.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import "SCXAVCapture.h"
#import "SCXCVPixelBuffer.h"
#import "SCXDispatcher.h"
#import <UIKit/UIKit.h>
@interface SCXAVCapture()<AVCaptureVideoDataOutputSampleBufferDelegate>{
    AVCaptureVideoDataOutput *_videoDataOutput;
    AVCaptureSession *_captureSession;
    FourCharCode _preferredOutputPixelFormat;
    FourCharCode _outputPixelFormat;
    UIDeviceOrientation _orientation;
}
@property(nonatomic, readonly) dispatch_queue_t frameQueue;
@property(nonatomic, assign) BOOL willBeRunning;
@property(nonatomic, strong) AVCaptureDevice *currentDevice;
@end
@implementation SCXAVCapture
@synthesize frameQueue = _frameQueue;
-(instancetype)init{
    return [self initWithDelegate:nil captureSession:[[AVCaptureSession alloc] init]];
}
-(instancetype)initWithDelegate:(id<SCXCaptureDelegate>)delegate{
    return [self initWithDelegate:delegate captureSession:[[AVCaptureSession alloc] init] ];
}
-(instancetype)initWithDelegate:(id<SCXCaptureDelegate>)delegate captureSession:(AVCaptureSession *)captureSession{
    if (self = [super initWithDelegate:delegate]) {
        if (![self setupCaptureSession:captureSession]) {
            return nil;
        }
        
    }
    return nil;
}
+(NSArray<AVCaptureDevice *> *)currentDevices{
    if (@available(iOS 10.0, *)) {
        AVCaptureDeviceDiscoverySession*session = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[ AVCaptureDeviceTypeBuiltInWideAngleCamera ] mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionUnspecified];
        return session.devices;
    } else {
        return [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    }
}
+ (NSArray<AVCaptureDeviceFormat *> *)supportedFormatsForDevice:(AVCaptureDevice *)device{
    return device.formats;
}
-(FourCharCode)preferredOutputPixelFormat{
    return _preferredOutputPixelFormat;
}
- (void)startCaptureWithDevice:(AVCaptureDevice *)device format:(AVCaptureDeviceFormat *)format fps:(NSInteger)fps completionHandler:(nullable void (^)(NSError *))completionHandler{
    [SCXDispatcher dispatchAsyncOnType:SCXDispatcherQueueTypeCaptureSession block:^{
        self.currentDevice = device;
        NSError *error = nil;
        if (![self.currentDevice lockForConfiguration:&error]) {
            if (completionHandler) {
                completionHandler(error);
            }
            return ;
        }
        [self reconfigCaptureSessionInput];
        [self updateOrientation];
        [self updateDeviceCaptureFormat:format fps:fps];
        [self updateVideoDataOutputPixelFormat:format];
        [self.captureSession startRunning];
        [self.currentDevice unlockForConfiguration];
        if (completionHandler) {
            completionHandler(nil);
        }
    }];
}
- (void)updateOrientation{
    NSAssert([SCXDispatcher isOnQueueForType:SCXDispatcherQueueTypeCaptureSession], @"updateOrientation must be on capturesession");
    _orientation = [UIDevice currentDevice].orientation;
}
- (void)updateDeviceCaptureFormat:(AVCaptureDeviceFormat *)format fps:(NSInteger)fps{
    NSAssert([SCXDispatcher isOnQueueForType:SCXDispatcherQueueTypeCaptureSession], @"updateDeviceCaptureFormat must be on capturesession");
    @try {
        _currentDevice.activeFormat = format;
        _currentDevice.activeVideoMinFrameDuration = CMTimeMake(1, fps);
    } @catch (NSException *exception) {
        NSLog(@"fail to set active format");
        return;
    } @finally {
        
    }
}
- (void)reconfigCaptureSessionInput{
    NSAssert([SCXDispatcher isOnQueueForType:SCXDispatcherQueueTypeCaptureSession], @"reconfigCaptureSessionInput must be on capturesession");
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.currentDevice error:&error];
    if (!input) {
        return;
    }
    [_captureSession beginConfiguration];
    for (AVCaptureDeviceInput *oldInput in [_captureSession.inputs copy]) {
        [_captureSession removeInput:oldInput];
    }
    if ([_captureSession canAddInput:input]) {
        [_captureSession addInput:input];
    } else {
        NSLog(@"capture cant add input");
    }
    [_captureSession commitConfiguration];
}
- (void)updateVideoDataOutputPixelFormat:(AVCaptureDeviceFormat *)format{
    FourCharCode newFormat = CMFormatDescriptionGetMediaType(format.formatDescription);
    if (![[SCXCVPixelBuffer supportedPixelFormats] containsObject:@(newFormat)]) {
        newFormat = _preferredOutputPixelFormat;
    }
    if (newFormat != _outputPixelFormat) {
        _outputPixelFormat = newFormat;
        _videoDataOutput.videoSettings = @{(NSString *)kCVPixelBufferPixelFormatTypeKey : @(newFormat)};
    }
    
}
- (BOOL)setupCaptureSession:(AVCaptureSession *)session{
    _captureSession = session;
    [self setupVideoDataOutput];
    if (![_captureSession canAddOutput:_videoDataOutput]) {
        NSLog(@"captureSession add videoOutput error");
        return NO;
    }
    [_captureSession addOutput:_videoDataOutput];
    return YES;
}
- (void)setupVideoDataOutput{
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    NSSet<NSNumber *>*supportPixelFormat = [SCXCVPixelBuffer supportedPixelFormats];
    NSMutableOrderedSet *availablePixelFormat = [NSMutableOrderedSet orderedSetWithArray:output.availableVideoCVPixelFormatTypes];
    [availablePixelFormat intersectSet:supportPixelFormat];
    NSNumber *pixelFormat = availablePixelFormat.firstObject;
    _preferredOutputPixelFormat = [pixelFormat unsignedIntValue];
    _outputPixelFormat = _preferredOutputPixelFormat;
    output.videoSettings = @{(NSString *)kCVPixelBufferPixelFormatTypeKey:pixelFormat};
    output.alwaysDiscardsLateVideoFrames = NO;
    [output setSampleBufferDelegate:self queue:self.frameQueue];
    output = output;
}
-(dispatch_queue_t)frameQueue{
    if (!_frameQueue) {
        _frameQueue = dispatch_queue_create("com.rongcloud.scx.captureFrameQueue", DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(_frameQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0));
    }
    return _frameQueue;
}

@end
