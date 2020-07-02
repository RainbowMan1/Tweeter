//
//  ReplyController.h
//  tweeter
//
//  Created by Nikesh Subedi on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReplyController : UIViewController
@property (strong, nonatomic) Tweet *replyingToTweet;
@end

NS_ASSUME_NONNULL_END
