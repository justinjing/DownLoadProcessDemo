//
//  ViewController.h
//  DownLoadProcessBar
//
//  Created by da zhan on 13-7-3.
//  Copyright (c) 2013年 da zhan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  YLProgressBar;

@interface ViewController : UIViewController
{
    UIImageView *imageView;
    NSTimer*    progressTimer;
}
@property (nonatomic, retain) IBOutlet YLProgressBar* progressView;
@property (nonatomic, retain) IBOutlet UILabel*  progressValueLabel;
@property (nonatomic, retain) NSTimer*    progressTimer;
 
@end
