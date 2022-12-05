//
//  NibWrapped.swift
//  StarWars-iOS
//
//  Created by Yawar Valeriano on 2/12/22.
//

import UIKit

@propertyWrapper public struct NibWrapped<T: UIView> {

    public init(_ type: T.Type) { }

    public var wrappedValue: UIView!

    public var unwrapped: T { (wrappedValue as! NibWrapperView<T>).contentView } // swiftlint:disable:this force_cast
}
