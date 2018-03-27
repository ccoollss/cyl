//
//  InfoModelsModels.swift
//  Mabius
//
//  Created by Timafei Harhun on 2/20/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

enum InfoType: Int {
    case restorePass = 0
    case confirmMail
    case application
}

struct InfoModels {
    
    struct Input {
    }

    struct Output {
    }

    struct ViewModel {
        
        struct InfoData {
        
            var navbarText: String
            var labelText: String
            var iconName: String
            var buttonTitle: String
            
            init(type: InfoType) {
                switch type {
                
                case .application:
                    navbarText = "UI.registration".localize()
                    labelText = "messages.thanks".localize()
                    iconName = "icDoneBig"
                    buttonTitle = "UI.willbewaiting".localize()
                    
                case .confirmMail:
                    navbarText = "UI.confirmEmail".localize()
                    labelText = "messages.emailSent".localize()
                    iconName = "icEmailBig"
                    buttonTitle = "UI.gotNothing".localize()
                    
                case .restorePass:
                    navbarText = "UI.forgotPassword".localize()
                    labelText = "messages.linkSent".localize()
                    iconName = "icEmailBig"
                    buttonTitle = "UI.again".localize()
                }
            }
        }
    }
}