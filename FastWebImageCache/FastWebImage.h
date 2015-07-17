//
//  FastWebImage.h
//  WebImageDemo
//
//  Created by Zhenwang Zha on 15-6-1.
//  Copyright (c) 2015年 zhenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FastWebImage : UIImageView

/**
 *  请求网络图片
 *
 *  @param url 图片链接
 */
- (void)setImageWithURL:(NSString *)urlString;

/**
 *  异步绘图
 *
 *  @param data  图片数据
 *  @param imageView 图片容器
 */
+ (void)setThreadImageWithData:(NSData *)data forImageView:(UIImageView *)imageView;

@end
