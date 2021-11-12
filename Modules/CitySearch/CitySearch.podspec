Pod::Spec.new do |s|
  s.name             = 'CitySearch'
  s.version          = '0.1.0'
  s.summary          = 'A short description of CitySearch.'
  s.description      = 'CitySearch module'
  s.homepage         = 'http://github.com/pauloec'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'paulo.ec@hotmail.com' => 'paulo.ec@hotmail.com' }
  s.source           = { :git => '',
 :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'
  s.source_files     = 'CitySearch/**/*'
  s.resource_bundles = {
    'CitySearch' => ['Assets/**/*.{png,xcassets,json,txt,storyboard,xib,xcdatamodeld,strings}']
  }
  
  s.dependency 'Core'
  s.dependency 'SearchEngine'
  
end
