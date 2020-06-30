//
//  ComposeViewController.h
//  twitter
//
//  Created by Jacob Franz on 6/30/20.
//  Copyright © 2020 Jacob Franz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController

@property (weak, nonatomic) id<ComposeViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
