//
//  SYAppStart.m
//  FEShareLib
//
//  Created by 余书懿 on 13-5-25.
//  Copyright (c) 2013年 豆豆集团. All rights reserved.
//

#import "SYAppStart.h"

@implementation SYAppStart


#define Tag_appStartImageView 1314521

static UIWindow *startImageWindow = nil;

+ (void)show
{
    if (startImageWindow == nil) {
        startImageWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        startImageWindow.backgroundColor = [UIColor clearColor];
        startImageWindow.userInteractionEnabled = NO;
        startImageWindow.windowLevel = UIWindowLevelStatusBar + 1; //必须加1
        startImageWindow.rootViewController = [[SYAppStartViewController alloc] init];
    }

    [startImageWindow setHidden:NO];
}
+ (void)hide:(BOOL)animated
{
    UIImageView *imageView = (UIImageView *)[startImageWindow viewWithTag:Tag_appStartImageView];
    if (imageView) {
        if (animated) {
            [UIView animateWithDuration:1.5 delay:0 options:0 animations:^{
                [imageView setTransform:CGAffineTransformMakeScale(2, 2)];
                [imageView setAlpha:0];
            } completion:^(BOOL finished) {
                [SYAppStart clear];
            }];
        }else
        {
            [SYAppStart clear];
        }
    }
}

+ (void)hideWithCustomBlock:(void (^)(UIImageView *))block
{
    UIImageView *imageView = (UIImageView *)[startImageWindow viewWithTag:Tag_appStartImageView]; 
    if (imageView) {
        if (block) {
            block(imageView);
        }
    }
}

+ (void)clear
{
    UIImageView *imageView = (UIImageView *)[startImageWindow viewWithTag:Tag_appStartImageView];
    [imageView removeFromSuperview];
    startImageWindow.rootViewController = nil;
    [startImageWindow removeFromSuperview];
    startImageWindow = nil;
}

+ (UIView *)getDefaultLaunchView
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil];
    if (nibs.count > 0) {
        UIView *launchView = nibs[0];
        return launchView;
    }
    return nil;
}

+ (UIImage *)getDefaultImage
{
    NSString *imageName = nil;
    //判断是否是iPhone5
    if (CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) {
        imageName = @"MiserLaunchImage-568h@2x.png";//iphone5 ios7启动图片名字
    }else
    {
        imageName = @"MiserLaunchImage-480h@2x.png";//iphone4s ios7启动图片名字
    }
    //使用 imageWithContentsOfFile 加载图片使用完以后及时释放资源
    NSString *imageFilePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath],imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:imageFilePath];
    if (image == nil) {
        NSAssert(NO, @"两个原因导致没有获取到默认背景图片 1:名字没有使用 Default.png? 2: 使用了iOS7 的新特性 Images Assets?");
    }
    return image;
}

@end

@implementation SYAppStartViewController
////App Start 在显示的时候不需要状态, 在iOS 7隐藏状态栏 需要重写以下方法
//- (BOOL)prefersStatusBarHidden
//{
//    return NO;
//}
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //ios8 启动方式用的是xib 从xib 获取
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) {
        UIView *launchView = [SYAppStart getDefaultLaunchView];
        [self.view addSubview:launchView];
        [launchView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
        [launchView setFrame:self.view.bounds];
        launchView.tag = Tag_appStartImageView;
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f) {
        UIImageView *imageView = nil;
        imageView = [[UIImageView alloc] initWithImage:[SYAppStart getDefaultImage]];
        imageView.tag = Tag_appStartImageView;
        [self.view addSubview:imageView];
        [imageView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
        [imageView setFrame:self.view.bounds];
    }
    
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)dealloc
{
   //会自动释放掉
}

@end
