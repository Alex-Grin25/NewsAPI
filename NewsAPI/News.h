//
//  News.h
//  NewsAPI
//
//  Created by ALEKSANDR GRIGOREV on 29.06.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface News : NSObject
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *urlToImage;
@property (nonatomic, strong) NSString *title;
@end



NS_ASSUME_NONNULL_END
