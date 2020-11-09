import UIKit

enum SelectableProductCellState {
    case selected
    case notSelected
}

final class SelectableProductCell: UITableViewCell {
    static var reuseId: String { "SelectableProductCell" }
    private var checkmark: UIImageView
    private var titleLabel: UILabel

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        checkmark = UIImageView(image: UIImage(named: "checkmark-empty"))
        titleLabel = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        checkmark.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(checkmark)
        contentView.addSubview(titleLabel)
        configureLayout()

        selectionStyle = .none
    }
        
    func update(state: SelectableProductCellState, title: String) {
        titleLabel.text = title
        checkmark.image = checkmarkImage(for: state)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            checkmark.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            checkmark.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            checkmark.widthAnchor.constraint(equalToConstant: 22),
            checkmark.heightAnchor.constraint(equalTo: checkmark.widthAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: checkmark.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    private func checkmarkImage(for state: SelectableProductCellState) -> UIImage {
        switch state {
        case .selected:
            return #imageLiteral(resourceName: "checkmark-selected")
        case .notSelected:
            return #imageLiteral(resourceName: "checkmark-empty")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
