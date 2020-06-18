//
//  BadgeManager.swift
//  Sukedachi
//
//  Created by MBA0023 on 11/25/19.
//  Copyright © 2019 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class BadgeManager {

    static let shared = BadgeManager()

    var badgeForMessage: Int = 0 {
        didSet {
            refreshBadgeOnTabbar()
        }
    }

    var badgeForMyPage: Int = 0 {
        didSet {
            NotificationCenter.default.post(name: .updateNoticationButtonBadge, object: self)
        }
    }
    
    var badgeForPayTop: Int = 0 {
        didSet {
            refreshBadgeOnTabbar()
        }
    }
    
    var badgeForSeeMore: Int = 0 {
        didSet {
            refreshBadgeOnTabbar()
            NotificationCenter.default.post(name: .badgeMoreTopChanged, object: self)
        }
    }
    
    var badgeTodoList: Int = 0
    var badgeCancelList: Int = 0
    var badgeWaitingList: Int = 0
}

extension BadgeManager {

    private func refreshBadgeOnTabbar() {
        let totalBadge = badgeForMessage + badgeForMyPage
        UIApplication.shared.applicationIconBadgeNumber = totalBadge
        let tabBarVC = AppDelegate.shared.tabBarRootVC
        tabBarVC?.updateTabItems()
    }

    func updateBadgeValue(unread: UnreadInfo) {
        BadgeManager.shared.badgeForMessage ?= unread.messagesUnread
        BadgeManager.shared.badgeForSeeMore ?= unread.insuranceUnread
        BadgeManager.shared.badgeForPayTop ?= unread.payTotalUnread
        BadgeManager.shared.badgeTodoList ?= unread.todoListUnread
        BadgeManager.shared.badgeWaitingList ?= unread.waitingListUnread
        BadgeManager.shared.badgeCancelList ?= unread.payListCancelUnread + unread.payListDoneUnread
    }
}

// MARK: - API
extension BadgeManager {
    
    func getUnreads(completion: @escaping (Error?) -> Void) {
        Api.Unreads.getUnread {(result) in
            if case .failure(let error) = result {
                completion(error)
            }
        }
    }

    func getNotifications(completion: @escaping (Error?) -> Void) {
        let notificationRequest = Api.Notification.RequestNotif(page: 1, isRead: false)
        notificationRequest.getList { result in
            switch result {
            case .success:
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
