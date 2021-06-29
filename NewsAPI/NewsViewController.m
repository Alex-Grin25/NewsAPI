//
//  NewsViewController.m
//  NewsAPI
//
//  Created by ALEKSANDR GRIGOREV on 29.06.2021.
//

#import "NewsViewController.h"

@interface NewsViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat y = 80;
    CGFloat padding = 8;
    CGFloat width = self.view.frame.size.width - 2 * padding;
    if (self.news.urlToImage) {
        NSURL *url = [[NSURL alloc] initWithString:self.news.urlToImage];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        CGFloat height = image.size.height / image.size.width * width;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(padding, y, width, height)];
        self.imageView.image = image;
        [self.view addSubview:self.imageView];
        y += height + 8;
    }
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 20)];
    self.titleLabel.text = self.news.title;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    [self.view addSubview:self.titleLabel];
    y += self.titleLabel.frame.size.height + 8;
    
    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, y, width, 20)];
    self.authorLabel.text = self.news.author;
    self.authorLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    [self.view addSubview:self.authorLabel];
    y += self.authorLabel.frame.size.height + 8;
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(padding, y, width, self.view.frame.size.height - y)];
    self.textView.editable = NO;
    self.textView.selectable = NO;
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.textContainerInset = UIEdgeInsetsZero;
    self.textView.textContainer.lineFragmentPadding = 0;
    self.textView.text = self.news.content;
    [self.view addSubview:self.textView];
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
