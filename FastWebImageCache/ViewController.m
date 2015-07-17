//
//  ViewController.m
//  FastWebImageCache
//
//  Created by Zhenwang Zha on 15/7/17.
//  Copyright (c) 2015年 zhenwang. All rights reserved.
//

#import "ViewController.h"
#import "FastWebImage.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic, retain) NSArray * dataArr;

@end

@implementation ViewController

- (void)dealloc
{
    self.dataArr = nil;
    [super dealloc];
}

- (NSArray *)dataArr
{
    if (nil == _dataArr) {
        self.dataArr = @[@"http://pic1.nipic.com/2008-09-08/200898163242920_2.jpg",
                         @"http://pic2.ooopic.com/01/26/61/83bOOOPIC72.jpg",
                         @"http://pic.nipic.com/2007-11-09/2007119121849495_2.jpg",
                         @"http://pic26.nipic.com/20121223/9252150_195341264315_2.jpg",
                         @"http://pic1a.nipic.com/2008-12-04/2008124215522671_2.jpg",
                         @"http://pic1.nipic.com/2008-08-12/200881211331729_2.jpg",
                         @"http://pica.nipic.com/2007-11-09/2007119124413448_2.jpg",
                         @"http://image.photophoto.cn/nm-6/018/030/0180300244.jpg",
                         @"http://pica.nipic.com/2008-05-07/20085722191339_2.jpg",
                         @"http://pic25.nipic.com/20121209/9252150_194258033000_2.jpg"];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                           style:UITableViewStylePlain];
    [tableView setRowHeight:200.0f];
    [tableView setDataSource:self];
    [self.view addSubview:tableView];
    [tableView release];
}

#pragma mark  -  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"imageCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        FastWebImage * webImage = [[FastWebImage alloc] init];
        webImage.backgroundColor = [UIColor redColor];
        [webImage setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
        [webImage setTag:100];
        [cell.contentView addSubview:webImage];
        [webImage release];
    }
    FastWebImage * image = (FastWebImage *)[cell.contentView viewWithTag:100];
    [image setImageWithURL:self.dataArr[indexPath.row]];
    return cell;
}

@end
