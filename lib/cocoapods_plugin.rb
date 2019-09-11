require 'cocoapods-pod-merge/Main'

module CocoapodsPodMerge
    Pod::HooksManager.register('cocoapods-pod-merge', :pre_install) do |installer_context|
        PodMerger.new.begin(installer_context)
    end
end

