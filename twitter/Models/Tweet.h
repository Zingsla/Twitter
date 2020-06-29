//
//  Tweet.h
//  Twitter
//
//  Created by Jacob Franz on 6/29/20.
//  Copyright © 2020 Jacob Franz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSObject

@property (strong, nonatomic) NSString *idStr; // For favoriting, retweeting & replying
@property (strong, nonatomic) NSString *text; // Text content of tweet
@property (nonatomic) int favoriteCount; // Update favorite count label
@property (nonatomic) BOOL favorited; // Configure favorite button
@property (nonatomic) int retweetCount; // Update favorite count label
@property (nonatomic) BOOL retweeted; // Configure retweet button
@property (strong, nonatomic) User *user; // Contains Tweet author's name, screenname, etc.
@property (strong, nonatomic) NSString *createdAtString; // Display date
@property (strong, nonatomic) User *retweetedByUser;  // User who retweeted if tweet is retweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
