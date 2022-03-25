Pod::Spec.new do |s|

  s.name         = "XLEncrypt"
  s.version      = "1.0.0"
  s.summary      = "XLEncrypt."
  s.requires_arc = true
  s.is_ipub      = true
  s.description  = <<-DESC
                    加密库
                   DESC
  s.author = { "XL" => "XL" }
  s.ios.deployment_target = '8.0'
  s.source       = { :git => "" , :tag => s.version.to_s}

  s.source_files  = "ModuleCode/**/*.{h,m}"
  s.resource_bundles = {'XLEncrypt'=>"ModuleCode/**/*.{xcassets,strings,xml,storyboard,xib,xcdatamodeld,html}"}
  s.vendored_libraries = "ModuleCode/**/*.{a}"

end
