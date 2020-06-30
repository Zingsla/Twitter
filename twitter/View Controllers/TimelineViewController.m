//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "ComposeViewController.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self fetchTweets];
}

- (void)fetchTweets {
    // Get timeline
       [[APIManager shared] getHomeTimelineWithCompletion:^(NSMutableArray *tweets, NSError *error) {
           if (tweets) {
               NSLog(@"Successfully loaded home timeline");
               self.tweets = tweets;
               
               [self.tableView reloadData];
           } else {
               NSLog(@"Error getting home timeline: %@", error.localizedDescription);
           }
       }];
    
    [self.refreshControl endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.tweet = self.tweets[indexPath.row];
    
    cell.nameLabel.text = cell.tweet.user.name;
    cell.usernameLabel.text = [NSString stringWithFormat:@"@%@", cell.tweet.user.screenName];
    cell.dateLabel.text = cell.tweet.createdAtString;
    cell.tweetLabel.text = cell.tweet.text;
    cell.retweetCountLabel.text = [NSString stringWithFormat:@"%d", cell.tweet.retweetCount];
    cell.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", cell.tweet.favoriteCount];
    
    NSString *profileImageURLString = [cell.tweet.user.profileURLString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *profileImageURL = [NSURL URLWithString:profileImageURLString];
    [cell.profileImageView setImageWithURL:profileImageURL];
    
    return cell;
}

- (void)didTweet:(Tweet *)tweet {
    [self.tweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController *)navigationController.topViewController;
    composeController.delegate = self;
}



@end
