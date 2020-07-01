//
//  ComposeTweetController.h
//  tweeter
//
//  Created by Nikesh Subedi on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ComposeTweetControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end
@interface ComposeTweetController : UIViewController
@property (nonatomic, weak) id<ComposeTweetControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
