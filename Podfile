# Uncomment the next line to define a global platform for your project
platform :ios, '12.2'

def shared_pods
  pod 'Cuckoo', '~> 1.0.6'
  pod 'Quick', '~> 2.1.0'
  pod 'Nimble', '~> 8'
end

target 'WeatherZone' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!
  
  # Pods for WeatherZone
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'SwiftLint'
  pod 'Kingfisher', '~> 5.0'
  pod 'SkyFloatingLabelTextField', '~> 3.0'
  pod 'lottie-ios', '~> 3.1.2'

  target 'WeatherZoneTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '~> 5.0.0'
    pod 'RxTest',     '~> 5.0.0'
    shared_pods
  end
  
  target 'WeatherZoneUITests' do
    inherit! :search_paths
    # Pods for testing
    shared_pods
  end
  
end
