# Uncomment the next line to define a global platform for your project
# platform :ios, '17.0'

target 'TrainingTimer' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TrainingTimer

  pod 'FirebaseAnalytics'
  pod 'Firebase/Crashlytics'
  pod 'Google-Mobile-Ads-SDK'
  
end

post_install do |installer|
  fix_deployment_target(installer)
end

def fix_deployment_target(installer)
  return if !installer
  project = installer.pods_project
  project_deployment_target = project.build_configurations.first.build_settings['IPHONEOS_DEPLOYMENT_TARGET']

  puts "Make sure all pods deployment target is #{project_deployment_target.green}"
  project.targets.each do |target|
    puts "  #{target.name}".blue
    target.build_configurations.each do |config|
      old_target = config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']
      new_target = project_deployment_target
      next if old_target == new_target
      puts "    #{config.name}: #{old_target.yellow} -> #{new_target.green}"
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = new_target
    end
  end
end

