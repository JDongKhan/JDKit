Pod::Spec.new do |spec|
    spec.name         = 'JDKit'
    spec.version      = '1.0.0' 
    spec.summary      = 'JDKit'
    spec.homepage     = 'https://github.com/JDongKhan'
    spec.license      = 'MIT'
    spec.authors      = {'JD' => '419591321@qq.com'}
    spec.platform     = :ios, '8.0'
    spec.source       = {:git => 'https://github.com/JDongKhan/JDKit.git', :tag => spec.version}
    spec.requires_arc = true
    spec.ios.deployment_target = '8.0'

    spec.default_subspec = 'UIKit'

    spec.subspec 'Foundation' do |foundation|
      foundation.source_files = 'Sources/Foundation/**/*.{h,m,mm}'
    end
  
    spec.subspec 'UIKit' do |uikit|
      uikit.source_files = 'Sources/UIKit/**/*.{h,m}'
      uikit.dependency 'JDKit/Foundation'
    end
    
end
