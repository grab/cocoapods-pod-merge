# Cocoapods Pod Merge Plugin

pod-merge is a Cocoapods plugin to **merge** dependencies (or pods) used by your Xcode project, to reduce the number of dynamic frameworks your app has to load on app startup.

The plugin introduces a new file to your project: the **MergeFile**, and hooks into the pre-install phase of `pod install` to merge your dependencies.

## Installation

#### Using Bundler 

If your Xcode project does not have a `Gemfile` yet, it's highly recommended you use [**bundler**](https://bundler.io/) to maintain consistent versions of tools like cocoapods within your team.  [Learn how to set it up here](https://www.mokacoding.com/blog/ruby-for-ios-developers-bundler/).

To use cocoapods-pod-merge, add this line to your app's `Gemfile`:

```ruby
gem 'cocoapods-pod-merge'
```

And then install it using [bundler](https://bundler.io/) by executing:

    $ bundle install

Note than **this is a cocoapods plugin**, hence it requires cocoapods as a dependency.

## Usage

Using this plugin to merge your pods is a simple three step process:

#### 1. Create a MergeFile

This plugin requires a file called **MergeFile**. This is how it looks:

```ruby
group 'Networking'
	pod 'AFNetworking'
	pod 'SDWebImage'
end
```

The above MergeFile:

* Defines a group named `Networking`. This will be the name of the resulting merged pod.
* Tells the plugin to merge `AFNetworking` & `SDWebImage` into `Networking`

#### 2. Update your Podfile

Now, update your Podfile to use the plugin, as well as the merged pods:

Add the line **plugin 'cocoapods-pod-merge'** to the top of your existing `Podfile`, and modify it to use the merged pod.

```ruby
plugin `cocoapods-pod-merge`

target 'MyApp'
	# pod 'AFNetworking' # Not needed anymore, since we'll use the merged Pod
	# pod 'SDWebImage' # Not needed anymore, since we'll use the merged Pod
	pod 'Networking', :path => 'MergedPods/Networking' # The merged pod
end
```

Things to note:

* We commented out the pods 'AFNetworking' & 'SDWebImage' above, since these will now be installed as part of the merged `Networking` framework.
* We add the merged framework `Networking`, which is named as the group name defined in our MergeFile
* The path is fixed, since the plugin will put your merged pods in the `MergedPods/<group name>` directory.

#### 3. Run Pod Install & Update your Code!

That's it! Just run:

    $ bundle exec pod install

If all goes well, the pods should be merged according to your MergeFile, and should be available to use in your project. 

There's _one more thing_! There's no framework such as `AFNetworking` or `SDWebImage` available to your project now, since these are now merged into a pod named`Networking` So, as a one time process, replace imports of the merged libraries in your project like

```swift
import AFNetworking
```

to 

```swift
import Networking.AFNetworking
```

And that's it! You're done!

## MergeFile

The `MergeFile` has a very similar syntax to your `Podfile`. It also supports defining **multiple** groups, which creates **multiple** merged pods.

Consider a more common **Podfile**, with lots of pods, fixed versions, and different sources:

```RUBY
target 'MyApp'
	pod 'AFNetworking', '2.7.0'
	pod 'SDWebImage', '~> 5.0'
	pod 'IQKeyboardManager', '6.2.1'
	pod 'TTTAttributedLabel', '2.0.0'
	pod 'MBProgressHUD', :git => 'https://github.com/jdg/MBProgressHUD.git', :tag => '1.1.0'
	pod 'FLAnimatedImage', '1.0.12'
end
```

Let's group these Pods into two: `UI`, and `Networking`. The MergeFile to achieve this would look like this:

```ruby
group 'Networking'
	pod 'AFNetworking', '2.7.0'
	pod 'SDWebImage', '~> 5.0'
end

group 'UI'
	pod 'IQKeyboardManager', '6.2.1'
	pod 'TTTAttributedLabel', '2.0.0'
	pod 'MBProgressHUD', :git => 'https://github.com/jdg/MBProgressHUD.git', :tag => '1.1.0'
	pod 'FLAnimatedImage', '1.0.12'
end
```

Two things to note here:

* The MergeFile supports defining Pods just like your Podfile, with all the options that the Podfile supports, like the `:path, :git, :branch` arguments.
* You can have any number of groups in your MergeFile. The resulting merged dependencies will be named by the groups defined in your MergeFile.

You can now modify your original `Podfile` to use the merged pods instead of the individual pods: 

```ruby
target 'MyApp'
	pod 'Networking', :path => 'MergedPods/Networking'
	pod 'UI', :path => 'MergedPods/UI'
end
```

That's it! Now just run `bundle exec pod install`!

> Note: Once the pods are merged according to your `MergeFile`, you **should commit** the `MergeFile` into your version control system (like git)

### Special Flags

#### has_dependencies!

If you have a group of Pods that depend on each other and you want merge them, add this flag into that group.

```ruby
group 'SomePods'
	has_dependencies!
	pod 'ABC'
	pod 'ABCDependsOnThis'
end
```

This enables an experimental feature where the plugin tries to fix dependency imports. For example, If pod `ABC` has code like  `import <ABCDependsOnThis/File.h>`, the plugin will automatically convert this import into `#import "File.h"`, since after the merge, the both the pods will be in the same framework.

## Version Control (like git)

You should definitely commit the `MergeFile`  into your repository, since this is just like your Podfile, and is required for the plugin to work. 

The plugin creates a directory called `MergedPods`, where it keeps the source code and podspecs for the merged pods. Whether you decide you commit this directory depends entirely on your team's workflow. A good rule of thumb is if you commit the `Pods/` directory created by Cocoapods, then you should commit this directory as well. The obvious upside is that the merged pods are cached, and the merge does not take place everytime `pod install` is run, unless something changes.

The plugin also creates another directory called `MergeCache` when it's running. While this directory is removed when the plugin is done, it can be good practice to add to your `.gitignore` file just in case the plugin fails to remove it.

```bash
MergeCache/
```

If you decide not to commit the MergedPods directory, add that to the `.gitignore` as well:

```bash
MergeCache/
MergedPods/
```

## Tips

This plugin is not a magic bullet that'll merge all your cocoapods into a single framework. Here's a few tips to save you from hard to debug issues after merging your pods.

* Start small, by merging a small number (2 to 4) of your Pods, and check everything works after the merge.
* Try to make logical sense of your groups, don't just merge every single Pod your app uses into one giant pod. This can be very fragile, and can lead to hard to debug compilation / linking issues.
* Refrain from merging complex or specialized pods (like pods written in C/C++). Such pods can have special build settings and compiler flags that can break the other pods that are merged with them.


## Troubleshooting

If the above guidelines still do not solve your problem, please [report it](https://github.com/grab/cocoapods-pod-merge/issues)! Merging Pods is a complex process, and the plugin does not cover all possible use cases or podspec formats. Any feedback or feature suggesions are also encouraged. Bug reports and pull requests are welcome. 

## License

The cocoapods-pod-merge plugin is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).