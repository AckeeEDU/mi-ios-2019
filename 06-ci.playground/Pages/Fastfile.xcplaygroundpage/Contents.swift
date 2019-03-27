//: [Previous](@previous)
//: # CI
//: ## Fastfile
//:
//: - ruby file pro definici akcí fastlanu
//: - umí specifikovat verzi Xcodu
//:
//: ### Lane
//: - sdružuje více akcí do jednoho volání
//: - může přebírat parametry
//: - pokud specifikuji popis, tak fastlane umí vygenerovat "dokumentaci"
//: - _provisioning_, _dependencies_, _build_, _tests_, _deploy_
//:
//: ```ruby
//: xcversion(version: "~> 10.1")
//:
//: desc "Run tests, build app and upload to HockeyApp"
//: lane :beta do |options|
//:     cocoapods
//:     scan
//:     gym
//:     hockey(public_identifier: <hockey_identifier>, api_token: <api_token>)
//: end
//: ```
//:
//: [Next](@next)
