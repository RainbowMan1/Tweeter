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
@property (weak, nonatomic) IBOutlet UITextField *tweetfield;

@end

@implementation ComposeTweetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)tweet:(id)sender {
    [[APIManager shared] postStatusWithText:self.tweetfield.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
    }];
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
