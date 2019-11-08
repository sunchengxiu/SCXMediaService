//
//  SCXVideoFrame.h
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/7.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SCXVideoFrameBuffer.h"
NS_ASSUME_NONNULL_BEGIN
@protocol SCXVideoFrameBuffer;
@interface SCXVideoFrame : NSObject

@property(nonatomic, readonly) int width;

@property(nonatomic, readonly) int height;
@property(nonatomic, readonly) int64_t timeStampNs;
@property(nonatomic, readonly) id<SCXVideoFrameBuffer> buffer;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype) new NS_UNAVAILABLE;
- (instancetype)initWithPixelBuffer:(id<SCXVideoFrameBuffer>)pixelBuffer timeStampNs:(int64_t)timeStampns;
@end

NS_ASSUME_NONNULL_END
