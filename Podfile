use_frameworks!

workspace 'MojoAuthSDK'

platform :ios, '11.0'

target 'SwiftDemo' do
    project 'Example/SwiftDemo/SwiftDemo.xcodeproj'
    pod 'MojoAuthSDK', :path => './'
    #pod 'Google/SignIn', '<= 4.1.0'

    
    post_install do |installer|
    myTargets = ['Eureka']

    installer.pods_project.targets.each do |target|
        if myTargets.include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '5.0'
            end
        end
    end
end

end
