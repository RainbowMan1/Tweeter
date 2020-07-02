//
//  DetailsViewController.m
//  tweeter
//
//  Created by Nikesh Subedi on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "ReplyController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "ResponsiveLabel.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet ResponsiveLabel *tweetText;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
    
}

- (void)updateUI{
    self.tweetText.userInteractionEnabled = YES;
    PatternTapResponder urlTapAction = ^(NSString *tappedString) {
    NSLog(@"URL Tapped = %@",tappedString);
    };
    PatternTapResponder hashTagTapAction = ^(NSString *tappedString) {
    NSLog(@"HashTag Tapped = %@",tappedString);
    };
    PatternTapResponder userHandleTapAction = ^(NSString *tappedString){
    NSLog(@"Username Handler Tapped = %@",tappedString);
    };
    [self.tweetText enableUserHandleDetectionWithAttributes:
    @{NSForegroundColorAttributeName:[UIColor darkGrayColor],RLTapResponderAttributeName:userHandleTapAction}];
    [self.tweetText enableHashTagDetectionWithAttributes:
    @{NSForegroundColorAttributeName:[UIColor grayColor], RLTapResponderAttributeName:hashTagTapAction}];
    [self.tweetText enableURLDetectionWithAttributes:
    @{NSForegroundColorAttributeName:[UIColor blueColor],NSUnderlineStyleAttributeName:[NSNumber
    numberWithInt:1],RLTapResponderAttributeName:urlTapAction}];
    self.dateLabel.text = self.tweet.createdAtString;
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.tweetText.text = self.tweet.text;
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
- (IBAction)favoritePressed:(id)sender {
    if (self.tweet.favorited){
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet * tweet, NSError * error) {
        if (!error){
            [self.tweet copyFromTweet:tweet];
      [self updateUI];
        }
    }];
            
    }
    else{
    [[APIManager shared] favorite:self.tweet completion:^(Tweet * tweet, NSError * error) {
        if (!error){
            [self.tweet copyFromTweet:tweet];
        [self updateUI];
        }
    }];
    }
}
- (IBAction)retweetPressed:(id)sender {
    if (self.tweet.retweeted){
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet * tweet, NSError * error) {
            if (!error){
                [self.tweet copyFromTweet:tweet];
                [self updateUI];
            }
        }];
    }
    else{
    [[APIManager shared] retweet:self.tweet completion:^(Tweet * tweet, NSError * error) {
        if (!error){
            [self.tweet copyFromTweet:tweet];
        [self updateUI];
        }
    }];
    
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass: [UIButton class]]){
        UIButton *pressedButton = (UIButton*) sender;
        if ( [pressedButton.titleLabel.text isEqualToString: @"Reply"]){
            UINavigationController *navigationController = [segue destinationViewController];
            ReplyController *replyController = (ReplyController*)navigationController.topViewController;
            replyController.replyingToTweet = self.tweet;
        }
    }
}




@end
