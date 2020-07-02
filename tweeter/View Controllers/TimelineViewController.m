//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "ComposeTweetController.h"
#import "DetailsViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "APIManager.h"

@interface TimelineViewController ()<UITableViewDataSource, UITableViewDelegate, ComposeTweetControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSMutableArray *tweets;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    self.tweets = [[NSMutableArray alloc] init];
    [self fetchTweets];
    self.refreshControl =[[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchTweets{
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweetsarray, NSError *error) {
        if (tweetsarray) {
            [self.tweets removeAllObjects];
            [self.tweets addObjectsFromArray: tweetsarray];
            [self.tableView reloadData];
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell =[tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    cell.tweet = self.tweets[indexPath.row];
    [cell updateCell];
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}
- (IBAction)logout:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you Sure?"
                                                                       message:@"Do you want to log out?"
                                                                preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Log Out"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
            [[APIManager shared] logout];
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            appDelegate.window.rootViewController = loginViewController;
        }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"No"
      style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {}];
    
    [yesAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
        
        [alert addAction:cancelAction];
    [alert addAction:yesAction];
        [self presentViewController:alert animated:YES completion:^{}];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass: [UIBarButtonItem class]]){
        UIBarButtonItem *pressedButton = (UIBarButtonItem*) sender;
        if ( [pressedButton.title isEqualToString: @"Compose"]){
            UINavigationController *navigationController = [segue destinationViewController];
            ComposeTweetController *composeController = (ComposeTweetController*)navigationController.topViewController;
            composeController.delegate = self;
        }
    }
    else if ([sender isKindOfClass:[TweetCell class]]){
        TweetCell *pressedCell = (TweetCell*) sender;
//        UINavigationController *navigationController = [segue destinationViewController];
        DetailsViewController *detailsViewController = [segue destinationViewController];
//        DetailsViewController *detailsViewController = (DetailsViewController*)navigationController.topViewController;
        detailsViewController.tweet = pressedCell.tweet;
    }
}



- (void)didTweet:(nonnull Tweet *)tweet {
    [self.tweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}


@end
