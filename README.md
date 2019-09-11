# Cocoapods Pod Merge Plugin

Pod-merge is a Cocoapods plugin to **group** and **merge** cocoapods used by your Xcode project into one or more pods, so as to reduce the number of dynamic frameworks your app has to load on startup.

The plugin introduces a new file to your project: the `MergeFile`, and hooks into the pre-install phase of `pod install` to merge your dependencies based on your `MergeFile`

## Installation

#### Using Bundler 

If your Xcode project does not have a `Gemfile` yet, [learn how to set it up here](https://www.mokacoding.com/blog/ruby-for-ios-developers-bundler/). It's highly recommended you use [**bundler**](https://bundler.io/) to maintain consistent versions of tools like `cocoapods`, `fastlane` etc within your team. 

To use cocoapods-pod-merge, add this line to your app's Gemfile:

```ruby
gem 'cocoapods-pod-merge'
```

And then install it using [bundler](https://bundler.io/) by executing:

    $ bundle install

Note than this is a cocoapods plugin, hence it requires cocoapods as a dependency.

## Usage

To get started, just add this line to the top of your existing `Podfile`:

```
plugin `cocoapods-pod-merge`
```

Then run

    $ bundle exec pod install

On the first run, the plugin will automatically create a `MergeFile` for you.

## MergeFile
## Feedback & Contributing

If unlimit does not work for you, please [report it](https://github.com/biocross/unlimit/issues/new), I might have missed a lot of edge cases! Any feedback or feature suggesions are also encouraged.  

Bug reports and pull requests are welcome. 

## FAQs

### Why can't I just do it myself?



## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).