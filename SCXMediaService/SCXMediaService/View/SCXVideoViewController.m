//
//  SCXVideoViewController.m
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/11.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import "SCXVideoViewController.h"
#import "SCXCameraVideoView.h"
#import "SCXCapture.h"
#import "SCXVideoFrame.h"
@interface SCXVideoViewController ()<SCXVideoCaptureDelegate,SCXCameraVideoViewDelegate>

/**
 video view
 */
@property(nonatomic , strong)SCXCameraVideoView *videoView;

/**
 capture
 */
@property(nonatomic , strong)SCXCapture *capture;

/**
 session
 */
@property(nonatomic , strong)AVCaptureSession *session;
@end

@implementation SCXVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _videoView = [[SCXCameraVideoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _videoView;
    [self startCapture];
}
- (void)startCapture{
    if (_capture && _capture.isRunning) {
        return;
    }
    SCXCaptureConfig *config = [SCXCaptureConfig defaultConfig];
    _capture = [[SCXCapture alloc] initWithConfig:config delegate:self];
    AVCaptureSession *session = _capture.captureSession;
    _session = session;
    _videoView.localView.captureSession = session;
    _videoView.delegate = self;
    [_capture startCapture];
}
- (void)stopCapture{
    _videoView.localView.captureSession = nil;
    [_capture stopCapture];
    _capture = nil;
    _session = nil;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}
#pragma mark - video view delegate
-(void)videoViewDidHangup:(SCXCameraVideoView *)videoView{
    [self stopCapture];
}
-(void)videoViewDidStart:(SCXCameraVideoView *)videoView{
    [self startCapture];
}
#pragma mark - capture delegate
-(void)capture:(SCXVideoCapturer *)capture didCaptureVideoFrame:(SCXVideoFrame *)frame{
    NSLog(@"fram width:%@,frame height : %@",@(frame.width),@(frame.height));
}
@end
