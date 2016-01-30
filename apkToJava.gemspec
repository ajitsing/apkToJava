# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative './lib/apk_to_java/version.rb'

Gem::Specification.new do |s|
  s.name                        =   'apkToJava'
  s.version                     =   ApkToJava::VERSION
  s.date                        =   '2016-01-28'
  s.summary                     =   'View android apk as as java in GUI'
  s.description                 =   s.summary
  s.authors                     =   ['Ajit Singh']
  s.email                       =   'jeetsingh.ajit@gamil.com'
  s.license                     =   'MIT'
  s.homepage                    =   'https://github.com/ajitsing/apkToJava'

  s.files                       =   `git ls-files -z`.split("\x0")
  s.executables                 =   s.files.grep(%r{^bin/}) { |f| File.basename(f)  }
  s.test_files                  =   s.files.grep(%r{^(test|spec|features)/})
  s.require_paths               =   ["lib"]
end
