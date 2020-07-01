//
//  User.m
//  tweeter
//
//  Created by Nikesh Subedi on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        }
        return self;
    }
@end
