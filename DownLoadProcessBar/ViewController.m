//
//  ViewController.m
//  DownLoadProcessBar
//
//  Created by da zhan on 13-7-3.
//  Copyright (c) 2013年 da zhan. All rights reserved.
//

#import "ViewController.h"
#import "YLProgressBar.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()

@end

@implementation ViewController
@synthesize progressView;
@synthesize progressValueLabel;
@synthesize progressTimer;
 
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
     imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"download_file_icon.png"]];
    imageView.frame = CGRectMake(240,215,25,25);
    [self.view addSubview:imageView];
    [imageView release];
    
    UIImageView *tt=[[UIImageView alloc] initWithFrame:CGRectMake(240,215,25,25)];
    tt.image = [UIImage imageNamed:@"download_file_icon.png"] ;
    [self.view addSubview:tt];
    [tt release];
    
    UIImageView *tt1=[[UIImageView alloc] initWithFrame:CGRectMake(320-36,460-29,36,28)];
    tt1.image = [UIImage imageNamed:@"download_file_all.png"] ;
    [self.view addSubview:tt1];
    [tt1 release];
    
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.3f
                                                          target:self
                                                        selector:@selector(changeProgressValue)
                                                        userInfo:nil
                                                         repeats:YES];
}


#pragma mark -
#pragma mark YLViewController Public Methods

- (void)changeProgressValue
{
    float progressValue = progressView.progress;
    
    progressValue       += 0.01f;
    if (progressValue > 1)
    {
        progressValue = 0;
    }
    
    if ((int)(progressValue * 100)%3==0) {
        [self tranAction];
    }
    [progressValueLabel setText:[NSString stringWithFormat:@"%.0f%%", (progressValue * 100)]];
    [progressView setProgress:progressValue];
}

 

- (void)tranAction{
    
    CGPoint fromPoint = imageView.center;
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(300, 570);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(300,0)];
    
    //关键帧
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    
    //旋转变化
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //x，y轴缩小到0.1,Z 轴不变
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    //透明度变化
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.4];
    opacityAnim.removedOnCompletion = YES;
    
    //关键帧，旋转，透明度组合起来执行
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim,opacityAnim, nil];
    animGroup.duration = 1;
    [imageView.layer addAnimation:animGroup forKey:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
   
    [super dealloc];
}
@end
