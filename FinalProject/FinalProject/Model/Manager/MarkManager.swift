//
//  MarkManager.swift
//  Sukedachi
//
//  Created by Son Vu L. L. on 6/17/19.
//  Copyright © 2019 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

enum MarkType: String, Codable {

    // Connect
    case coachmarkDraft1
    case coachmarkMyList2
    case coachmarkMyList3
    case coachmarkDetail1
    case coachmarkDetail2
    case coachmarkDetail3
    case coachmark10
    case coachmark16
    case coachmarkDetail5
    case coachmarkDetail6
    case coachmarkDetail7

    // Site
    case coachmark2
    case coachmark3
    case coachmark4

    // Message
    case coachmarkMessage1
    case coachmarkMessage3
    case coachmarkMessage2

    // MyPage
    case coachmarkPage1
    case coachmarkPage2
    case coachmarkPage3
    case coachmarkPage4
    case coachmark14
    case coachmark15
    case coachmarkPageEnterprise1
    case coachmarkPageEnterprise2
    
    //Message repair
    case coachmark17 // Rename when have real number of this coachmark

    // More
    case coachmarkMore1

    case none
}

enum ScreenType {

    // Connect
    case connectDetail
    case connectList
    case myList

    // Site
    case siteList

    // Message
    case messageList

    // MyPage
    case myPageTop

    // More
    case more
}

final class MarkManager {

    var isCloseCoachmarkMessage1: Bool {
        get {
            return Defaults[.isCloseCoachmarkMessage1]
        } set {
            Defaults[.isCloseCoachmarkMessage1] = newValue
        }
    }

    private var markDidShow: UserMarked? {
        get {
            return Defaults[.usersMarked]
        } set {
            Defaults[.usersMarked] = newValue
        }
    }

    var showedMarks: [MarkType] = [] {
        didSet {
            let id = Session.shared.userNew.id
            let userMarked = UserMarked(id: id, showedMark: showedMarks)
            markDidShow = userMarked
        }
    }

    private init() {
        updateMarks()
    }

    static let shared = MarkManager()
    
    func updateMarks() {
        if let mark = markDidShow, mark.id.elementsEqual(Session.shared.userNew.id) {
            showedMarks = mark.showedMark
        } else {
            showedMarks = []
        }
    }

    @discardableResult
    func getMark(_ screenType: ScreenType,
                 updateMark: Bool = true,
                 updateMarkView: Bool = false,
                 hasCommented: Bool = false,
                 hasMyList: Bool = false,
                 isBeforeStore: Bool = false) -> MarkType {
        var type: MarkType = .none
        switch screenType {
        case .connectDetail:
            type = getProfileDetailMark(hasCommented: hasCommented)
        case .connectList:
            type = getConnectListMark()
        case .myList:
            if !showedMarks.contains(.coachmarkMyList2) {
                type = .coachmarkMyList2
            } else if !showedMarks.contains(.coachmarkMyList3) {
                type = .coachmarkMyList3
            }
        case .messageList:
            if !showedMarks.contains(.coachmarkMessage1) {
                type = .coachmarkMessage1
            } else if !showedMarks.contains(.coachmarkMessage3) && updateMarkView {
                type = .coachmarkMessage3
            } else if showedMarks.contains(.coachmarkDetail2) && !showedMarks.contains(.coachmarkMessage2) && hasMyList {
                type = .coachmarkMessage2
            }
        case .siteList:
            type = getSiteListMark()
        case .myPageTop:
            type = getMyPageMark()
        case .more:
            if !showedMarks.contains(.coachmarkMore1) {
                type = .coachmarkMore1
            }
        }
        if type != .none && updateMark {
            showedMarks.append(type)
        }
        return type
    }

    private func getProfileDetailMark(hasCommented: Bool) -> MarkType {
        if !showedMarks.contains(.coachmarkDetail1) {
            return .coachmarkDetail1
        } else if !showedMarks.contains(.coachmarkDetail2) {
            return .coachmarkDetail2
        } else if !showedMarks.contains(.coachmarkDetail3) &&
            Session.shared.userNew.role != .free &&
            Session.shared.userNew.role != .pro {
            return .coachmarkDetail3
        } else if !showedMarks.contains(.coachmarkDetail5) {
            return .coachmarkDetail5
        } else if !showedMarks.contains(.coachmarkDetail6) && !hasCommented {
            return .coachmarkDetail6
        } else if !showedMarks.contains(.coachmarkDetail7) {
            return .coachmarkDetail7
        }
        return .none
    }

    private func getConnectListMark() -> MarkType {
        if showedMarks.isEmpty && !showedMarks.contains(.coachmarkDraft1) {
            return .coachmarkDraft1
        } else if showedMarks.contains([.coachmarkDetail7]) && Session.shared.userNew.role != .free && !showedMarks.contains(.coachmark16) {
            return .coachmark16
        }
        return .none
    }

    private func getSiteListMark() -> MarkType {
        switch Session.shared.userNew.purposeUsingApp {
        case .receive:
            if !showedMarks.contains(.coachmark2), !showedMarks.contains(.coachmark3), !showedMarks.contains(.coachmark4) {
                return .coachmark2
            }
        case .send:
            if !showedMarks.contains(.coachmark2), !showedMarks.contains(.coachmark3), !showedMarks.contains(.coachmark4) {
                return .coachmark3
            }
        case .all:
            if !showedMarks.contains(.coachmark2), !showedMarks.contains(.coachmark3), !showedMarks.contains(.coachmark4) {
                return .coachmark4
            }
        case .none:
            return .none
        }
        return .none
    }

    private func getMyPageMark() -> MarkType {
        if !showedMarks.contains(.coachmarkPage1) {
            return .coachmarkPage1
        } else if showedMarks.contains(.coachmarkPage1) && !showedMarks.contains(.coachmarkPage2) {
            return .coachmarkPage2
        } else if showedMarks.contains(.coachmarkPage2) {
            switch Session.shared.userNew.purposeUsingApp {
            case .receive:
                if !showedMarks.contains(.coachmarkPage3) &&
                    !showedMarks.contains(.coachmarkPage4) &&
                    !showedMarks.contains(.coachmark14) {
                    return .coachmarkPage3
                } else if (Session.shared.userNew.role != .free && Session.shared.userNew.role != .pro) &&
                    showedMarks.contains(.coachmarkPage3) &&
                    !showedMarks.contains(.coachmarkPageEnterprise1) {
                    return .coachmarkPageEnterprise1
                } else if (Session.shared.userNew.role == .enterprise || Session.shared.userNew.role == .enterpriseCorp) &&
                    showedMarks.contains(.coachmarkPageEnterprise1) &&
                    !showedMarks.contains(.coachmarkPageEnterprise2) {
                    return .coachmarkPageEnterprise2
                }
            case .send:
                if !showedMarks.contains(.coachmarkPage3) &&
                    !showedMarks.contains(.coachmarkPage4) &&
                    !showedMarks.contains(.coachmark15) {
                    return .coachmarkPage4
                } else if (Session.shared.userNew.role != .free && Session.shared.userNew.role != .pro) &&
                    showedMarks.contains(.coachmarkPage4) &&
                    !showedMarks.contains(.coachmarkPageEnterprise1) {
                    return .coachmarkPageEnterprise1
                } else if (Session.shared.userNew.role == .enterprise || Session.shared.userNew.role == .enterpriseCorp) &&
                    showedMarks.contains(.coachmarkPageEnterprise1) &&
                    !showedMarks.contains(.coachmarkPageEnterprise2) {
                    return .coachmarkPageEnterprise2
                }
            case .all:
                if !showedMarks.contains(.coachmarkPage3) &&
                    !showedMarks.contains(.coachmarkPage4) &&
                    !showedMarks.contains(.coachmark14) {
                    return .coachmark14
                } else if Session.shared.userNew.role != .free,
                    !showedMarks.contains(.coachmarkPage3) &&
                        !showedMarks.contains(.coachmarkPage4) &&
                        !showedMarks.contains(.coachmark15) {
                    return .coachmark15
                } else if (Session.shared.userNew.role != .free && Session.shared.userNew.role != .pro) &&
                    showedMarks.contains(.coachmark15) &&
                    !showedMarks.contains(.coachmarkPageEnterprise1) {
                    return .coachmarkPageEnterprise1
                } else if (Session.shared.userNew.role == .enterprise || Session.shared.userNew.role == .enterpriseCorp) &&
                    showedMarks.contains(.coachmarkPageEnterprise1) &&
                    !showedMarks.contains(.coachmarkPageEnterprise2) {
                    return .coachmarkPageEnterprise2
                }
            case .none:
                return .none
            }
        }
        return .none
    }
}
