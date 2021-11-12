Pod::Spec.new do |s|
  s.name             = 'SearchEngine'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SearchEngine.'
  s.description      = 'SearchEngine module'
  s.homepage         = 'http://github.com/pauloec'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'paulo.ec@hotmail.com' => 'paulo.ec@hotmail.com' }
  s.source           = { :git => '',
 :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'
  s.source_files     = 'SearchEngine/**/*'
  s.resource_bundles = {
    'SearchEngine' => ['Assets/**/*.{png,xcassets,json,txt,storyboard,xib,xcdatamodeld,strings}']
  }
    
end
