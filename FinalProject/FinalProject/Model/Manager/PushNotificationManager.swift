//
//  PushNotificationManager.swift
//  Sukedachi
//
//  Created by MBA0237P on 4/19/19.
//  Copyright © 2019 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Firebase
import ObjectMapper

final class PushNotificationManager {

    private(set) var fcmToken = ""
    private(set) var deviceToken: Data?

    private init() { }

    static let shared = PushNotificationManager()

    func saveFCMToken(token: String) {
        fcmToken = token
    }

    func saveDeviceToken(data: Data) {
        deviceToken = data
    }

    // Un- use
    func unregisterFirebaseToken(completion: APICompletion? = nil) {
        InstanceID.instanceID().deleteID { error in
            if let error = error {
                completion?(.failure(error))
            } else {
                completion?(.success)
            }
        }
    }
}

extension PushNotificationManager {
    
    func loudPushForPayTab(userInfo: [AnyHashable: Any]) {
        if let userInfo = userInfo as? JSObject,
            let info = Mapper<NotificationInfo>().map(JSON: userInfo) {
            handleDirectPush(info: info)
        } else {
            AppDelegate.shared.changeRoot(type: .tabBar(item: .connect))
        }
    }
    
    private func handleDirectPush(info: NotificationInfo) {
        switch info.page {
        case .cardTop:
            openCardTop()
        case .receiveDetail:
            openReceiveDetail(id: info.keys?.id ?? "",
                              moveFrom: .list(receive: true),
                              status: .approved)
        case .receiveDetail1:
            openReceiveDetail(id: info.keys?.id ?? "",
                              moveFrom: .list(receive: true),
                              status: .approved)
        case .receiveDetail2:
            openReceiveDetail(id: info.keys?.id ?? "",
                              moveFrom: .list(receive: true),
                              status: .applied,
                              hasCard: true)
        case .receiveDetail3:
            openReceiveDetail(id: info.keys?.id ?? "",
                              moveFrom: .list(receive: true),
                              status: .applied,
                              hasCard: false)
        case .receiveDetail5:
            openReceiveDetail(id: info.keys?.id ?? "", moveFrom: .list(receive: true),
                              status: .approving)
        case .receiveCancelDetail, .receiveCancelDetail5:
            openReceiveDetail(id: info.keys?.id, moveFrom: .list(receive: false))
        case .receiveDoneDetail, .receiveDoneDetail2:
            openReceiveDetail(id: info.keys?.id, moveFrom: .done)
        case .payApproval:
            openSubmitApproval(id: info.keys?.id)
        case .payApprovalList:
            openPayApprovalList()
        case .payDetail:
            openPayDetail(id: info.keys?.id?.int ?? 0, type: .deadlineExpired)
        case .payDetail1:
            openPayDetail(id: info.keys?.id?.int ?? 0, type: .deadlineExpired)
        case .payDetail2:
            openPayDetail(id: info.keys?.id?.int ?? 0, type: .deadlineComing)
        case .payDetail3:
            openPayDetail(id: info.keys?.id?.int ?? 0, type: .insufficientPayment)
        case .payDetail4:
            openPayDetail(id: info.keys?.id?.int ?? 0, type: .none)
        case .payCancelDetail, .payCancelDetail4, .payCancelDetail5:
            openCancelApprovalDetail(id: info.keys?.id?.int)
        case .payDoneDetail:
            openPayDoneDetail(id: info.keys?.id)
        case .insuranceTop:
            openInsuranceTop()
        default:
            loudPushForMessageTab(info: info)
        }
    }

    func loudPushForMessageTab(info: NotificationInfo) {
        switch info.page {
        case .pairChatRoom:
            handlePairChatRoom(info: info)
        case .evaluationCreatePromote:
            if let id = info.keys?.id {
                let vc = CreateEvalutionViewController(navigateMethod: .modal)
                vc.viewModel = CreateEvalutionViewModel(userID: id)
                let rootVC = AppDelegate.shared.changeRoot(type: .tabBar(item: .connect))
                rootVC.present(vc, animated: true, completion: nil)
            } else if let ids = info.keys?.userIds {
                let vc = PromoteListViewController(navigateMethod: .modal)
                let vm = PromoteListViewModel(userIDs: ids)
                if let days = info.keys?.days {
                    vm.days = days
                } else if let count = info.keys?.count {
                    vm.count = count.string
                }
                vc.viewModel = vm
                let navi = NavigationController(rootViewController: vc)
                let rootVC = AppDelegate.shared.changeRoot(type: .tabBar(item: .connect))
                rootVC.present(navi, animated: true, completion: nil)
            } else {
                AppDelegate.shared.changeRoot(type: .tabBar(item: .connect))
            }
        case .evaluationTestimonial:
            if let id = info.keys?.id {
                let vc = CreateTestimonialViewController(navigateMethod: .modal)
                vc.viewModel = CreateEvalutionViewModel(userID: id)
                let rootVC = AppDelegate.shared.changeRoot(type: .tabBar(item: .connect))
                rootVC.present(vc, animated: true, completion: nil)
            } else if let ids = info.keys?.userIds {
                let vc = PromoteListViewController(navigateMethod: .modal)
                vc.viewModel = PromoteListViewModel(userIDs: ids)
                let navi = NavigationController(rootViewController: vc)
                let rootVC = AppDelegate.shared.changeRoot(type: .tabBar(item: .connect))
                rootVC.present(navi, animated: true, completion: nil)
            } else {
                AppDelegate.shared.changeRoot(type: .tabBar(item: .connect))
            }
        case .siteDetailClose:
            guard let id = info.keys?.id else {
                AppDelegate.shared.changeRoot(type: .tabBar(item: .connect))
                return
            }
            let vc = MySiteDetailViewController(navigateMethod: .modal)
            vc.viewModel = MySiteDetailViewModel(genbaId: id, isHiddenApplicantButton: false)
            let navi = NavigationController(rootViewController: vc)
            let rootVC = AppDelegate.shared.changeRoot(type: .tabBar(item: .connect))
            rootVC.present(navi, animated: true, completion: nil)
        case .evaluationMessage:
            guard let id = info.keys?.id else {
                AppDelegate.shared.changeRoot(type: .tabBar(item: .connect))
                return
            }
            let vc = EvaluationMsgDetailVC()
            vc.viewModel = EvaluationMsgDetailVM(personIDBeCommented: session.userNew.id,
                                                 personIDComment: id)
            AppDelegate.shared.changeRoot(type: .tabBar(item: .connect), pushTo: vc)
        case .userDetail:
            guard let id = info.keys?.id else {
                AppDelegate.shared.changeRoot(type: .tabBar(item: .connect))
                return
            }
            let vc = ProfileDetailViewController()
            vc.viewModel = ProfileDetailViewModel(id: id)
            AppDelegate.shared.changeRoot(type: .tabBar(item: .connect), pushTo: vc)
        default:
            AppDelegate.shared.changeRoot(type: .tabBar(item: .connect))
        }
    }
    
    private func handlePairChatRoom(info: NotificationInfo) {
        if let chatRoomId = info.keys?.chatPairRoomId, let lastMessageID = info.keys?.lastMessageId {
            if info.notificationType == "message_received" {
                // Goto repair with type is `message_received`
                let vc = MessageRepairDetailVC()
                vc.viewModel = MessageRepairDetailVM(roomId: chatRoomId.toString(),
                                                     lastMessageID: lastMessageID.toString())
                AppDelegate.shared.changeRoot(type: .tabBar(item: .message), pushTo: vc)
            } else if let id = info.keys?.id {
                if chatRoomId == -1 || lastMessageID == -1 {
                    AppDelegate.shared.createRoom(friendID: id)
                } else {
                    let vc = MessageDetailViewController()
                    vc.viewModel = MessageDetailViewModel(roomID: chatRoomId.toString(),
                                                          lastMessageID: lastMessageID.toString(),
                                                          chatType: .pairs)
                    AppDelegate.shared.changeRoot(type: .tabBar(item: .message), pushTo: vc)
                }
            } else {
                AppDelegate.shared.changeRoot(type: .tabBar(item: .message))
            }
        } else if let id = info.keys?.id {
            AppDelegate.shared.createRoom(friendID: id)
        } else {
            AppDelegate.shared.changeRoot(type: .tabBar(item: .message))
        }
    }
    
    @discardableResult
    private func moveToPayTab(pushTo controller: ViewController? = nil) -> UIViewController {
        return AppDelegate.shared.changeRoot(type: .tabBar(item: .pay), pushTo: controller)
    }
}

// MARK: - Direction screen
extension PushNotificationManager {
    
    private func openCardTop() {
        let vc = CardTopViewController()
        vc.viewModel = CardTopViewModel(cardStatus: nil, frontOfCard: true)
        moveToPayTab(pushTo: vc)
    }
    
    private func openReceiveDetail(id: String?,
                                   moveFrom: ReceiveDetailViewController.MoveFrom,
                                   status: PayApplicationStatus? = nil,
                                   hasCard: Bool? = nil) {
        if let id = id {
            let vc = ReceiveDetailViewController(moveFrom: moveFrom)
            let vm = ReceiveDetailViewModel(id: id, status: status, hasCard: hasCard)
            vc.viewModel = vm
            moveToPayTab(pushTo: vc)
        } else {
            moveToPayTab()
        }
    }
    
    private func openPayDoneDetail(id: String?) {
        if let id = id {
            let vc = PayDoneDetailVC()
            vc.viewModel = PayDoneDetailViewModel(id: id)
            moveToPayTab(pushTo: vc)
        } else {
            moveToPayTab()
        }
    }
    
    private func openInsuranceTop() {
        let vc = InsuranceTopViewController()
        AppDelegate.shared.changeRoot(type: .tabBar(item: .moreTop), pushTo: vc)
    }
    
    private func openCancelApprovalDetail(id: Int?) {
        if let id = id {
            let vc = ApprovalCancelDetailVC()
            vc.viewModel = ApprovalCancelDetailViewModel(id: id)
            moveToPayTab(pushTo: vc)
        } else {
            moveToPayTab()
        }
    }
    
    private func openPayDetail(id: Int?, type: InvoiceTypes) {
        if let id = id {
            let vc = PayDetailViewController()
            let invoice = Invoice()
            invoice.id = id
            let vm = PayDetailViewModel(invoice: invoice, type: type)
            vc.viewModel = vm
            moveToPayTab(pushTo: vc)
        } else {
            moveToPayTab()
        }
    }
    
    private func openSubmitApproval(id: String?) {
        if let id = id {
            let rootVC = moveToPayTab()
            let vc = SubmitApprovalVC(navigateMethod: .modal)
            vc.viewModel = SubmitApprovalViewModel(id: id)
            rootVC.present(vc, animated: true, completion: nil)
        } else {
            moveToPayTab()
        }
    }
    
    private func openPayApprovalList() {
        DataRefreshControl.shared.needCreatePay = true
        guard let tabbar = AppDelegate.shared.tabBarRootVC else {
            AppDelegate.shared.changeRoot(type: .tabBar(item: .pay))
            return
        }
        tabbar.changeTab(tab: .pay)
        tabbar.payTopVC.refreshData()
    }
}

// MARK: - Silient Push
extension PushNotificationManager {

    func silientPush(type: PushNotificationPage, userInfo: [AnyHashable: Any]) {
        switch type {
        case .messagePair, .messageGroup:
            if userInfo["message"] != nil {
                BadgeManager.shared.badgeForMessage += 1
            }
            NotificationCenter.default.post(name: .newIncomingMessage,
                                            object: self,
                                            userInfo: userInfo)
        case .sukekun:
            guard let sdkunmess = userInfo["sd_kun_mess"] as? String, let id = Int(sdkunmess) else { return }
            Session.shared.addMessageSukekun(number: id)
            BadgeManager.shared.badgeForMessage += 1
            NotificationCenter.default.post(name: .newIncomingMessage,
                                            object: self,
                                            userInfo: userInfo)
        case .banSukePay:
            guard let data = userInfo["data"] as? String, let isBanSukePay = data.bool else { return }
            Session.shared.userNew.isBanSukePay = isBanSukePay
        case .purchase:
            guard let paid = userInfo["paid_user"] as? Int else { return }
            Session.shared.userNew.planType = paid.boolValue ? .pro : .free
        case .pairChatRoom, .receiveDetail, .receiveDetail1, .receiveDetail2, .receiveDetail3, .receiveDetail5,
             .receiveCancelDetail, .receiveCancelDetail5, .receiveDoneDetail, .receiveDoneDetail2, .payApproval,
             .payApprovalList, .payDetail, .payDetail1, .payDetail2, .payDetail3, .payDetail4, .payCancelDetail,
             .payCancelDetail4, .payCancelDetail5, .payDoneDetail:
            BadgeManager.shared.badgeForMessage += 1
            NotificationCenter.default.post(name: .newMessage, object: self, userInfo: userInfo)
        case .friendPostGenba, .userDetail:
            Session.shared.canShowBadgeForMylist = true
        default: break
        }
    }
}

// MARK: - Notification type
enum PushNotificationPage: String {
    case sdpay = "new_sdpay"
    case banSukePay = "ban_flag"
    case purchase = "paidUser"
    // Trường hợp có message pair gửi đến
    case messagePair = "message"
    // Trường hợp có message group gửi đến
    case messageGroup = "message_group"
    // Trường hợp có genba mới ứng với area-job đối tượng được post lên
    case postNewGenba = "post_new_genba"

    /// mypage notification
    // Trường hợp đã được like（mình ko like người kia）
    case friendLike = "friend_is_liked"
    // Trường hợp đã được like（mình cũng like người kia）
    case friendMatch = "friend_both_liked"
    // Trường hợp người mà mình ấn like có post genba
    case friendPostGenba = "friend_post_genba"
    // Trường hợp có người ứng tuyển vào genba mình đã post
    case applyGenba = "application"
    // update notification friend schedule
    case userDetail = "user_detail"
    // genba evaluation
    case genbaEnd = "genba_end"
    // Notfication gửi từ phía Sukedachi
    case system = "system"

    case sukekun = "sd_kun_mess"

    // Pay top
    case insuranceTop = "insurance_top"
    case cardTop = "card_top"
    case receiveDetail = "receive_detail"
    case receiveDetail1 = "receive_detail1"
    case receiveDetail2 = "receive_detail2"
    case receiveDetail3 = "receive_detail3"
    case receiveDetail5 = "receive_detail5"
    case receiveDoneDetail = "receive_done_detail"
    case receiveDoneDetail2 = "receive_done_detail2"
    case receiveCancelDetail = "receive_cancel_detail"
    case receiveCancelDetail5 = "receive_cancel_detail5"
    case payApproval = "pay_approval"
    case payApprovalList = "pay_approval_list"
    case payDetail = "pay_detail"
    case payDetail1 = "pay_payDetail-1"
    case payDetail2 = "pay_payDetail-2"
    case payDetail3 = "pay_payDetail-3"
    case payDetail4 = "pay_payDetail-4"
    case payCancelDetail = "pay_cancel_detail"
    case payCancelDetail4 = "pay_cancel_detail4"
    case payCancelDetail5 = "pay_cancel_detail5"
    case payDoneDetail = "pay_done_detail"
    case pairChatRoom = "pair_chat_room"

    case evaluationCreatePromote = "evaluation" // evaluation_create, evaluation_promote_list
    case evaluationTestimonial = "evaluation_testimonial"
    case siteDetailClose = "site_detail_close"
    case evaluationMessage = "connect_detail_evaluation_message_detail"
    case none
}
