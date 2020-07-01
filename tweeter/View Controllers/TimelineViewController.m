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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchTweets{
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweetsarray, NSError *error) {
        if (tweetsarray) {
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
    Tweet *tweet = self.tweets[indexPath.row];
    cell.tweet = tweet;
    [cell updateCell];
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
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
}



- (void)didTweet:(nonnull Tweet *)tweet {
    [self.tweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}


@end
