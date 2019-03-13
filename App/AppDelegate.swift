//
//  AppDelegate.swift
//  App
//
//  Created by Petr Šíma on 06/03/2019.
//  Copyright © 2019 Petr Šíma. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import enum Result.NoError
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.



    // https://www.youtube.com/watch?v=DrdxSNG-_DE

    // Petr Sima
    // iOS

    // Formerly Ackee
    // Formerly MI-iOS

    // codementor
    // freelance dev
    // freelance co-genius

    // FRP, ReactiveSwift

    /*
     let strings = ["I", "<3", "Mi", "iOS"]

     //imperative
     var shortLowercaseStrings: [String] = []
     strings.forEach {
     if $0.count > 1 {
     shortLowercaseStrings.append($0)

     }
     }
     shortLowercaseStrings

     //functional
     strings
     .filter { $0.count > 1}
     .map { $0.lowercased() }
     */
    //functional reactive

    let s = ["I", "<3", "Mi", "iOS"]
      .reduce("", +)
    print(s)


    let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle(identifier: "cz.cvut.fit.RS"))
    let vc = storyboard.instantiateInitialViewController()!


    enum RequestError: Error {
      case usernameEmpty
      case httpFail(String)
    }


    func checkAvailability(username: String) -> SignalProducer<String, RequestError> {
      return SignalProducer { observer, lifetime in
        struct Handle { func cancel() { } }
        let handle: Handle = .init() ///firebase.addSnapshotObserve

        lifetime.observeEnded {
          handle.cancel()
        }
        /*
        guard !username.isEmpty else {
          observer.send(error: .usernameEmpty)
          return
        }

        let delay = Int.random(in: 0..<5)


        DispatchQueue.main.asyncAfter(deadline: .now() + Double(delay)) {
          if Int.random(in: 0..<3) % 3 == 0  {
            observer.send(error: .httpFail("Network fail"))
            return
          }

          observer.send(value: "Username \(username) is available")
          observer.sendCompleted()
        }*/
      }
    }








    vc.reactive.signal(for: #selector(UIViewController.viewDidLoad)).observeValues { _ in

      guard let vc = vc as? VC else { return }
      print(vc)

      let x = checkAvailability(username: "")
        .flatMapError {
          SignalProducer(value: "there was an error but who cares, \($0)")
      }

      vc.label.reactive[\.text] <~ x

//
//      let strings =
////        SignalProducer(["I", "<3", "Mi", "iOS"])
//        vc.textField.reactive
//          .controlEvents(.editingChanged)
//           .map { $0.text ?? "" }
//          .flatMap(.latest) {
//            checkAvailability(username: $0)
//              .flatMapError {
//                SignalProducer(value: "there was an error but who cares, \($0)")
//            }
//      }
//
//      vc.label.reactive[\.text] <~ strings
//



//      strings.observeResult {
//        switch $0 {
//        case .success(let v):
//          print(v)
//        case .failure(let e):
//          print(e)
//        }
//      }


        //.reduce("", +)
//        .filter { $0.count <= 2 }
//        .map { $0.lowercased() }


      let locationManager = CLLocationManager()

    }


    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = vc
    window?.makeKeyAndVisible()


//hot, eager
    //ReactiveSwift.Signal
    //RxSwift.Observable
// cold, lazy
    //ReactiveSwift.SignalProducer
    //RxSwift.Observable

    let itemsSignal: Signal<[String], NoError> = .empty

    reactive[\.items] <~ itemsSignal


tableView.dataSource = self

    return true
  }




  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  let tableView = UITableView()
  var items: [String] = [] {
    didSet {
      tableView.reloadData()
    }
  }

}

extension AppDelegate: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
    cell.textLabel.text = items[indexPath.row]
    return cell
  }


}



extension Reactive where Base: CLLocationManager {
  var location: SignalProducer<CLLocation?, NoError> {
    return SignalProducer { observer, lifetime in
        base.delegate = ....
        base.startUpdatingLocation()



      observer.send(value: location)
      lifetime.observeEnded {
         base.stopUpdatingLocation()
      }
    }
  }
}
