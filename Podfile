# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Gratitude' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Gratitude
  pod 'Firebase/Auth'

  target 'GratitudeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'GratitudeUITests' do
    # Pods for testing
  end

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
end

