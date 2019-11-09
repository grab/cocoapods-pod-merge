# Copyright 2019 Grabtaxi Holdings PTE LTE (GRAB), All rights reserved.
# Use of this source code is governed by an MIT-style license that can be found in the LICENSE file

require 'cocoapods-pod-merge/Main'

module CocoapodsPodMerge
    Pod::HooksManager.register('cocoapods-pod-merge', :pre_install) do |installer_context|
        PodMerger.new.begin(installer_context)
    end

    Pod::HooksManager.register('cocoapods-pod-merge', :post_install) do |installer_context|
        PodMerger.new.add_mergefile_to_project(installer_context)
    end
end

