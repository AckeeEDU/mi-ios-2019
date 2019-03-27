//: [Previous](@previous)
//: # CI
//: ## Xcode CLI
//: - všechny akce (build/run/test/...) jsou jen interface nad *xcodebuild*
//: - všechny se dají volat z CLI
//: - syntaxe není nic moc 🤢
//: > xcodebuild [-project name.xcodeproj]
//: > [[-target targetname] ... | -alltargets]
//: > [-configuration configurationname]
//: > [-sdk [sdkfullpath | sdkname]] [action ...]
//: > [buildsetting=value ...] [-userdefault=value ...]
//: - reálně to pak vypadá možná ještě hůř
//: ```
//: xcodebuild test -scheme mi-ios-2019 -workspace mi-ios-2019.xcworkspace -destination 'platform=iOS Simulator,name=iPhone XS Max,OS=12.1'
//: ```
//: - v nejjednodušší verzi lze volat bez parametru
//: - výstup je nic moc - dá se řešit přes **xcpretty**
//:
//: [Next](@next)
