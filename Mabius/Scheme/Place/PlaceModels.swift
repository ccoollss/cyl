//
//  PlaceModels.swift
//  Mabius
//
//  Created by Timafei Harhun on 2/27/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

struct Place {
    
    struct Input {
        var selectedCountry: String?
        var selectedCity: String?
        var address: String?
//        var moreInfo: String?
    }

    struct Output {
        var location: Location
        var address: String
    }

    struct ViewModel {
        var country: String?
        var city: String?
        var address: String?
        var more: String?
    }
}

extension Place.Input {
    
    var isValid: Bool {
        guard let selectedCountry = selectedCountry else { return false }
        guard let selectedCity = selectedCity else { return false }
        guard let address = address else { return false }
        return selectedCountry.length >= minAddressLength && selectedCity.length >= minAddressLength && address.length > minAddressLength && selectedCountry.length <= maxCountryLength && selectedCity.length <= maxCountryLength && address.length <= maxAddressLength
    }
}

let minAddressLength = 2
let maxAddressLength = 40
let maxCountryLength = 20


