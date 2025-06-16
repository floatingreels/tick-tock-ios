//
//  CustomAlert.swift
//  TickTock
//
//  Created by David Gunzburg on 10/06/2025.
//

import Alamofire

struct CustomAlert {
    let title: String
    let message: String
    let actions: [AlertAction]
    
    static func serviceError(_ error: AFError, code: Int?) -> CustomAlert {
        var title = error.failureReason ?? Translation.Error.general_title.val
        if let code {
            title += " [\(code)]"
        }
        return CustomAlert(
            title: title,
            message: error.errorDescription ?? Translation.Error.general_message.val,
            actions: [AlertAction(title: Translation.General.buttonOk.val, completion: {})]
        )
    }
    
    static func generalError() -> CustomAlert {
        CustomAlert(
            title: Translation.Error.general_message.val,
            message: Translation.Error.general_message.val,
            actions: [AlertAction(title: Translation.General.buttonOk.val, completion: {})]
        )
    }
}

struct AlertAction: Identifiable {
    var id: String { return title }
    let title: String
    let completion: () -> Void
}
