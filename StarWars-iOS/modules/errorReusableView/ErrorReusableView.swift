//
//  ErrorReusableView.swift
//  StarWars-iOS
//
//  Created by Yawar Valeriano on 2/12/22.
//

import UIKit

@IBDesignable class ReusableErrorViewWrapper: NibWrapperView<ErrorReusableView> { }

class ErrorReusableView: UIView {

    @IBOutlet private weak var textInfo: UILabel!

    func setLabel(_ text: String) {
        self.textInfo.text = text
    }
}
