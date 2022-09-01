//
//  UICollectionView+Combine.swift
//  CombineCocoa
//
//  Created by Joan Disho on 05/04/20.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit) && !(os(iOS) && (arch(i386) || arch(arm)))
import Foundation
import UIKit
import Combine

// swiftlint:disable force_cast
@available(iOS 13.0, *)
public extension UICollectionView {
   /// Combine wrapper for `collectionView(_:didSelectItemAt:)`
    var didSelectItemPublisher: AnyPublisher<IndexPath, Never> {
        guard let delegateProxy = innerDelegateWrap?.proxy else {
            return Empty<IndexPath, Never>(completeImmediately: false)
                .eraseToAnyPublisher()
        }
        
        let selector = #selector(UICollectionViewDelegate.collectionView(_:didSelectItemAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didDeselectItemAt:)`
    var didDeselectItemPublisher: AnyPublisher<IndexPath, Never> {
        guard let delegateProxy = innerDelegateWrap?.proxy else {
            return Empty<IndexPath, Never>(completeImmediately: false)
                .eraseToAnyPublisher()
        }
        
        let selector = #selector(UICollectionViewDelegate.collectionView(_:didDeselectItemAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didHighlightItemAt:)`
    var didHighlightItemPublisher: AnyPublisher<IndexPath, Never> {
        guard let delegateProxy = innerDelegateWrap?.proxy else {
            return Empty<IndexPath, Never>(completeImmediately: false)
                .eraseToAnyPublisher()
        }
        
        let selector = #selector(UICollectionViewDelegate.collectionView(_:didHighlightItemAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didUnhighlightItemAt:)`
    var didUnhighlightRowPublisher: AnyPublisher<IndexPath, Never> {
        guard let delegateProxy = innerDelegateWrap?.proxy else {
            return Empty<IndexPath, Never>(completeImmediately: false)
                .eraseToAnyPublisher()
        }
        
        let selector = #selector(UICollectionViewDelegate.collectionView(_:didUnhighlightItemAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:willDisplay:forItemAt:)`
    var willDisplayCellPublisher: AnyPublisher<(cell: UICollectionViewCell, indexPath: IndexPath), Never> {
        guard let delegateProxy = innerDelegateWrap?.proxy else {
            return Empty<(cell: UICollectionViewCell, indexPath: IndexPath), Never>(completeImmediately: false)
                .eraseToAnyPublisher()
        }
        
        let selector = #selector(UICollectionViewDelegate.collectionView(_:willDisplay:forItemAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UICollectionViewCell, $0[2] as! IndexPath) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:willDisplaySupplementaryView:forElementKind:at:)`
    var willDisplaySupplementaryViewPublisher: AnyPublisher<(supplementaryView: UICollectionReusableView, elementKind: String, indexPath: IndexPath), Never> {
        guard let delegateProxy = innerDelegateWrap?.proxy else {
            return Empty<(supplementaryView: UICollectionReusableView, elementKind: String, indexPath: IndexPath), Never>(completeImmediately: false)
                .eraseToAnyPublisher()
        }
        
        let selector = #selector(UICollectionViewDelegate.collectionView(_:willDisplaySupplementaryView:forElementKind:at:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UICollectionReusableView, $0[2] as! String, $0[3] as! IndexPath) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didEndDisplaying:forItemAt:)`
    var didEndDisplayingCellPublisher: AnyPublisher<(cell: UICollectionViewCell, indexPath: IndexPath), Never> {
        guard let delegateProxy = innerDelegateWrap?.proxy else {
            return Empty<(cell: UICollectionViewCell, indexPath: IndexPath), Never>(completeImmediately: false)
                .eraseToAnyPublisher()
        }
        
        let selector = #selector(UICollectionViewDelegate.collectionView(_:didEndDisplaying:forItemAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UICollectionViewCell, $0[2] as! IndexPath) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didEndDisplayingSupplementaryView:forElementKind:at:)`
    var didEndDisplaySupplementaryViewPublisher: AnyPublisher<(supplementaryView: UICollectionReusableView, elementKind: String, indexPath: IndexPath), Never> {
        guard let delegateProxy = innerDelegateWrap?.proxy else {
            return Empty<(supplementaryView: UICollectionReusableView, elementKind: String, indexPath: IndexPath), Never>(completeImmediately: false)
                .eraseToAnyPublisher()
        }
        
        let selector = #selector(UICollectionViewDelegate.collectionView(_:didEndDisplayingSupplementaryView:forElementOfKind:at:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UICollectionReusableView, $0[2] as! String, $0[3] as! IndexPath) }
            .eraseToAnyPublisher()
    }
    
    @discardableResult
    func setCellSize(_ callback: @escaping (_ indexPath: IndexPath) -> CGSize) -> Self {
        innerDelegateWrap?.proxy?.cellSizeCallback = callback
        return self
    }
    
    @discardableResult
    func setInset(_ callback: @escaping (_ section: Int) -> UIEdgeInsets) -> Self {
        innerDelegateWrap?.proxy?.insetCallback = callback
        return self
    }
    
    @discardableResult
    func setMinimumLineSpacing(_ callback: @escaping (_ section: Int) -> CGFloat) -> Self {
        innerDelegateWrap?.proxy?.minimumLineSpacingCallback = callback
        return self
    }
    
    @discardableResult
    func setMinimumInteritemSpacing(_ callback: @escaping (_ section: Int) -> CGFloat) -> Self {
        innerDelegateWrap?.proxy?.minimumInteritemSpacingCallback = callback
        return self
    }
    
    @discardableResult
    func setHeaderSize(_ callback: @escaping (_ section: Int) -> CGSize) -> Self {
        innerDelegateWrap?.proxy?.headerSizeCallback = callback
        return self
    }
    
    @discardableResult
    func setFooterSize(_ callback: @escaping (_ section: Int) -> CGSize) -> Self {
        innerDelegateWrap?.proxy?.footerSizeCallback = callback
        return self
    }

    func useInnerDelegate() {
        innerDelegateWrap = .init()
        innerDelegateWrap?.proxy = CollectionViewDelegateProxy.createDelegateProxy(for: self)
    }
    
    func removeInnerDelegate() {
        innerDelegateWrap = nil
    }
    
    static var innerDelegateWrapKey: Void?
    private var innerDelegateWrap: CollectionViewDelegateWrap? {
        get { objc_getAssociatedObject(self, &UICollectionView.innerDelegateWrapKey) as? CollectionViewDelegateWrap }
        set { objc_setAssociatedObject(self, &UICollectionView.innerDelegateWrapKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
}

@available(iOS 13.0, *)
fileprivate class CollectionViewDelegateWrap {

    weak var proxy: CollectionViewDelegateProxy?
    
}

@available(iOS 13.0, *)
private class CollectionViewDelegateProxy: DelegateProxy, UICollectionViewDelegateFlowLayout, DelegateProxyType {
    func setDelegate(to object: UICollectionView) {
        object.delegate = self
    }
    
    var cellSizeCallback: (_ indexPath: IndexPath) -> CGSize = { _ in CGSize(width: 0.1, height: 0.1) }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellSizeCallback(indexPath)
    }

    var insetCallback: (_ section: Int) -> UIEdgeInsets = { _ in .zero }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        insetCallback(section)
    }

    var minimumLineSpacingCallback: (_ section: Int) -> CGFloat = { _ in 0 }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        minimumLineSpacingCallback(section)
    }

    var minimumInteritemSpacingCallback: (_ section: Int) -> CGFloat = { _ in 0 }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        minimumInteritemSpacingCallback(section)
    }

    var headerSizeCallback: (_ section: Int) -> CGSize = { _ in CGSize(width: 0.1, height: 0.1) }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        headerSizeCallback(section)
    }

    var footerSizeCallback: (_ section: Int) -> CGSize = { _ in CGSize(width: 0.1, height: 0.1) }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        footerSizeCallback(section)
    }
}
#endif
// swiftlint:enable force_cast
