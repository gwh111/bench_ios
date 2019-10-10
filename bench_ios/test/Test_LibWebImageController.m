//
//  Test_LibWebImageController.m
//  bench_ios
//
//  Created by 路飞 on 2019/9/20.
//

#import "Test_LibWebImageController.h"
#import "UIView+CCWebImage.h"
#import "ccs.h"

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
    .cc_addToView(_imageV);
}
@end

@interface Test_LibWebImageController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, copy) NSArray* imgArr;

@end

@implementation Test_LibWebImageController

#pragma mark - lifeCycle
- (void)cc_viewDidLoad {
    [self initDatas];
    [self initNav];
    [self initViews];
}
#pragma mark - network

#pragma mark - private
-(void)initDatas{
    
}
-(void)initNav{
    
}
-(void)initViews{
    [[CC_WebImageManager shared] clearAllWebImageCache:^{
        NSLog(@"全部清理完成了！！！！！");
    }];
    self.imgArr = @[
                    @"https://ft.kkbuluo.net/team/logo/97072.htm?type=h",//非认证的https地址
                    @"http://img0.imgtn.bdimg.com/it/u=1494244059,3693074065&fm=26&gp=0.jpg", @"https://test-kkbuluo-resource.cdn.hzmltest.com/MAPI/RESOURCE/MAPI_MESSAGE/IMAGE/50_INFO_IMAGE?version=1553774609847",
                    @"http://mapi.kkbuluo.net/userLogoUrl.htm?userId=10004002000208540100290980130890&timestamp=1556441786784",
                    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556024562531&di=9ea4ac52b4bffaef86b8b3a1a6e887fa&imgtype=0&src=http%3A%2F%2Fimg.bimg.126.net%2Fphoto%2FvyMFjTx_KKOY5kqjhrzjow%3D%3D%2F4236479874473114923.jpg",
                    @"https://pics7.baidu.com/feed/7acb0a46f21fbe0986dde42ce2d8b1378644ad40.jpeg?token=0bc4df2e1e58d48bab7516549872bd25&s=4602ECAB29C816C8525464BD0300A003", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556024562532&di=bdb079286990b0ca11f4f0a3d26d2149&imgtype=0&src=http%3A%2F%2Fimg.alicdn.com%2Fimgextra%2Fi3%2F2894246297%2FTB2KYjuuYXlpuFjy1zbXXb_qpXa_%2521%25212894246297-1-headline_editor.gif"
                    ];
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIImageView* imgV = ccs.ImageView
    .cc_frame(0, 200, 100, 100)
    .cc_addToView(self.view);
    [imgV cc_setImageWithURL:[NSURL URLWithString:@"http://mapi.kkbuluo.net/userLogoUrl.htm?userId=10004002000208540100290980130890&timestamp=1556441786784"] placeholderImage:nil processBlock:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
        
    }];
}
#pragma mark - public

#pragma mark - target

#pragma mark - notification

#pragma mark - delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell* cell = [TableViewCell createTableViewCellWithTableView:tableView];
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
