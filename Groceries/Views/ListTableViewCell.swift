import UIKit

typealias ListCellUpdateCallback = () -> ()

struct ListTableViewCellStyle {
    let regularColor = UIColor.black
    let selectedColor = UIColor.gray
    let animationDuration = TimeInterval(5)
}

final class ListTableViewCell: UITableViewCell {
    private var style = ListTableViewCellStyle()

    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.attributedText = nil
    }

    func update(with title: String) {
        update(with: title, selected: false, completion: nil)
    }

    func update(with title: String, selected: Bool, completion: ListCellUpdateCallback?) {
        let text = NSAttributedString(string: title,
                                      attributes: selected ? selectedTitleAttributes : titleAttributes)
        let updates = {
            self.textLabel?.attributedText = text
        }

        guard completion != nil else {
            updates()
            return
        }

        UIView.animate(withDuration: style.animationDuration, animations: { updates() }, completion: { _ in completion?() })
    }
}

private extension ListTableViewCell {
    private var selectedTitleAttributes: [NSAttributedString.Key: Any] {
        return [
            .strikethroughStyle: 2,
            .foregroundColor: style.selectedColor
        ]
    }

    private var titleAttributes: [NSAttributedString.Key: Any] {
        return [
            .foregroundColor: style.regularColor
        ]
    }

}
