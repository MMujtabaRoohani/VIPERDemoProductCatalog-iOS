//
//  HTTPHeaders+DPC.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

extension HTTPHeaders {
    static var defaultHeaders: Self {
        return [
            "Authorization": Bundle.main.infoDictionary?["API_KEY"] as! String,
            "x-device-type": "ios",
            "x-app-version": Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String,
            "x-os-version": UIDevice.current.systemVersion
        ]
    }
}
