
Pod::Spec.new do |s|
  s.name         = "ExtensionKit"
  s.version      = "1.0.0"
  s.summary      = "A whole bunch of Swift Extensions for some quality of life development."
  s.description  = "Extension Kit is a library that offers extensions to a bunch of Apple's standard library"
  s.homepage     = "https://gitlab.com/carlos.grossi/ExtensionKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Carlos Grossi" => "carlos.grossi@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://gitlab.com/carlos.grossi/ExtensionKit.git", :tag => "#{s.version}" }
  s.source_files  = "ExtensionKit/ExtensionKit/**/*.{h,m}"
  s.exclude_files = "ExtensionKit/Classes/Exclude"
end
