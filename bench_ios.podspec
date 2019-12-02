
Pod::Spec.new do |spec|
  spec.name         = 'bench_ios'
  spec.version      = '2.1.6'
  spec.license      = { :type => 'BSD' }
  spec.homepage     = 'https://github.com/gwh111/bench_ios'
  spec.authors      = { 'apple' => '173695508@qq.com' }
  spec.summary      = 'IOS bench tool for developer'
  spec.source       = { :git => 'https://github.com/gwh111/bench_ios.git', :tag => 'v2.1.6' }
  spec.frameworks   = 'UIKit'  
  spec.module_name  = 'ccs'

  spec.ios.deployment_target  = '7.0'

  spec.source_files       = 'bench_ios/bench/*'
  spec.resources          = 'bench_ios/bench_ios.bundle'

  spec.subspec 'CC_Kit' do |ss|
    ss.source_files = 'bench_ios/bench/CC_Kit/**/*'
  end

  spec.subspec 'CC_Lib' do |ss|
    ss.source_files = 'bench_ios/bench/CC_Lib/**/*'
  end

  spec.subspec 'CC_Function' do |ss|
    ss.source_files = 'bench_ios/bench/CC_Function/**/*'
  end

  spec.subspec 'CC_Foundation' do |ss|
    ss.source_files = 'bench_ios/bench/CC_Foundation/**/*'
  end

  spec.subspec 'CC_CoreFoundation' do |ss|
    ss.source_files = 'bench_ios/bench/CC_CoreFoundation/**/*'
  end

end
