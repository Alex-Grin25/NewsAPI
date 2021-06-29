//
//  ViewController.m
//  NewsAPI
//
//  Created by ALEKSANDR GRIGOREV on 29.06.2021.
//

#import "ViewController.h"
#import "NewsViewController.h"
#import "News.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *news;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NewsCell"];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    [self.refreshControl beginRefreshing];
    [self refresh];
}

- (void)refresh {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, NULL), ^{
        __weak ViewController *weakSelf = self;
        
        NSURL *url = [NSURL URLWithString:@"https://newsapi.org/v2/top-headlines?country=us&apiKey=2241ba2f47da4be8b6b788cb00f9e176"];
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSMutableArray *newsArray = [NSMutableArray new];
            if (data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if (!error && dict) {
                    NSArray *articles = dict[@"articles"];
                    for (NSDictionary *article in articles) {
                        News *news = [News new];
                        if ([article[@"author"] isKindOfClass:[NSString class]]) {
                            news.author = article[@"author"];
                        }
                        news.title = article[@"title"];
                        news.content = article[@"content"];
                        news.urlToImage = article[@"urlToImage"];
                        [newsArray addObject:news];
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.news = [newsArray copy];
                    [weakSelf.refreshControl endRefreshing];
                    [weakSelf.tableView reloadData];
                });
            }
        }];
        [dataTask resume];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell.detailTextLabel == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NewsCell"];
    }
    News *news = self.news[indexPath.row];
    
    cell.textLabel.text = news.title;
    cell.detailTextLabel.text = news.author;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsViewController *vc = [NewsViewController new];
    vc.news = self.news[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
