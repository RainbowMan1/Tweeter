//
//  ReplyController.m
//  tweeter
//
//  Created by Nikesh Subedi on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ReplyController.h"
#import "APIManager.h"


@interface ReplyController ()
@property (weak, nonatomic) IBOutlet UITextView *replyTextView;
@end

@implementation ReplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [@" Reply to " stringByAppendingString:self.replyingToTweet.user.name];
    self.replyTextView.layer.borderWidth =1.0f;
    self.replyTextView.layer.cornerRadius = 18;
    self.replyTextView.text = [[@"@" stringByAppendingString: self.replyingToTweet.user.screenName] stringByAppendingString:@" "];
    // Do any additional setup after loading the view.
}
- (IBAction)tweet:(id)sender {
    [[APIManager shared] postReplyWithText:self.replyTextView.text inReplyTo: self.replyingToTweet.idStr completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Reply Tweet Success!");
            [self closeView: sender];
        }
    }];
}
- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)textViewTap:(id)sender {
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
