
Pod::Spec.new do |spec|
  spec.name         = 'bench_ios'
  spec.version      = '1.0.2'
  spec.license      = { :type => 'BSD' }
  spec.homepage     = 'https://github.com/gwh111/bench_ios'
  spec.authors      = { 'apple' => '173695508@qq.com' }
  spec.summary      = 'ARC and GCD Compatible Reachability Class for iOS and OS X.'
  spec.source       = { :git => 'https://github.com/gwh111/bench_ios.git', :tag => 'v1.0.2' }
  spec.frameworks   = 'UIKit'  
  spec.module_name  = 'Rich'

  spec.ios.deployment_target  = '7.0'

  spec.source_files       = 'bench_ios/bench/**/*'


end
