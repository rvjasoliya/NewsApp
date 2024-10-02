//
//  Global.swift
//  Actorpay
//
//  Created by iMac on 01/12/21.
//

import Foundation
import UIKit
import MBProgressHUD
import SystemConfiguration

var progressHud = MBProgressHUD()
let obj_AppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

func showLoading() {
    DispatchQueue.main.async {
        if progressHud.superview != nil {
            progressHud.hide(animated: false)
        }
        progressHud = MBProgressHUD.showAdded(to: (obj_AppDelegate.window?.rootViewController!.view)!, animated: true)
        if #available(iOS 9.0, *) {
            UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = UIColor.gray
        } else {
            
        }
        DispatchQueue.main.async {
            progressHud.show(animated: true)
        }
    }
}

func dissmissLoader() {
    DispatchQueue.main.async {
        progressHud.hide(animated: true)
    }
}

// MARK: - CHECK_INTERNET_CONNECTIVITY
func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
    if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
        return false
    }
    
    // Working for Cellular and WIFI
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    let ret = (isReachable && !needsConnection)
    return ret
    
}
