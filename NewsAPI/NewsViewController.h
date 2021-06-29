//
//  NewsViewController.h
//  NewsAPI
//
//  Created by ALEKSANDR GRIGOREV on 29.06.2021.
//

#import <UIKit/UIKit.h>
#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsViewController : UIViewController
@property (nonatomic, strong) News *news;
@end

NS_ASSUME_NONNULL_END
