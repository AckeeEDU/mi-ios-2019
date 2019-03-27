//: [Previous](@previous)
//: # CI
//: ## .travis.yml
//: - umožňuje definovat, co se děje v jednotlivých fázích buildu, popř. před nimi/po nich
//:
//: ```yaml
//: osx_image: xcode10.1
//: language: objective-c
//: cache: cocoapods
//: install:
//: - pod install --project-directory=mi-ios-2019
//: script:
//: - set -o pipefail && xcodebuild test -scheme mi-ios-2019/mi-ios-2019.xcworkspace -destination 'platform=iOS Simulator,name=iPhone XS,OS=12.1' ONLY_ACTIVE_ARCH=YES | xcpretty
//: ```
//: [Next](@next)
