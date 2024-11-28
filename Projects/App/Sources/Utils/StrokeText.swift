import Foundation
import SwiftUI
import UIKit

struct StrokeText: UIViewRepresentable {
    let text: String
    let strokeColor: UIColor
    let strokeWidth: CGFloat
    
    func makeUIView(context: Context) -> UILabel {
        let label: UILabel = UILabel()
        let attribute: [NSAttributedString.Key: Any] = [
            .strokeColor: strokeColor,
            .strokeWidth: strokeWidth
        ]
        label.attributedText = NSAttributedString(string: text, attributes: attribute)
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        let attribute: [NSAttributedString.Key: Any] = [
            .strokeColor: strokeColor,
            .strokeWidth: strokeWidth
        ]
        uiView.attributedText = NSAttributedString(string: text, attributes: attribute)
        uiView.textAlignment = .center
        uiView.sizeToFit()
    }
}
