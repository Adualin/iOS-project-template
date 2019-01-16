# {{cookiecutter.app_name}}

Supports: iOS 10.x and above

## Branches:

* master - stable app releases
* develop - development branch, merge your feature branches here

## Dependencies:

The project is using cocoapods for managing external libraries and a Gemfile for managing the cocoapods version.

Get Bundler

```
sudo gem install bundler
```

To install the specific cocoapods version run

```
bundle install
```

Then install the pods

```
bundle exec fastlane update
```

### Core Dependencies

* Swiftlint - A tool to enforce Swift style and conventions.
* R.swift - Get strong typed, autocompleted resources like images, fonts and segues in Swift projects
* RxSwift & Others - Reative Extension for Swift and Cocoa
* Moya - Network abstraction layer written in Swift.
* ObjectMapper - ObjectMapper is a framework written in Swift that makes it easy for you to convert your model objects (classes and structs) to and from JSON.
* Kingfisher - A lightweight, pure-Swift library for downloading and caching images from the web.
* SwifterSwift - A handy collection of more than 500 native Swift extensions to boost your productivity.
* FLEX - An in-app debugging and exploration tool for iOS.
* Swinject - Dependency injection framework for Swift with iOS/macOS/Linux.

## Project structure:

* Resources - fonts, strings, images, generated files etc.
* SupportingFiles - configuration plist files
* Models - model objects
* Modules - contains app modules (UI + Code)
* Helpers - protocols, extension and utility classes
