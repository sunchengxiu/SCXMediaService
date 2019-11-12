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
@interface SCXVideoViewController ()<SCXVideoCaptureDelegate>

/**
 video view
 */
@property(nonatomic , strong)SCXCameraVideoView *videoView;
@end

@implementation SCXVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startCapture];
}
- (void)startCapture{
    SCXCaptureConfig *config = [SCXCaptureConfig defaultConfig];
    SCXCapture *capture = [[SCXCapture alloc] initWithConfig:config delegate:self];
    AVCaptureSession *session = capture.captureSession;
    _videoView = [[SCXCameraVideoView alloc] initWithFrame:CGRectZero];
    _videoView.localView.captureSession = session;
    [capture startCapture];
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
    
}
@end
