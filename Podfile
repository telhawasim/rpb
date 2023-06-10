# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RPB' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RPB
  
  target 'RPBTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RPBUITests' do
    # Pods for testing
  end
  
  pod 'IQKeyboardManagerSwift'
  pod 'SwiftLint'
  pod 'NVActivityIndicatorView'
  pod 'Kingfisher'
  pod "AlignedCollectionViewFlowLayout"
  pod "FlagPhoneNumber"
  pod 'SkeletonView'
  pod 'PhoneNumberKit', :git => 'https://github.com/marmelroy/PhoneNumberKit'

end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
         end
    end
  end
end
