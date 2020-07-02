//
//  Tweet.m
//  tweeter
//
//  Created by Nikesh Subedi on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"
#import "NSDate+DateTools.h"

@implementation Tweet
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {

        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];

            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"full_text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        
        NSDictionary *user = dictionary[@"user"];


        self.user = [[User alloc] initWithDictionary:user];
        // Format createdAt date string
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        // Configure output format
        // Convert Date to String
        self.createdAtString = [date shortTimeAgoSinceNow];
    }
    return self;
}
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}
- (void)copyFromTweet:(Tweet*) tweet{
    self.idStr = tweet.idStr;
    self.text = tweet.text;
    self.favoriteCount= tweet.favoriteCount;
    self.favorited = tweet.favorited;
    self.retweetCount= tweet.retweetCount;
    self.retweeted = tweet.retweeted;
    self.user = tweet.user;
    self.createdAtString = tweet.createdAtString;
    self.retweetedByUser =tweet.retweetedByUser;
}
@end
