
Pod::Spec.new do |spec|
  spec.name         = 'bench_ios'
  spec.version      = '2.2.3'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/gwh111/bench_ios'
  spec.authors      = { 'apple' => '173695508@qq.com' }
  spec.summary      = 'IOS bench tool for developer'
  spec.source       = { :git  => 'https://git.benchdev.cn/apple/bench_ios.git' }
  spec.frameworks   = 'UIKit'  
  spec.module_name  = 'ccs'

  spec.ios.deployment_target  = '7.0'

  spec.source_files       = 'bench_ios/bench/*'
  spec.resources          = 'bench_ios/bench/bench_ios.bundle'
  # spec.source_files     = 'bench_ios/bench/**/*'
  # spec.resources    = 'bench_ios/bench/debugPluginList/debug_function.plist'

  spec.subspec 'debugPlugin' do |ss|
  	ss.source_files = 'bench_ios/bench/debugPlugin*/**/*.{h,m,mm}'
  	ss.resources = 'bench_ios/bench/debugPluginList/debug_function.plist'  	
  end
  
  spec.subspec 'C' do |ss|
    ss.source_files = 'bench_ios/bench/C/**/*'
  end

  spec.subspec 'CC_Kit' do |ss|
    ss.source_files = 'bench_ios/bench/CC_Kit/**/*'
  end

  spec.subspec 'CC_Lib' do |ss|
    ss.source_files = 'bench_ios/bench/CC_Lib/**/*'
  end

  spec.subspec 'CC_Objects' do |ss|
    ss.source_files = 'bench_ios/bench/CC_Objects/**/*'
  end

  spec.subspec 'CC_Foundation' do |ss|
    ss.source_files = 'bench_ios/bench/CC_Foundation/**/*'
  end

  spec.subspec 'CC_CoreFoundation' do |ss|
    ss.source_files = 'bench_ios/bench/CC_CoreFoundation/**/*'
  end

end
