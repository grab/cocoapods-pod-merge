# Inner Workings

If you're curious about how the plugin works, it takes the following steps (in-order) to merge your cocoapods:

- Hook into the pre-install phase of `pod install`
- Read your MergeFile, and figure out groups of Pods it has to merge
- For each of the groups:
  - Create a temporary directory with a Podfile, copy over the contents of the `group`'s pods into that Podfile, and run pod install to get the source files and the `podspecs`.
  - Create a new directory for the merged pod, and copy over all sources files and resources<sup>1</sup> (if any) to the directory.
  - If the `has_dependencies` flag has been added to the group: Find and replace modular imports inside the merged pod
  - Create a new `podspec` for the merged pod (named as the name of the group), and create a union<sup>2</sup> of the build settings of each individual pod into this podspec.
  - Create a `modulemap` file for the merged framework, exposing all the public headers of the merged pods.<sup>3, 4</sup>
  - Copy the finished merged framework into the `MergedPods/<merged pod name>` directory.
  - Repeat this process for the next group
- Calculate an MD5 hash of the MergedPods directory and the current MergeFile, and create a `MergeFile.lock` in the `MergedPods/` directory with the hash.<sup>5</sup>
- Delete the cache directory, and hand over control to cocoapods for the real `pod install`

<sup>1</sup> The plugin supports resource bundles, and other files like static libraries.<br/>
<sup>2</sup> This is why it's not recommended to merge complex pods (like one's containing C/C++), since such pods often have compiler and linker settings that are unique to them, and adversely affect other pods in their group.<br/>
<sup>3</sup> The modulemap helps keep a visible separation between the merged pods when using them code. This is the reason you can use import MergedPods.PodA, instead of using import MergedPods, and importing all the merged pods at once.<br/>
<sup>4</sup> This is why we don't recommend merging swift pods: Namespacing in the swift language is at the module level, and you cannot write a modulemap to have further separation within the module. If you merge a bunch of swift pods, you can only import the whole Merged framework, not the individual pods like import MergedPods.SwiftPodA<br/>
<sup>5</sup> This serves as a simple caching mechanism, and is done to avoid re-merging the pods unless something changes in the MergeFile