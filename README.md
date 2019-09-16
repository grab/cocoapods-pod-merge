# Cocoapods Pod Merge Plugin

Pod-merge is a Cocoapods plugin to **merge** dependencies (or pods) used by your Xcode project, so as to reduce the number of dynamic frameworks your app has to load on app startup.

The plugin introduces a new file to your project: the `MergeFile`, and hooks into the pre-install phase of `pod install` to merge your dependencies based on your `MergeFile`

## Installation

#### Using Bundler 

If your Xcode project does not have a `Gemfile` yet, [learn how to set it up here](https://www.mokacoding.com/blog/ruby-for-ios-developers-bundler/). It's highly recommended you use [**bundler**](https://bundler.io/) to maintain consistent versions of tools like `cocoapods` etc within your team. 

To use cocoapods-pod-merge, add this line to your app's `Gemfile`:

```ruby
gem 'cocoapods-pod-merge'
```

And then install it using [bundler](https://bundler.io/) by executing:

    $ bundle install

Note than **this is a cocoapods plugin**, hence it requires cocoapods as a dependency.

## Usage

To get started,  add this line to the top of your existing `Podfile`:

```
plugin `cocoapods-pod-merge`
```

Then run

    $ bundle exec pod install

Just like Cocoapods requires a `Podfile` in your project directory, this plugin requires a file called `MergeFile`. After you follow the steps above, the plugin will automatically create a `MergeFile` for you on your first `pod install`.

## MergeFile

The `MergeFile` has a very similar syntax to your `Podfile`. Consider a typical `Podfile`: 

```ruby
target 'MyApp'
	pod 'AFNetworking'
	pod 'MBProgressHUD'
	pod 'SDWebImage'
end
```

Now, if want to merge the  `MBProgressHUD` & `SDWebImage` pods from the above `Podfile`, just define a `group` in your `MergeFile`:

```ruby
group 'UIPods'
	pod 'MBProgressHUD'
	pod 'SDWebImage'
end
```

And that's it! The next time you run `pod install`, the dependencies will automatically be merged into a single pod named `UIPods`, and will be stored in the `MergedPods` directory in your project folder. 

You can then modify your Podfile to use the newly created merged pod: `UIPods`

```ruby
target 'MyApp'
	pod 'AFNetworking'
	pod 'UIPods', :path => 'MergedPods/UIPods'
end
```

> Note: Once the pods are merged according to your `MergeFile`, you **should commit** the `MergeFile` & the `MergePods` folder in your version control system (eg: git), so that the merge process does not occur everytime someone in your team runs `pod install`. **The plugin caches your merged dependencies unless the `MergeFile` is modified**.

## A More Complex MergeFile

Just like your `Podfile`, the `MergeFile` supports all types of Pods you can define in your `Podfile`. Also, you can have **multiple** merged pods, by defining multiple groups in your `MergeFile`.

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

Let's group these Pods into two: `UI`, and `Networking`. The `MergeFile` to achieve this would look like this:

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

* The `MergeFile` supports defining Pods just like your `Podfile`, with all the options that the `Podfile` supports.
* You can any number of groups in your `MergeFile`. The resulting merged dependencies will be named by the groups defined in your `MergeFile`.

You can now modify your original `Podfile` to use the merged dependencies: 

```ruby
target 'MyApp'
	pod 'Networking', :path => 'MergedPods/Networking'
	pod 'UIPods', :path => 'MergedPods/UIPods'
end
```

That's it! Now just run `bundle exec pod install`!

## Troubleshooting

If you're getting compilation or linking issues while using the merged pods, here are some general guidelines to troubleshoot:

* Start small, by merging a small number (2 to 4) of your Pods, and check everything works after the merge.
* Try to make logical sense of your groups, don't just merge every single Pod your app uses into one giant pod. This can be very fragile, and can lead to hard to debug compilation / linking issues.
* Refrain from merging super complex or specialized pods (like pods written in C/C++). Such pods can have special build settings and compiler flags that can break the other pods that are merged with them.

If the above guidelines still do not solve your problem, please [report it](https://github.com/grab/cocoapods-pod-merge/issues)! Merging Pods is a complex process, and the plugin might not have covered all possible cases or podspec formats. Any feedback or feature suggesions are also encouraged. Bug reports and pull requests are welcome. 

## License

The cocoapods-pod-merge plugin is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).