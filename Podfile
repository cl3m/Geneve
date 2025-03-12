platform :ios, '13.0'
inhibit_all_warnings!
use_frameworks!

target "Geneve" do
    pod 'GoogleAnalytics', '~> 3.23.0'
    pod 'FeedKit', '~> 9.1.2'
    pod 'ESOpenSourceLicensesKit', '~> 2.0'
    pod 'HTMLString', '~> 4.0'
    pod 'STRegex', '~> 2.1.1'
    pod 'Kingfisher', '~> 8.2.0'
    pod 'Kml.swift', :git => 'https://github.com/elikohen/Kml.swift.git'
end

post_install do |installer|
    system("ruby Pods/ESOpenSourceLicensesKit/ESOpenSourceLicensesKit/Scripts/generate_licenses.rb --post_install")
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
