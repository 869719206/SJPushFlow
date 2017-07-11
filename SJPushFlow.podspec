
Pod::Spec.new do |s|
  s.name         = 'SJPushFlow'
  s.version      = '1.0.2'
  s.summary      = '推送逻辑处理'
  s.homepage     = 'https://github.com/869719206/SJTest'
  s.license      = 'MIT'
  s.author       = { 'shangjie' => 'jie.shang@pingcl.com' }
  s.platform     = :ios, '9.0'
  s.source       = {:git => 'https://github.com/869719206/SJTest.git', :tag => s.version}
  s.source_files  = 'SJPushFlowDemo/SJPushFlow/*.swift'
  s.requires_arc = true
  s.pod_target_xcconfig = {
  'SWIFT_VERSION' => '3.0',
  }
end
