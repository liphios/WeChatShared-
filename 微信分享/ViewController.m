//
//  ViewController.m
//  微信分享
//
//  Created by 李鹏辉 on 16/9/28.
//  Copyright © 2016年 company. All rights reserved.
//

#import "ViewController.h"
#import "WXApi.h"
@interface ViewController ()

@end
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define RandomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0]
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *btnArr = @[@"分享到WeChat",@"分享到朋友圈"];
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(Width / 2 - 50, (i+1)*100, 100, 30);
        btn.tintColor = RandomColor;
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
}
//点击了按钮的响应事件

- (void)clickBtn:(UIButton *)btn{
    
    
    switch (btn.tag) {
        case 0://分享到QQ
    
            //分享文字
            [self shareText];
        
            break;
        case 1://分享到微信朋友圈
            [self shareImage];
            break;
    
        default:
            break;
    }
    
    
}

//微信分享文字--微信好友
- (void)shareText{
    
    SendMessageToWXReq*req = [[SendMessageToWXReq alloc] init];
    req.text = @"分享内容";
    req.bText = YES;
    req.scene = WXSceneSession;// 分享给微信好友
    [WXApi sendReq:req];
    
}

//微信分享图片--微信朋友圈

- (void)shareImage{
    
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"缩略图.png"]];
    WXImageObject *imageObject = [WXImageObject object];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"snow" ofType:@"jpg"];
    imageObject.imageData = [NSData dataWithContentsOfFile:filePath];
    message.mediaObject = imageObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;//发送消息类型
    req.scene = WXSceneTimeline;//微信朋友圈
    req.message = message;
    [WXApi sendReq:req];
    
}




@end
