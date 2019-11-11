//
//  SCXCameraPreviewView.h
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/11.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SCXCameraPreviewView : UIView

/**
 capture session
 */
@property(nonatomic , strong)AVCaptureSession *captureSession;
@end

NS_ASSUME_NONNULL_END
