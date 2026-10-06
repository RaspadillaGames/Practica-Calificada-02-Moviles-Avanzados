import UIKit

class ResultViewController: UIViewController {

    var operationText = ""
    var firstNumber = 0.0
    var secondNumber = 0.0
    var result = 0.0

    // Quita el ".0" si el número es entero (70.0 -> 70)
    func format(_ n: Double) -> String {
        if n == n.rounded() && abs(n) < 1e15 {
            return String(Int(n))
        }
        return String(n)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Result"
        view.backgroundColor = .systemGroupedBackground

        let titleLabel = UILabel()
        titleLabel.text = "Calculation Result"
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center

        let operationLabel = UILabel()
        operationLabel.text = "Operation: \(operationText)"

        let firstLabel = UILabel()
        firstLabel.text = "First Number: \(format(firstNumber))"

        let secondLabel = UILabel()
        secondLabel.text = "Second Number: \(format(secondNumber))"

        let resultTitle = UILabel()
        resultTitle.text = "Result:"
        resultTitle.font = .boldSystemFont(ofSize: 18)
        resultTitle.textColor = .gray

        let resultLabel = UILabel()
        resultLabel.text = format(result)
        resultLabel.font = .boldSystemFont(ofSize: 40)
        resultLabel.textColor = .systemBlue
        resultLabel.textAlignment = .center
        resultLabel.backgroundColor = .secondarySystemGroupedBackground
        resultLabel.layer.cornerRadius = 12
        resultLabel.clipsToBounds = true
        resultLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true

        let shareButton = UIButton(type: .system)
        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.backgroundColor = .systemBlue
        shareButton.layer.cornerRadius = 12
        shareButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)

        let newButton = UIButton(type: .system)
        newButton.setTitle("New Calculation", for: .normal)
        newButton.layer.borderWidth = 2
        newButton.layer.borderColor = UIColor.systemBlue.cgColor
        newButton.layer.cornerRadius = 12
        newButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        newButton.addTarget(self, action: #selector(newCalculation), for: .touchUpInside)

        let buttons = UIStackView(arrangedSubviews: [shareButton, newButton])
        buttons.axis = .horizontal
        buttons.spacing = 12
        buttons.distribution = .fillEqually

        let stack = UIStackView(arrangedSubviews: [titleLabel, operationLabel, firstLabel, secondLabel, resultTitle, resultLabel, buttons])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    @objc func share() {
        let text = "\(format(firstNumber)) \(operationText) \(format(secondNumber)) = \(format(result))"
        let activity = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        present(activity, animated: true)
    }

    @objc func newCalculation() {
        navigationController?.popToRootViewController(animated: true)
    }
}
