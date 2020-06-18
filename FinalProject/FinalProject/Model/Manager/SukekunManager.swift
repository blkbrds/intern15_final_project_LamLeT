//
//  SukekunManager.swift
//  Sukedachi
//
//  Created by MBA0237P on 6/5/19.
//  Copyright © 2019 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UserNotifications.UNUserNotificationCenter

final class SukekunManager {

    let sukekunName = "助太刀くん"

    static let shared = SukekunManager()

    private init() { }

    var warnings: [CategoryWarning] {
        guard !Session.shared.userNew.isCorp else { return [] }
        var warnings: [CategoryWarning] = [.initial]
        let listID = Session.shared.listMessageSukekun
        listID.forEach { id in
            if let warning = CategoryWarning(rawValue: id) {
                warnings.append(warning)
            }
        }
        return warnings
    }

    func getMessageRandom(completion: ProcessCompletion?) {
        Api.MessageSukedachiKun.getMessage { result in
            switch result {
            case .success(let messageID):
                Session.shared.addMessageSukekun(number: messageID)
            case .failure: break
            }
            completion?()
        }
    }
}

extension SukekunManager {

    /// CategoryWarning
    ///
    /// - initial: Tất cả mọi người
    /// - info: Trường hợp chưa input 1 trong mấy cái 年齢/tuổi・性別/giới tính・経験年数/số năm kinh nghiệm・国籍/quốc tịch
    /// - appealpoint: Trường hợp chưa input appeal point/アピールポイント
    /// - likeAndSend: Trường hợp chưa từng ấn like và chưa từng gửi message
    /// - sendMessage: Trường hợp đã từng từng ấn like nhưng chưa từng gửi message
    /// - scheduler: Trường hợp đã từng ấn like nhưng chưa từng đăng ký đang trống lịch「空いてます！」 (với đối tượng là người nhận order(worker)/受注者 - người vừa gửi vừa nhận order/受発注
    /// - postGenba: Trường hợp đã từng ấn like nhưng chưa từng post genba（đối tượng là người gửi order(owner)/発注者・người vừa gửi vừa nhận order/受発注者）
    /// - referenceContact: Trường hợp chưa từng liên kết với contact trong điện thoại
    /// - job: Trường hợp mới chỉ đăng ký 1 job
    enum CategoryWarning: Int {
        case info = 1
        case appealpoint
        case likeAndSend
        case sendMessage
        case scheduler
        case postGenba
        case referenceContact
        case job
        case initial

        init?(warningID: String) {
            if let id = Int(warningID), let warning = CategoryWarning(rawValue: id) {
                self = warning
            } else {
                return nil
            }
        }

        var message: String {
            let userName = Session.shared.userNew.label
            guard userName.isNotEmpty else { return "" }
            let message: String
            switch self {
            case .info:
                message = Sukekun.warningInfo
            case .appealpoint:
                message = Sukekun.warningAppealpoint
            case .likeAndSend:
                message = Sukekun.warningSendAndLike
            case .sendMessage:
                message = Sukekun.warningSend
            case .scheduler:
                message = Sukekun.warningRegister
            case .postGenba:
                message = Sukekun.warningGenba
            case .referenceContact:
                message = Sukekun.warningContact
            case .job:
                message = Sukekun.job
            case .initial:
                message = Sukekun.initialMessage
            }

            if let message = message.replace(pattern: "%@", withString: userName) {
                return message
            }
            return message
        }

        var titleAction: String {
            switch self {
            case .info:
                return "さっそく入力する"
            case .appealpoint:
                return "さっそく入力する"
            case .likeAndSend:
                return "さっそく押してみる"
            case .sendMessage:
                return "さっそくやってみる"
            case .scheduler:
                return "さっそくやってみる"
            case .postGenba:
                return "さっそくやってみる"
            case .referenceContact:
                return "さっそくやってみる"
            case .job:
                return "さっそく追加してみる"
            default: return ""
            }
        }
    }

    struct Sukekun {
        static let warningInfo = "%@さん、おつかれさまです！\n\n%@さんのプロフィールに「未入力」の項目があるみたいです。カンタンに入力できるので、やってみましょう！"
        static let warningAppealpoint = "%@さん、おつかれさまです！\n\n%@さんの「アピールポイント」が未入力のようです。アピールポイントを登録すると、新しい職人さんとの出会いが生まれやすくなります！"
        static let warningSendAndLike = "%@さん、おつかれさまです！\n\n%@さん、「興味あり」ボタンは押してみましたか？気になった人に「興味あり」をしておくと、その人が現場を掲載したり、現場を探している時にお知らせが届くようになります！"
        static let warningSend = "%@さん、おつかれさまです！\n\n%@さん、メッセージ機能は使ってみましたか？気になった人にメッセージで自己紹介をしておくと、あとで現場の受発注を打診したい時などにスムーズです！"
        static let warningRegister = "%@さん、おつかれさまです！\n\n%@さん、もし仕事に空きが出たら「助太刀できます！」を登録するのがオススメです。\n\n発注者から現場の打診が来やすくなります！"
        static let warningGenba = "%@さん、おつかれさまです！\n\n%@さん、現場は掲載してみましたか？カンタンに掲載できて、人が募集できるので、ぜひ試してみてください！"
        static let warningContact = "%@さん、おつかれさまです！\n\n%@さん、スマホの「電話帳アプリ」と「助太刀」が連携できるって知ってましたか？\n\n「電話帳アプリ」に登録されている知り合いの中で、助太刀を使っている人がいたら、カンタンに連絡先リストに追加できます！"
        static let job = "%@さん、おつかれさまです！\n\n%@さん、自分の職種は3つまで登録することができます。登録する職種が多いほど、つながりを増やしやすくなります！"
        static let initialMessage = "%@さん、おつかれさまです！\n助太刀の便利な使い方や、%@さんにおすすめの人をここで紹介していきます！\nこれからどうぞよろしくお願いします！"
    }
}
