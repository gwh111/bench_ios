
Pod::Spec.new do |spec|
  spec.name         = 'bench_ios'
  spec.version      = '2.1.7'
  spec.license      = { :type => 'BSD' }
  spec.homepage     = 'https://github.com/gwh111/bench_ios'
  spec.authors      = { 'apple' => '173695508@qq.com' }
  spec.summary      = 'IOS bench tool for developer'
  spec.source       = { :git => 'https://github.com/gwh111/bench_ios.git', :tag => 'v2.1.7' }
  spec.frameworks   = 'UIKit'  
  spec.module_name  = 'ccs'

  spec.ios.deployment_target  = '7.0'

  spec.source_files       = 'bench_ios/bench/ccs.{h,m}'
  spec.resources          = 'bench_ios/bench_ios.bundle'

    spec.subspec 'CC_Core' do |ss|
      ss.source_files = 'bench_ios/bench/**/*'
    end

end
