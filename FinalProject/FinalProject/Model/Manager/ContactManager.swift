//
//  ContactManager.swift
//  Sukedachi
//
//  Created by MBA0237P on 5/21/19.
//  Copyright © 2019 Asian Tech Co., Ltd. All rights reserved.
//

import Contacts
import RxSwift

final class ContactManager {
    let store = CNContactStore()

    func requestAccess(completion: @escaping DataCompletion<[String]>) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized:
            fetchData(completion: completion)
        case .denied:
            alertContactPermission()
        case .restricted, .notDetermined:
            store.requestAccess(for: .contacts) { granted, _ in
                if granted {
                    self.fetchData(completion: completion)
                } else {
                    DispatchQueue.main.async {
                        self.alertContactPermission()
                    }
                }
            }
        }
    }

    private func alertContactPermission() {
        guard let topVC = UIApplication.topViewController() else { return }
        let title = App.String.contactPermission
        topVC.alert(title: title, buttons: [App.String.cancel, App.String.setting]) { action in
            guard action.title == App.String.setting,
                let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                UIApplication.shared.canOpenURL(settingsUrl) else { return }
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
    }

    private func fetchData(completion: DataCompletion<[String]>) {
        let keysToFetch = [CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
        var phoneContacts: [String] = []
        do {
            try store.enumerateContacts(with: request) { (contact, _) in
                contact.phoneNumbers.forEach { cnPhoneNumber in
                    if let digits = cnPhoneNumber.value.value(forKey: "digits") as? String {
                        phoneContacts.append(digits)
                    }
                }
            }
            completion(.success(phoneContacts))
        } catch let error {
            completion(.failure(error))
        }
    }
}
