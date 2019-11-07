//
//  SCXDispatcher.h
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/7.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,SCXDispatcherQueueType) {
    SCXDispatcherQueueTypeMain,
    SCXDispatcherQueueTypeAudioSession,
    SCXDispatcherQueueTypeCaptureSession
};
NS_ASSUME_NONNULL_BEGIN

@interface SCXDispatcher : NSObject
+ (void)dispatchAsyncOnType:(SCXDispatcherQueueType)type block:(dispatch_block_t)block;
+ (BOOL)isOnQueueForType:(SCXDispatcherQueueType)type;
@end

NS_ASSUME_NONNULL_END
