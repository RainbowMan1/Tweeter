//
//  ComposeTweetController.m
//  tweeter
//
//  Created by Nikesh Subedi on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeTweetController.h"
#import "APIManager.h"

@interface ComposeTweetController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation ComposeTweetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetTextView.layer.borderWidth =1.0f;
    self.tweetTextView.layer.cornerRadius = 18;
    self.tweetTextView.clearsOnInsertion=YES;
    // Do any additional setup after loading the view.
}
- (IBAction)tweet:(id)sender {
    [[APIManager shared] postStatusWithText:self.tweetTextView.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
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
