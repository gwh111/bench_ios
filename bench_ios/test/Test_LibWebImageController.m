//
//  Test_LibWebImageController.m
//  bench_ios
//
//  Created by 路飞 on 2019/9/20.
//

#import "Test_LibWebImageController.h"
#import "UIView+CCWebImage.h"
#import "ccs.h"
#import "TestNetwork.h"

@interface TableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView* imageV;
+(instancetype)createTableViewCellWithTableView:(UITableView*)tableView;
@end
@implementation TableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
+(instancetype)createTableViewCellWithTableView:(UITableView *)tableView{
    TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (!cell) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell initViews];
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
-(void)initViews{
    self.imageV = ccs.ImageView
    .cc_frame(0, 0, [UIScreen mainScreen].bounds.size.width, 200)
    .cc_addToView(self)
    .cc_hideAnimation(NO);
}
@end

@interface Test_LibWebImageController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, copy) NSArray* imgArr;

@end

@implementation Test_LibWebImageController

#pragma mark - lifeCycle
- (void)cc_viewDidLoad {
    [self initDatas];
    [self initViews];
}
#pragma mark - network

#pragma mark - private
-(void)initDatas{
    
}
-(void)uploadImg{
    
    CC_HttpConfig *configure = ccs.httpTask.configure;
    configure.signKeyStr = @"USS445e0f8e9f9040ec80f705ae167ae732";
    configure.httpHeaderFields = @{@"appVersion":@"2.2.1",@"appName":@"pandasport-iphone"}.mutableCopy;
    ccs.httpTask.configure = configure;
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params setObject:@"IMAGE_UPLOAD" forKey:@"service"];
    [params setObject:@"10174004749320571500290980173880" forKey:@"authedUserId"];
    [params setObject:@"SUBJECT" forKey:@"imageType"];
    UIImage *img=[UIImage imageNamed:@"tabbar_mine_high"];
        
    [[ccs httpTask] imageUpload:@[img] url:@"http://api1.doctor.onlinetreat.net" params:params imageSize:0.1 reConnectTimes:3 finishBlock:^(NSArray<HttpModel *> *errorModelArr, NSArray<HttpModel *> *successModelArr) {
        
    }];
}
-(void)initViews{

    self.imgArr = @[
                    @"https://ft.kkbuluo.net/team/logo/97072.htm?type=h",//非认证的https地址
                    @"http://img0.imgtn.bdimg.com/it/u=1494244059,3693074065&fm=26&gp=0.jpg", @"https://test-kkbuluo-resource.cdn.hzmltest.com/MAPI/RESOURCE/MAPI_MESSAGE/IMAGE/50_INFO_IMAGE?version=1553774609847",
                    @"http://mapi.kkbuluo.net/userLogoUrl.htm?userId=10004002000208540100290980130890&timestamp=1556441786784",
                    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556024562531&di=9ea4ac52b4bffaef86b8b3a1a6e887fa&imgtype=0&src=http%3A%2F%2Fimg.bimg.126.net%2Fphoto%2FvyMFjTx_KKOY5kqjhrzjow%3D%3D%2F4236479874473114923.jpg",
                    @"https://pics7.baidu.com/feed/7acb0a46f21fbe0986dde42ce2d8b1378644ad40.jpeg?token=0bc4df2e1e58d48bab7516549872bd25&s=4602ECAB29C816C8525464BD0300A003", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556024562532&di=bdb079286990b0ca11f4f0a3d26d2149&imgtype=0&src=http%3A%2F%2Fimg.alicdn.com%2Fimgextra%2Fi3%2F2894246297%2FTB2KYjuuYXlpuFjy1zbXXb_qpXa_%2521%25212894246297-1-headline_editor.gif",
                    @"https://test-kkbuluo-resource.cdn.hzmltest.com/MAPI/RESOURCE/MAPI_MESSAGE/IMAGE/50_INFO_IMAGE?version=1553774609847",
                    @"http://mapi.kkbuluo.net/userLogoUrl.htm?userId=10004002000208540100290980130890&timestamp=1556441786784",
                    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556024562531&di=9ea4ac52b4bffaef86b8b3a1a6e887fa&imgtype=0&src=http%3A%2F%2Fimg.bimg.126.net%2Fphoto%2FvyMFjTx_KKOY5kqjhrzjow%3D%3D%2F4236479874473114923.jpg",
                    @"https://pics7.baidu.com/feed/7acb0a46f21fbe0986dde42ce2d8b1378644ad40.jpeg?token=0bc4df2e1e58d48bab7516549872bd25&s=4602ECAB29C816C8525464BD0300A003", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556024562532&di=bdb079286990b0ca11f4f0a3d26d2149&imgtype=0&src=http%3A%2F%2Fimg.alicdn.com%2Fimgextra%2Fi3%2F2894246297%2FTB2KYjuuYXlpuFjy1zbXXb_qpXa_%2521%25212894246297-1-headline_editor.gif",
                    ];
//    self.imgArr=@[@"http://mapi.kkbuluo.net/userLogoUrl.htm?userId=10004002000208540100290980130890&timestamp=1556441786784",@"https://pics7.baidu.com/feed/7acb0a46f21fbe0986dde42ce2d8b1378644ad40.jpeg?token=0bc4df2e1e58d48bab7516549872bd25&s=4602ECAB29C816C8525464BD0300A003",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556024562531&di=9ea4ac52b4bffaef86b8b3a1a6e887fa&imgtype=0&src=http%3A%2F%2Fimg.bimg.126.net%2Fphoto%2FvyMFjTx_KKOY5kqjhrzjow%3D%3D%2F4236479874473114923.jpg",@"https://pics7.baidu.com/feed/7acb0a46f21fbe0986dde42ce2d8b1378644ad40.jpeg?token=0bc4df2e1e58d48bab7516549872bd25&s=4602ECAB29C816C8525464BD0300A003",@"http://mapi.kkbuluo.net/userLogoUrl.htm?userId=10004002000208540100290980130890&timestamp=1556441786784",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556024562531&di=9ea4ac52b4bffaef86b8b3a1a6e887fa&imgtype=0&src=http%3A%2F%2Fimg.bimg.126.net%2Fphoto%2FvyMFjTx_KKOY5kqjhrzjow%3D%3D%2F4236479874473114923.jpg",@"http://mapi.kkbuluo.net/userLogoUrl.htm?userId=10004002000208540100290980130890&timestamp=1556441786784",@"https://pics7.baidu.com/feed/7acb0a46f21fbe0986dde42ce2d8b1378644ad40.jpeg?token=0bc4df2e1e58d48bab7516549872bd25&s=4602ECAB29C816C8525464BD0300A003",@"http://mapi.kkbuluo.net/userLogoUrl.htm?userId=10004002000208540100290980130890&timestamp=1556441786784",@"https://pics7.baidu.com/feed/7acb0a46f21fbe0986dde42ce2d8b1378644ad40.jpeg?token=0bc4df2e1e58d48bab7516549872bd25&s=4602ECAB29C816C8525464BD0300A003",@"http://mapi.kkbuluo.net/userLogoUrl.htm?userId=10004002000208540100290980130890&timestamp=1556441786784",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556024562531&di=9ea4ac52b4bffaef86b8b3a1a6e887fa&imgtype=0&src=http%3A%2F%2Fimg.bimg.126.net%2Fphoto%2FvyMFjTx_KKOY5kqjhrzjow%3D%3D%2F4236479874473114923.jpg",@"http://mapi.kkbuluo.net/userLogoUrl.htm?userId=10004002000208540100290980130890&timestamp=1556441786784",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556024562531&di=9ea4ac52b4bffaef86b8b3a1a6e887fa&imgtype=0&src=http%3A%2F%2Fimg.bimg.126.net%2Fphoto%2FvyMFjTx_KKOY5kqjhrzjow%3D%3D%2F4236479874473114923.jpg",@"http://mapi.kkbuluo.net/userLogoUrl.htm?userId=10004002000208540100290980130890&timestamp=1556441786784",];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, ccs.width, ccs.height-STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    
    self.imageV = ccs.ImageView
    .cc_frame(0, 0, [UIScreen mainScreen].bounds.size.width, 200)
    .cc_addToView(self.view)
    .cc_hideAnimation(NO);
    
    
    UIImageView *sv             = [UIImageView new];
    sv.frame               = CGRectMake(100, 100, 200, 200);
    sv.backgroundColor     = [UIColor whiteColor];
    sv.layer.cornerRadius  = 20;
    sv.layer.masksToBounds = YES;
    
    [self.view addSubview:sv];
    [sv cc_setShadow:UIColor.blueColor offset:CGSizeMake(8, 8) opacity:0.5];
    
    UIImageView* imgV = ccs.ImageView
    .cc_frame(50, 300, 100, 100)
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_cornerRadius(20)
    .cc_addToView(self.view);
    [imgV cc_setShadow:UIColor.blueColor offset:CGSizeMake(8, 8) opacity:0.5];
    
    CC_Button *btn = ccs.Button
        .cc_frame(ccs.width-RH(40), NAV_BAR_HEIGHT, RH(40), RH(40))
        .cc_addToView(self.view)
        .cc_setTitleForState(@"清理",UIControlStateNormal)
        .cc_backgroundColor(UIColor.grayColor);
        [btn cc_addTappedOnceDelay:0.2 withBlock:^(CC_Button *btn) {
    //        [self uploadImg];
            NSLog(@"%@",self.imageV);
            [ccs clearAllWebImageCache:^{
                CCLOG(@"清理完成");
                [ccs gotoMain:^{
                    [imgV stopAnimating];
                    imgV.image=nil;
                }];
            }];
        }];
    
    CC_Button *btnAdd = ccs.Button
        .cc_frame(ccs.width-RH(40), 100, RH(40), RH(40))
        .cc_addToView(self.view)
        .cc_setTitleForState(@"添加",UIControlStateNormal)
        .cc_backgroundColor(UIColor.yellowColor);
        [btnAdd cc_addTappedOnceDelay:0.2 withBlock:^(CC_Button *btn) {
            [sv cc_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556024562532&di=bdb079286990b0ca11f4f0a3d26d2149&imgtype=0&src=http%3A%2F%2Fimg.alicdn.com%2Fimgextra%2Fi3%2F2894246297%2FTB2KYjuuYXlpuFjy1zbXXb_qpXa_%2521%25212894246297-1-headline_editor.gif"] placeholderImage:nil processBlock:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                CCLOG(@"%ld---%ld", (long)receivedSize, (long)expectedSize);
            } completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
                CCLOG(@"Download finish!!!");
                
            }];
            
            [self.imageV cc_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556024562532&di=bdb079286990b0ca11f4f0a3d26d2149&imgtype=0&src=http%3A%2F%2Fimg.alicdn.com%2Fimgextra%2Fi3%2F2894246297%2FTB2KYjuuYXlpuFjy1zbXXb_qpXa_%2521%25212894246297-1-headline_editor.gif"] placeholderImage:nil processBlock:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
                
            }];
            
            [imgV cc_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556024562532&di=bdb079286990b0ca11f4f0a3d26d2149&imgtype=0&src=http%3A%2F%2Fimg.alicdn.com%2Fimgextra%2Fi3%2F2894246297%2FTB2KYjuuYXlpuFjy1zbXXb_qpXa_%2521%25212894246297-1-headline_editor.gif"] placeholderImage:nil processBlock:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                CCLOG(@"%ld---%ld", (long)receivedSize, (long)expectedSize);
            } completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
                CCLOG(@"Download finish!!!");
                
            }];
        }];
}

#pragma mark - public

#pragma mark - target

#pragma mark - notification

#pragma mark - delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell* cell = [TableViewCell createTableViewCellWithTableView:tableView];
//    [cell.imageV cc_setImageWithURL:[NSURL URLWithString:_imgArr[indexPath.row]] placeholderImage:nil showProgressView:YES completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
//
//    }];
    [cell.imageV cc_setImageWithURL:[NSURL URLWithString:_imgArr[indexPath.row]] placeholderImage:nil processBlock:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        NSLog(@"第%ld张，%ld/%ld", indexPath.row, receivedSize,expectedSize);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {

    }];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _imgArr.count;
}
#pragma mark - property



@end
