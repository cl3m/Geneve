platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!

target "Geneve" do
    pod 'GoogleAnalytics', '~> 3.17'
    pod 'FeedKit', '~> 7.0'
    pod 'ESOpenSourceLicensesKit', '~> 2.0'
    pod 'HTMLString', '~> 4.0'
    pod 'STRegex', '~> 1.1'
    pod 'Kingfisher', '~> 4.6'
    pod 'Kml.swift', :git => 'https://github.com/elikohen/Kml.swift.git'
end

post_install do |installer_representation|
    system("ruby Pods/ESOpenSourceLicensesKit/ESOpenSourceLicensesKit/Scripts/generate_licenses.rb --post_install")
end
