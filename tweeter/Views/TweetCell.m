//
//  TweetCellTableViewCell.m
//  tweeter
//
//  Created by Nikesh Subedi on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)favoritePressed:(id)sender {
    if (self.tweet.favorited){
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet * tweet, NSError * error) {
        if (!error){
            [self.tweet copyFromTweet:tweet];
      [self updateCell];
        }
    }];
            
    }
    else{
    [[APIManager shared] favorite:self.tweet completion:^(Tweet * tweet, NSError * error) {
        if (!error){
            [self.tweet copyFromTweet:tweet];
        [self updateCell];
        }
    }];
    }
}
- (IBAction)retweetPressed:(id)sender {
    if (self.tweet.retweeted){
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet * tweet, NSError * error) {
            if (!error){
                [self.tweet copyFromTweet:tweet];
                [self updateCell];
            }
        }];
    }
    else{
    [[APIManager shared] retweet:self.tweet completion:^(Tweet * tweet, NSError * error) {
        if (!error){
            [self.tweet copyFromTweet:tweet];
        [self updateCell];
        }
    }];
    
    }
}

- (void)updateCell{
    self.tweetLabel.userInteractionEnabled = YES;
    PatternTapResponder urlTapAction = ^(NSString *tappedString) {
    NSLog(@"URL Tapped = %@",tappedString);
    };
    PatternTapResponder hashTagTapAction = ^(NSString *tappedString) {
    NSLog(@"HashTag Tapped = %@",tappedString);
    };
    PatternTapResponder userHandleTapAction = ^(NSString *tappedString){
    NSLog(@"Username Handler Tapped = %@",tappedString);
    };
    [self.tweetLabel enableUserHandleDetectionWithAttributes:
    @{NSForegroundColorAttributeName:[UIColor darkGrayColor],RLTapResponderAttributeName:userHandleTapAction}];
    [self.tweetLabel enableHashTagDetectionWithAttributes:
    @{NSForegroundColorAttributeName:[UIColor grayColor], RLTapResponderAttributeName:hashTagTapAction}];
    [self.tweetLabel enableURLDetectionWithAttributes:
    @{NSForegroundColorAttributeName:[UIColor blueColor],NSUnderlineStyleAttributeName:[NSNumber
    numberWithInt:1],RLTapResponderAttributeName:urlTapAction}];
    self.dateLabel.text = self.tweet.createdAtString;
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.tweetLabel.text = self.tweet.text;
    NSURL *url = [NSURL URLWithString:self.tweet.user.profileImageURL];
    [self.profileImage setImageWithURL:url];
    [self.favoriteButton setTitle:[@(self.tweet.favoriteCount) stringValue] forState:UIControlStateNormal];
    [self.retweetButton setTitle:[@(self.tweet.retweetCount) stringValue] forState:UIControlStateNormal];
    if (self.tweet.favorited){
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    else{
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    if (self.tweet.retweeted){
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }
    else{
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
}

@end
