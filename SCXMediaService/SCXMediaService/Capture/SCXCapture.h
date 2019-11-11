//
//  SCXCapture.h
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/8.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SCXCaptureConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface SCXCapture : NSObject
@property(nonatomic , strong , readonly)SCXCaptureConfig *config;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype) new NS_UNAVAILABLE;
- (instancetype)initWithConfig:(SCXCaptureConfig *)config;
- (void)startCapture;
- (void)stopCapture;
- (void)switchCamera;
@end

NS_ASSUME_NONNULL_END
