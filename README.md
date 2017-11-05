In 2010, I attempted to learn a bit about iOS development, by spending a week porting the [Android Nounours app](https://github.com/caarmen/nounours-android) to iOS. I didn't read any introduction to iOS development before diving in, so it's not surprising if the project structure and coding style don't follow iOS standards. I haven't done any iOS development since then, so I still don't know what these standards are today :)

This repo is here as a backup for my reference. I wouldn't recommend using it as an example of how to develop iOS apps.

To run the app on a simulator:

* Launch Xcode
* Create a new workspace
* File - Add files
* Select `Nounours.xcodeproj`
* Open a terminal
* If cocoapods isn't installed, install it: https://guides.cocoapods.org/using/getting-started.html
* Install the pod for thsi project: `pod install`
* In Xcode: Product -> Run
