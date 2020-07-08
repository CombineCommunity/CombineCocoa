//
//  UITableView+Combine.swift
//  CombineCocoa
//
//  Created by Joan Disho on 19/01/20.
//  Copyright © 2020 Combine Community. All rights reserved.

import Foundation
import UIKit
import Combine

private class TableViewDelegateProxy: DelegateProxy, UITableViewDelegate, DelegateProxyType {
    func setDelegate(to object: UITableView) {
        object.delegate = self
    }
}

extension UITableView {
    private var delegateProxy: TableViewDelegateProxy {
        return .createDelegateProxy(for: self)
    }

    /// Combine wrapper for `tableView(_:willDisplay:forRowAt:)`
    public var willDisplayCellPublisher: AnyPublisher<(cell: UITableViewCell, indexPath: IndexPath), Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:willDisplay:forRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UITableViewCell, $0[2] as! IndexPath) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:willDisplayHeaderView:forSection:)`
    public var willDisplayHeaderViewPublisher: AnyPublisher<(headerView: UIView, section: Int), Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:willDisplayHeaderView:forSection:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UIView, $0[2] as! Int) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:willDisplayFooterView:forSection:)`
    public var willDisplayFooterViewPublisher: AnyPublisher<(footerView: UIView, section: Int), Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:willDisplayFooterView:forSection:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UIView, $0[2] as! Int) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didEndDisplaying:forRowAt:)`
    public var didEndDisplayingCellPublisher: AnyPublisher<(cell: UITableViewCell, indexPath: IndexPath), Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didEndDisplaying:forRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UITableViewCell, $0[2] as! IndexPath) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didEndDisplayingHeaderView:forSection:)`
    public var didEndDisplayingHeaderViewPublisher: AnyPublisher<(headerView: UIView, section: Int), Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didEndDisplayingHeaderView:forSection:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UIView, $0[2] as! Int) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didEndDisplayingFooterView:forSection:)`
    public var didEndDisplayingFooterView: AnyPublisher<(headerView: UIView, section: Int), Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didEndDisplayingFooterView:forSection:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UIView, $0[2] as! Int) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:accessoryButtonTappedForRowWith:)`
    public var itemAccessoryButtonTappedPublisher: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:accessoryButtonTappedForRowWith:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didHighlightRowAt:)`
    public var didHighlightRowPublisher: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didHighlightRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didUnHighlightRowAt:)`
    public var didUnhighlightRowPublisher: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didUnhighlightRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didSelectRowAt:)`
    public var didSelectRowPublisher: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didDeselectRowAt:)`
    public var didDeselectRowPublisher: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didDeselectRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:willBeginEditingRowAt:)`
    public var willBeginEditingRowPublisher: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:willBeginEditingRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didEndEditingRowAt:)`
    public var didEndEditingRowPublisher: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didEndEditingRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }
}
