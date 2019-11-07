//
//  SCXDispatcher.m
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/7.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import "SCXDispatcher.h"
static dispatch_queue_t KAudioSessionQueue = nil;
static dispatch_queue_t KCaptureSessionQueue = nil;
static
@implementation SCXDispatcher
+(void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KAudioSessionQueue = dispatch_queue_create("com.rongcloud.scx.audiosessionqueue", DISPATCH_QUEUE_SERIAL);
        KCaptureSessionQueue = dispatch_queue_create("com.rongcloud.scx.capturesessionqueue", DISPATCH_QUEUE_SERIAL);
    });
}
+ (void)dispatchAsyncOnType:(SCXDispatcherQueueType)type block:(dispatch_block_t)block{
    dispatch_queue_t queue = [self dispatchQueueForType:type];
    dispatch_async(queue, block);
}
+ (BOOL)isOnQueueForType:(SCXDispatcherQueueType)type{
    dispatch_queue_t targetQueue = [self dispatchQueueForType:type];
    const char *tarLabel = dispatch_queue_get_label(targetQueue);
    const char *curLabel = dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL);
    return strcmp(tarLabel, curLabel);
    
}
+ (dispatch_queue_t)dispatchQueueForType:(SCXDispatcherQueueType)type{
    switch (type) {
        case SCXDispatcherQueueTypeMain:
            return dispatch_get_main_queue();
            break;
            case SCXDispatcherQueueTypeAudioSession:
            return KAudioSessionQueue;
            case SCXDispatcherQueueTypeCaptureSession:
            return KCaptureSessionQueue;
            
        default:
            break;
    }
}
@end
