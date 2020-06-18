//
//  TemplateManager.swift
//  Sukedachi
//
//  Created by Kazumi Hayashida on 2020/04/14.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class TemplateManager {
    static let shared = TemplateManager()

    var message: String {
        get {
            return userDefaults[.templateMessage]

        } set {
            userDefaults[.templateMessage] = newValue
        }
    }

    var scout: String {
        get {
            return userDefaults[.templateScout]

        } set {
            userDefaults[.templateScout] = newValue
        }
    }

    var masterMessage: String {
        let jobs = Session.shared.userNew.specialities.map { $0.label }
        let jobsString = jobs.joined(separator: "、")
        return String(format: App.String.messageTemplate,
                      Session.shared.userNew.getDisplayNameOld(),
                      Session.shared.userNew.area,
                      jobsString)
    }

    var masterScout: String {
        let jobs = Session.shared.userNew.specialities.map { $0.label }
        let jobsString = jobs.joined(separator: "、")
        return String(format: App.String.scoutTemplate,
                      Session.shared.userNew.area,
                      jobsString)
    }

    func masterScoutWithName(name: String) -> String {
        let jobs = Session.shared.userNew.specialities.map { $0.label }
        let jobsString = jobs.joined(separator: "、")
        guard let template = App.String.scoutTemplate.replace(pattern: "〇〇", withString: name) else { return "" }
        return String(format: template,
                      Session.shared.userNew.area,
                      jobsString)
    }
}
