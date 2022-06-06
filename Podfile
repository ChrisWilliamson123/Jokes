# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'Jokes' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Jokes
  pod 'SnapKit', '~> 5.0.0'

  target 'JokesTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'JokesUITests' do
    # Pods for testing
  end

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
        end
    end
end
