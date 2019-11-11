//
//  SCXCameraVideoView.h
//  SCXMediaService
//
//  Created by 孙承秀 on 2019/11/11.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXCameraPreviewView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SCXCameraVideoView : UIView

/**
 preview view
 */
@property(nonatomic , strong , readonly)SCXCameraPreviewView *localView;
@end

NS_ASSUME_NONNULL_END
