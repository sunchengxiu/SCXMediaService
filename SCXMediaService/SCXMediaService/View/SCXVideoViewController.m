//
//  SCXVideoViewController.m
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/11.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import "SCXVideoViewController.h"
#import "SCXCameraVideoView.h"
@interface SCXVideoViewController ()

/**
 video view
 */
@property(nonatomic , strong)SCXCameraVideoView *videoView;
@end

@implementation SCXVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createVideoViewAndSession];
}
- (void)createVideoViewAndSession{
    
}
-(void)loadView{
    _videoView = [[SCXCameraVideoView alloc] initWithFrame:CGRectZero];
    self.view = _videoView;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}
@end
