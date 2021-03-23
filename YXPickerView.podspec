
Pod::Spec.new do |s|
  s.name         = "YXPickerView"
  s.version      = "1.2.1"
  s.summary      = "省市区选择、筛选项选择、日期选择、时间选择等等"
  s.description  = <<-DESC
                    项目中经常会用到选择器，比如省市区选择、筛选项选择、日期选择、时间选择等等，此项目做了一个封装以方便使用。
                   DESC
  s.homepage     = "https://github.com/caoyunxiao/YXPickerView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Matej caoyunxiao' => 'chinacgcgcg@163.com' }
  s.source       = { :git => "https://github.com/caoyunxiao/YXPickerView.git", :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = "YXPickerView/**/*.{h,m}"
  s.requires_arc = true
  s.resources = "YXPickerView/Resource/YXBundle.bundle"
end