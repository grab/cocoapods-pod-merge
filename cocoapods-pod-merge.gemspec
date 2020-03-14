# Copyright 2019 Grabtaxi Holdings PTE LTE (GRAB), All rights reserved.
# Use of this source code is governed by an MIT-style license that can be found in the LICENSE file
# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-pod-merge/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-pod-merge'
  spec.version       = CocoapodsPodMerge::VERSION
  spec.authors       = ['Siddharth Gupta']
  spec.email         = ['siddharth.gupta@grabtaxi.com']
  spec.description   = %q{Cocoapods plugin to merge your pods into one framework, to reduce dylib loading time on app startup.}
  spec.summary       = %q{Cocoapods plugin to merge your pods into one framework, to reduce dylib loading time on app startup.}
  spec.homepage      = 'https://github.com/grab/cocoapods-pod-merge'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0.0'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 13.0'
end
