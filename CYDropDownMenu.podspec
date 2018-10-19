Pod::Spec.new do |s|
  s.name         = "CYDropDownMenu"
  s.version      = "1.0.2"
  s.summary      = "An iOS Drop Down Menu."
  s.description  = <<-DESC
                    An iOS Drop Down Menu, like desktop application menu.
                   DESC
  s.homepage     = "https://github.com/chenyun122/CYDropDownMenu"
  s.screenshots  = "https://github.com/chenyun122/CYDropDownMenu/raw/master/ScreenShots/CYDropDownMenu.gif?raw=true"
  s.license      = "MIT"
  s.author             = { "Yun CHEN" => "chenyun122@gmail.com" }
  s.platform     = :ios, "8.0"
  s.requires_arc = true
  s.source       = { :git => "https://github.com/chenyun122/CYDropDownMenu.git", :tag => "#{s.version}" }
  s.source_files  = "CYDropDownMenu", "CYDropDownMenu/**/*.{h,m}"
  s.resource_bundles = {
    'CYDropDownMenu' => ['CYDropDownMenu/**/*.xcassets']
  }
end
