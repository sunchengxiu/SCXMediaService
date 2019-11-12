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
@interface SCXVideoViewController ()<SCXVideoCaptureDelegate>

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
    [self startCapture];
}
- (void)startCapture{
    SCXCaptureConfig *config = [SCXCaptureConfig defaultConfig];
    _capture = [[SCXCapture alloc] initWithConfig:config delegate:self];
    AVCaptureSession *session = _capture.captureSession;
    _session = session;
    _videoView = [[SCXCameraVideoView alloc] initWithFrame:CGRectZero];
    _videoView.localView.captureSession = session;
    [_capture startCapture];
}

-(void)loadView{
    _videoView = [[SCXCameraVideoView alloc] initWithFrame:CGRectZero];
    self.view = _videoView;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}
#pragma mark - delegate
-(void)capture:(SCXVideoCapturer *)capture didCaptureVideoFrame:(SCXVideoFrame *)frame{
    NSLog(@"fram width:%@,frame height : %@",@(frame.width),@(frame.height));
}
@end
