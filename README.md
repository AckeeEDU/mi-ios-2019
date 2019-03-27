# mi-ios-2019

## 01. Advanced Xcode
branch: `01-advanced_xcode`
- xcworkspace -> xcodeproj
- targets
  - iOS, tvOS, macOS apps
  - app extensions (today widget, iMesssage ext., klávesnice apod.)
  - tests
  - framework
  - aggregate
- configurations
  - výchozí Debug & Release
- build settings
  - bundle ID per configuration
  - společná verze pro všechny targety
- schemes
- build phases
  - generování build number z počtu commitů pomocí "Run script build phase" a preprocess Info.plist
- [ACKLocalization](https://github.com/AckeeCZ/ACKLocalization)
  - stahování `Localizable.strings` ze spreadsheetu jako aggreagate target
- [SwiftGen](https://github.com/SwiftGen/SwiftGen)
  - Run script build phase na generování swift enums pro localizable klíče

⚠️ Necheckoutujte se do commitu `Add SwiftGen.`! Něco se mi tam nepovedlo a strašne vám to rozbije git.

⚠️⚠️ Na cviku jsme nastavovali swiftgen pomocí `swiftgen.yml`. Podle dokumentace a všech dostupných informací máme všechno správně (input/output files u build phase apod.), ale stejně to nefunguje. Po odstranění konfiguráku a volání swiftgenu příkazem s parametry to funguje správně - viz poslední commit.

## 02. Advanced Swift
branch: `02-advanced_swift`
- doplnění prvního cvika o shared schemes a shared breakpoints
- closures
- advanced enums
- built-in protocols
- custom operátory
- protocol extensions
- generiky
- conditional protocol conformace
- protocol and class composition

## 03. Reactive programming

_TODO_

## 04. MVVM

_TODO_

## 05. Dependency injection & tests

_TODO_

## 06. CI 

[![Build Status](https://travis-ci.com/AckeeEDU/mi-ios-2019.svg?branch=master)](https://travis-ci.com/AckeeEDU/mi-ios-2019)

branch: `06-ci`

- k čemu je CI dobré
- možnosti CI serverů
- Xcode CLI
  - xcodebuild
  - xcpretty
- Travis CI 
  - GitHub integrace
  - .travis.yml
- Gemfile
- fastlane
  - verze Xcodu
  - actions _cocoapods_, _scan_, _gym_
  - Fastfile
