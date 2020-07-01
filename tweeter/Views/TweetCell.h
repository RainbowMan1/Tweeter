//
//  TweetCellTableViewCell.h
//  tweeter
//
//  Created by Nikesh Subedi on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel* nameLabel;
@property (weak, nonatomic) IBOutlet UILabel* screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel* dateLabel;
@property (weak, nonatomic) IBOutlet UILabel* tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

NS_ASSUME_NONNULL_END
