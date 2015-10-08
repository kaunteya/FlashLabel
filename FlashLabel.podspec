Pod::Spec.new do |s|
  s.name = 'FlashLabel'
  s.version = '0.4.0'
  s.license = 'MIT'
  s.summary = 'Simple and Lightweight Timer Label for Mac'
  s.homepage = 'https://github.com/kaunteya/FlashLabel'
  s.authors = { 'Kaunteya Suryawanshi' => 'k.suryawanshi@gmail.com' }
  s.source = { :git => 'https://github.com/kaunteya/FlashLabel.git', :tag => s.version }

  s.platform = :osx, '10.10'
  s.requires_arc = true

  s.source_files = 'FlashLabel.swift'
end
