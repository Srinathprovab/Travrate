# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Travrate' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Travrate

  pod 'ReachabilitySwift', '~> 4.3.0'
  pod 'SwiftyJSON'
  pod 'IQKeyboardManager'
  pod 'SDWebImage'
  pod 'MBProgressHUD'
  pod 'JTAppleCalendar', '~> 7.1.6'
  pod 'Alamofire'
  pod 'DropDown'
  pod 'TTRangeSlider'
  pod 'MaterialComponents/TextControls+OutlinedTextFields'
  pod 'AARatingBar'
  pod 'GoogleMaps'
  pod 'Toast-Swift', '~> 5.0.1'
  pod 'SwiftRangeSlider', '~> 2.0'
  pod 'MyFatoorah'
  pod 'Ottu'
  pod 'EasyTipView', '~> 2.1.0'

  target 'TravrateTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TravrateUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.6'
      end
    end
  end

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      # You might want to process the xcconfig here if needed
    end
  end
end
