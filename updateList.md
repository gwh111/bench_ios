API格式：
1、i = 3;//等号或其他符号两边加空格
2、@property (nonatomic,retain) NSDictionary *cc_modelDic;//属性
3、(NSDictionary *) //类和 * 之间有空格
4、- (void)cc_setProperty:(NSDictionary *)dic;//函数
5、- (void)cc_setProperty:(NSDictionary *)dic {
      }//函数实现括号前有一个空格
6、if (!value) {
      //
      } else {
      //
      }//if 和 else 两边有空格
7、两行函数之间有一行空格

19/12/10 apple
添加手动屏幕旋转
[ccs setDeviceOrientation:UIDeviceOrientationLandscapeLeft];

19/07/30 Liuyi
CC_Mask中添加一个判断指示器状态的方法
当异步加载数据时,CC_Mask视图并不能阻止当前页面的事件触发

19/07/23 apple
addResponseLogic里stop了CC_Mask
CC_Notice/CC_Note里error为空不显示

19/07/10 Liuyi
在 CC_Share.h 添加了一个声明方法过期的宏
CCDeprecated

在UIButton分类中添加
cc_setBackgroundColor:forState:
设置按钮指定状态的背景色

19/06/26 david
添加CC_UserInfoMgr类, 用此类的单例为各个kit库提供用户信息

19/06/12 Liuyi
更新CC_ServerURLManager类,动态切换服务器
知识库链接:http://d.net:8090/pages/viewpage.action?pageId=29298076

19/06/11 Liuyi
添加UIResponder+CCCat分类,添加cc_currentFirstResponder方法
添加UIScrollView+CCCat分类,添加cc_kdAdapterWithOffset:方法
知识库链接:http://d.net:8090/pages/viewpage.action?pageId=29298675

19/06/11 david
添加UITextField+CCCat分类, 并添加方法checkWithMaxLength:
添加UITextView+CCCat分类, 并添加方法checkWithMaxLength:
讲解见知识库: iOS前车之鉴/textView/textField限制输入长度
连接: http://d.net:8090/pages/viewpage.action?pageId=29298940

19/06/11 apple
修改UIImageView+CCCat分类，重写会导致userInteractionEnabled=YES

19/06/18 lufei
修改CC_UploadImagesTool类，上传图片后结果按顺序输出；
修改CC_HttpResponseModel类，添加index属性；

19/06/25 lufei
修改CC_WebView类，添加加载htmlString的方法；


