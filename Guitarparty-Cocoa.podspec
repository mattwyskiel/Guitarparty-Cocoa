Pod::Spec.new do |s|
  s.name         = "Guitarparty-Cocoa"
  s.version      = "0.0.5"
  s.summary      = "A client library for guitarparty.com, written in Swift, for iOS and OS X"
  s.description  = <<-DESC
                   Welcome to the **Guitarparty iOS and OS X Client Library**. This library enables developers to access the plethora of chords and tabs in the [Guitarparty.com](http://www.guitarparty.com) database.

I wrote this library in the midst of my exploration of the new Swift language developed by Apple. So enjoy, catch bugs, submit pull requests, and make use of this library as much as you need.
                   DESC
  s.homepage     = "https://github.com/mattwyskiel/Guitarparty-Cocoa"
  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author             = { "Matthew Wyskiel" => "mwyskiel@optonline.net" }
  s.social_media_url   = "http://twitter.com/MattWyskiel"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.source       = { :git => "https://github.com/mattwyskiel/Guitarparty-Cocoa.git", :tag => "#{s.version}" }
  s.source_files  = "Guitarparty/*.{swift}"
  s.weak_framework  = "Foundation"
  s.requires_arc = true
  s.module_name = "Guitarparty"
end
