//
//  SCXVideoCapturer.h
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/7.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCXVideoFrame.h"
#import <VideoToolbox/VideoToolbox.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN
@protocol SCXCaptureDelegate;
@interface SCXVideoCapturer : NSObject

/**
 delegate
 */
@property(nonatomic , weak)id<SCXCaptureDelegate> delegate;
- (instancetype)initWithDelegate:(id<SCXCaptureDelegate>)delegate;

@end
@protocol SCXCaptureDelegate <NSObject>
- (void)capture:(SCXVideoCapturer *)capture didCaptureVideoFrame:(SCXVideoFrame *)frame;
@end
NS_ASSUME_NONNULL_END
