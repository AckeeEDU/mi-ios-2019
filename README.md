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
