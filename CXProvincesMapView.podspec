#
#  Be sure to run `pod spec lint CXProvincesMapView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

spec.name         = "CXProvincesMapView"
spec.version      = "0.1.0"
spec.summary      = "CXProvincesMapView 是一个显示中国省份的地图控件"

spec.description  = <<-DESC
CXProvincesMapView 是一个显示中国省份的地图控件,支持点击效果的设置.
DESC

spec.homepage     = "https://github.com/CXTretar/CXProvincesMapView"

spec.license      = "MIT"

spec.author       = { "CXTretar" => "misscxuan@163.com" }
spec.platform     = :ios, "8.0"
spec.source       = { :git => 'https://github.com/CXTretar/CXProvincesMapView.git', :tag => spec.version.to_s }

spec.source_files  = "CXProvincesMapView/CXProvincesMapView/*.{h,m}"
spec.requires_arc = true

end
