//
//  SnapKit
//
//  Copyright (c) 2011-Present SnapKit Team - https://github.com/SnapKit
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif


public extension ConstraintView {
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    var snpLeft: ConstraintItem { return self.snp.left }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    var snpTop: ConstraintItem { return self.snp.top }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    var snpRight: ConstraintItem { return self.snp.right }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    var snpBottom: ConstraintItem { return self.snp.bottom }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    var snpLeading: ConstraintItem { return self.snp.leading }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    var snpTrailing: ConstraintItem { return self.snp.trailing }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    var snpWidth: ConstraintItem { return self.snp.width }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    var snpHeight: ConstraintItem { return self.snp.height }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    var snpCenterX: ConstraintItem { return self.snp.centerX }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    var snpCenterY: ConstraintItem { return self.snp.centerY }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    var snpBaseline: ConstraintItem { return self.snp.baseline }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    @available(iOS 8.0, OSX 10.11, *)
    var snpLastBaseline: ConstraintItem { return self.snp.lastBaseline }
    
    @available(iOS, deprecated, message: "Use newer snp.* syntax.")
    @available(iOS 8.0, OSX 10.11, *)
    var snpFirstBaseline: ConstraintItem { return self.snp.firstBaseline }
    
    @available(iOS, deprecated, message: "Use newer snp.* syntax.")
    @available(iOS 8.0, *)
    var snpLeftMargin: ConstraintItem { return self.snp.leftMargin }
    
    @available(iOS, deprecated, message: "Use newer snp.* syntax.")
    @available(iOS 8.0, *)
    var snpTopMargin: ConstraintItem { return self.snp.topMargin }
    
    @available(iOS, deprecated, message: "Use newer snp.* syntax.")
    @available(iOS 8.0, *)
    var snpRightMargin: ConstraintItem { return self.snp.rightMargin }
    
    @available(iOS, deprecated, message: "Use newer snp.* syntax.")
    @available(iOS 8.0, *)
    var snpBottomMargin: ConstraintItem { return self.snp.bottomMargin }
    
    @available(iOS, deprecated, message: "Use newer snp.* syntax.")
    @available(iOS 8.0, *)
    var snpLeadingMargin: ConstraintItem { return self.snp.leadingMargin }
    
    @available(iOS, deprecated, message: "Use newer snp.* syntax.")
    @available(iOS 8.0, *)
    var snpTrailingMargin: ConstraintItem { return self.snp.trailingMargin }
    
    @available(iOS, deprecated, message: "Use newer snp.* syntax.")
    @available(iOS 8.0, *)
    var snpCenterXWithinMargins: ConstraintItem { return self.snp.centerXWithinMargins }
    
    @available(iOS, deprecated, message: "Use newer snp.* syntax.")
    @available(iOS 8.0, *)
    var snpCenterYWithinMargins: ConstraintItem { return self.snp.centerYWithinMargins }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    var snpEdges: ConstraintItem { return self.snp.edges }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    var snpSize: ConstraintItem { return self.snp.size }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    var snpCenter: ConstraintItem { return self.snp.center }
    
    @available(iOS, deprecated, message: "Use newer snp.* syntax.")
    @available(iOS 8.0, *)
    var snpMargins: ConstraintItem { return self.snp.margins }
    
    @available(iOS, deprecated, message: "Use newer snp.* syntax.")
    @available(iOS 8.0, *)
    var snpCenterWithinMargins: ConstraintItem { return self.snp.centerWithinMargins }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    func snpPrepareConstraints(_ closure: (_ make: ConstraintMaker) -> Void) -> [Constraint] {
        return self.snp.prepareConstraints(closure)
    }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    func snpMakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.snp.makeConstraints(closure)
    }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    func snpRemakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.snp.remakeConstraints(closure)
    }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    func snpUpdateConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.snp.updateConstraints(closure)
    }
    
    @available(*, deprecated, message: "Use newer snp.* syntax.")
    func snp_removeConstraints() {
        self.snp.removeConstraints()
    }
    
    var snp: ConstraintViewDSL {
        return ConstraintViewDSL(view: self)
    }
    
}
