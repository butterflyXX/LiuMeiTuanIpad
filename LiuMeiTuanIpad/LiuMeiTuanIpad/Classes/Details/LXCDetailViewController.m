//
//  LXCDetailViewController.m
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/20.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "LXCDetailViewController.h"
#import <UIImageView+WebCache.h>

@interface LXCDetailViewController ()<DPRequestDelegate,UIWebViewDelegate>

//图片
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//描述
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
//当前价格
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
//原价
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
//已售数
@property (weak, nonatomic) IBOutlet UIButton *purchaseCountBtn;
//收藏按钮
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
//团购截止时间
@property (weak, nonatomic) IBOutlet UIButton *deadlineBtn;
//随时退按钮
@property (weak, nonatomic) IBOutlet UIButton *refunableBtn;
//过期退按钮
@property (weak, nonatomic) IBOutlet UIButton *outDateBtn;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;


@end

@implementation LXCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
    
    [self requestDataFromDPAPI];
    
    [self setupWebView];
}
- (IBAction)dismissLclick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupUI{
    //设置控件数据
    self.titleLabel.text = _dealModel.title;
    self.descLabel.text = _dealModel.desc;
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_dealModel.s_image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    //设置现价 获取到价格/数量等float类型的数据,使用float类型来接近,使用NSNumber进行转换,去掉小数点后多余的位数
    self.currentPriceLabel.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithFloat:_dealModel.current_price]];
    self.listPriceLabel.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithFloat:_dealModel.list_price]];
    //设置已售数量
    [self.purchaseCountBtn setTitle:[NSString stringWithFormat:@"已售: %d", _dealModel.purchase_count] forState:UIControlStateNormal];
}

-(void)setupWebView {
    
    
    
    //截取deal_id
    NSRange range = [_dealModel.deal_id rangeOfString:@"-"];
    NSString *paramStr = [_dealModel.deal_id substringFromIndex:range.location + 1];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@", paramStr]]];
    
    [self.webView loadRequest:request];
    self.webView.scrollView.bounces = NO;
}

#pragma mark - 网络请求

- (void)requestDataFromDPAPI{
    //设置参数
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    //设置dealID 必须设置
    [param setValue:self.dealModel.deal_id forKey:@"deal_id"];
    
    //请求团购数据
    [[DPAPI new] requestWithURL:@"v1/deal/get_single_deal" params:param delegate:self];
}


//获取数据成功
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    
    NSArray *deals = result[@"deals"];
    
    if (deals.count) {
        
        self.refunableBtn.selected = ([result[@"deals"][0][@"restrictions"][@"is_refundable"] boolValue]) ? YES : NO;
        self.outDateBtn.selected = self.refunableBtn.selected;
    }
    
    
}


//获取数据失败
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    
    LxcLog(@"获取数据失败%@", error);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingView stopAnimating];
    
    NSMutableString *jsStr = [NSMutableString new];
    
    [jsStr appendString:@"var header = document.getElementsByTagName('header')[0];"];
    
    [jsStr appendString:@"header.parentNode.removeChild(header);"];
    
    [jsStr appendString:@"var div = document.getElementsByTagName('div')[0];"];
    
    [jsStr appendString:@"div.parentNode.removeChild(div);"];
    
    [jsStr appendString:@"var div = document.getElementsByTagName('a')[0];"];
    
    [jsStr appendString:@"div.parentNode.removeChild(div);"];
    
    [jsStr appendString:@"var div = document.getElementsByTagName('footer')[0];"];
    
    [jsStr appendString:@"div.parentNode.removeChild(div);"];
    
    //执行js代码
    [webView stringByEvaluatingJavaScriptFromString:jsStr];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    LxcLog(@"web加载失败");
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}



@end
