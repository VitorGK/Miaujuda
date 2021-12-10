//
//  Localization.swift
//  Helpets
//
//  Created by Caroline Taus on 10/12/21.
//

import Foundation
import UIKit
import CoreLocation
import Contacts

extension CLLocation {
    func geocode(completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(self, completionHandler: completion)
    }
}


extension Formatter {
    static let mailingAddress: CNPostalAddressFormatter = {
        let formatter = CNPostalAddressFormatter()
        formatter.style = .mailingAddress
        return formatter
    }()
}

extension CLPlacemark {
    var mailingAddress: String? {
        postalAddress?.mailingAddress
    }
}

extension CNPostalAddress {
    var mailingAddress: String {
        Formatter.mailingAddress.string(from: self)
    }
}


