//
//  SCXCameraPreviewView.m
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/11.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import "SCXCameraPreviewView.h"
#import "SCXDispatcher.h"
@implementation SCXCameraPreviewView
+(Class)layerClass{
    return [AVCaptureVideoPreviewLayer class];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        [self addOrientationObserver];
    }
    return self;
}
-(void)dealloc{
    [self removeOrientationObserver];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self setCorrectVideoOrientation];
}
-(void)setCaptureSession:(AVCaptureSession *)captureSession{
    if (_captureSession == captureSession) {
        return;
    }
    _captureSession = captureSession;
    [SCXDispatcher dispatchAsyncOnType:SCXDispatcherQueueTypeMain block:^{
        AVCaptureVideoPreviewLayer *layer = [self  previewLayer];
        [SCXDispatcher dispatchAsyncOnType:SCXDispatcherQueueTypeCaptureSession block:^{
            layer.session = captureSession;
            [SCXDispatcher dispatchAsyncOnType:SCXDispatcherQueueTypeMain block:^{
                [self setCorrectVideoOrientation];
            }];
        }];
    }];
}
- (void)addOrientationObserver {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(orientationChanged:)
                                                name:UIDeviceOrientationDidChangeNotification
                                              object:nil];
}
-(void)orientationChanged:(NSNotification *)notification {
  [self setCorrectVideoOrientation];
}

- (void)setCorrectVideoOrientation {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    AVCaptureVideoPreviewLayer *layer = [self previewLayer];
    if (layer.connection.isVideoOrientationSupported) {
        if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            layer.connection.videoOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
        } else if (orientation == UIInterfaceOrientationLandscapeRight){
            layer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeRight;
        } else if (orientation == UIInterfaceOrientationLandscapeLeft){
            layer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
        } else if (orientation == UIInterfaceOrientationPortrait){
            layer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        }
    }
}
- (void)removeOrientationObserver {
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIDeviceOrientationDidChangeNotification
                                                object:nil];
}
- (AVCaptureVideoPreviewLayer *)previewLayer{
    return (AVCaptureVideoPreviewLayer *)self.layer;
}
@end
