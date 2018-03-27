platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end

def common_pods
    # Core
    pod 'SwiftyUserDefaults', '~> 3.0'
    pod 'ObjectMapper', '~> 2.2'
    pod 'Simplicity', '~> 2.0'
    
    # UI
	pod 'Localize', '~> 1.5'
	
    pod 'LFSideViewController', :git => 'https://github.com/4ndrey/LFSideViewController.git', :commit => 'e583a87'
    pod 'TagListView', '~> 1.1'
    pod 'Nuke', '~> 5.0'
    pod 'KMPlaceholderTextView', '~> 1.3.0'
end

target 'Mabius' do

common_pods

# Analytics
pod 'Fabric'
pod 'Crashlytics'

end

target 'MabiusTests' do
    common_pods
end

target 'MabiusUITests' do
    common_pods
end
