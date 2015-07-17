//
//  FastWebImage.m
//  WebImageDemo
//
//  Created by Zhenwang Zha on 15-6-1.
//  Copyright (c) 2015年 zhenwang. All rights reserved.
//

#import "FastWebImage.h"
#import "WebImageDecoder.h"

@implementation FastWebImage

//开启占位图
- (void)setPlaceHolder:(NSString *)placeHolder
{
    NSData * data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:placeHolder ofType:nil]];
    
    [FastWebImage setThreadImageWithData:data forImageView:self];
    
    [data release];
}

- (void)setImageWithURL:(NSString *)urlString
{
    //从缓存中加载图片
    if ([self loadImageDataCached:urlString]) {
        return;
    }
    
    //占位图
    [self setPlaceHolder:@"placeholder_100x100@2x.png"];
    
    //缓存不存在, 开启异步下载
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    __block typeof(self) weakSelf = self;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if (!connectionError) {
            [FastWebImage setThreadImageWithData:data forImageView:weakSelf];
        }
    }];
}

//缓存中加载图片资源
- (BOOL)loadImageDataCached:(NSString *)urlString
{
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                              cachePolicy:NSURLRequestReturnCacheDataDontLoad
                                          timeoutInterval:0];
    
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:nil
                                                      error:nil];
    if (data)
    {
        [FastWebImage setThreadImageWithData:data forImageView:self];
        return YES;
    }
    return NO;
}

+ (void)setThreadImageWithData:(NSData *)data forImageView:(UIImageView *)imageView
{
    NSData * cData = [[NSData alloc] initWithData:data];
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
            UIImage * image  = [[UIImage alloc] initWithData:cData];
            UIImage * dImage = [UIImage decodedImageWithImage:image];
            [cData release];
            [image release];
        dispatch_async(mainQueue, ^{
            [imageView setImage:dImage];
        });
        dispatch_release(mainQueue);
    });
    dispatch_release(queue);
}

@end
