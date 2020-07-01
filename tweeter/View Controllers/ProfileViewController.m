//
//  ProfileViewController.m
//  tweeter
//
//  Created by Nikesh Subedi on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "APIManager.h"


@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)logout:(id)sender {
    [[APIManager shared] logout];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
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
