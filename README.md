
# bench_ios

<img width=128px src="https://github.com/gwh111/bench_ios/blob/master/bench_ios/icon.png?raw=true" >    

[bench_ios开发指南](https://gwh111.github.io/2019/10/11/bench-ios/)  
[解析文章](https://blog.csdn.net/gwh111/article/details/100700830)   

'bench_ios' is a framework for efficient development.  
It is not only itself, but also provides a scheduling mode, which can be accessed to different modules according to their own business needs.  

## Podfile install

To integrate bench_ios into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'bench_ios'
end
```

Then, run the following command:

```bash
$ pod install
```

When use, just import 'ccs.h' in your .pch file.  
If you use 'XcodeCustom' as project-template, just add pch path in 'Build Settings' - 'Prefix Header' as  '$(SRCROOT)/projectname/projectname-prefix.pch'

```ruby
// xxx.pch
import "ccs.h"
```

以增加开发效率为目的集成bench_ios开发。  
bench_ios 不仅仅是它本身，还提供的是一种调度模式，可以根据自己业务需求接入不同模块来使用。详见 **组件化分类使用方法**。

## 模板使用
参考XcodeCustom文件夹下README.md
包括工程模板和类模板，模板只需添加一次，**Xcode更新后需要重新添加**。

### Xcode 工程模板
模板文件在XcodeCustom文件夹下。  
使用工程模板会初始化 CC_AppDelegate  CC_ViewController pch 文件。  
/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project\ Templates/Base
目录下面添加bench_ios Application文件夹即可。  
1. 打开Xcode选择 ***File - New - Project***
2. 滚到下面选择 bench_ios Application > Custom Single App 创建一个新工程。
3. 在 targets > Build Settings > Prefix Header 添加 **xxx** 工程的pch的路径。**$(SRCROOT)/xxx/xxx-prefix.pch**
4. 使用pod安装bench_ios。

### Xcode 类模板
类模板支持 CC_AppDelegate CC_ViewController CC_TabBarController  
/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File\ Templates 目录下面添加bench_ios Class文件夹即可。  
新建类使用 New File > bench_ios Class > Cocoa Touch Class


