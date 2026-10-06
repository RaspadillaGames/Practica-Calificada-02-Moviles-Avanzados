import UIKit

class CalculatorViewController: UIViewController {

    let operations = ["Addition (+)", "Subtraction (-)", "Multiplication (×)", "Division (÷)"]
    var selectedOperation = "Addition (+)"

    let firstField = UITextField()
    let secondField = UITextField()
    let operationButton = UIButton(type: .system)
    let calculateButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calculator"
        view.backgroundColor = .systemGroupedBackground

        // Campos de texto
        firstField.placeholder = "First Number"
        secondField.placeholder = "Second Number"
        for field in [firstField, secondField] {
            field.borderStyle = .roundedRect
            field.keyboardType = .decimalPad
            field.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }

        // Botón con menú desplegable (operación)
        operationButton.setTitle(selectedOperation, for: .normal)
        operationButton.contentHorizontalAlignment = .leading
        operationButton.backgroundColor = .secondarySystemGroupedBackground
        operationButton.layer.cornerRadius = 8
        operationButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        operationButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        operationButton.showsMenuAsPrimaryAction = true
        operationButton.menu = UIMenu(children: operations.map { name in
            UIAction(title: name) { _ in
                self.selectedOperation = name
                self.operationButton.setTitle(name, for: .normal)
            }
        })

        // Botón calcular
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.backgroundColor = .systemBlue
        calculateButton.layer.cornerRadius = 12
        calculateButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        calculateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        calculateButton.addTarget(self, action: #selector(calculate), for: .touchUpInside)

        // Stack vertical
        let stack = UIStackView(arrangedSubviews: [firstField, secondField, operationButton, calculateButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Tocar fuera para cerrar el teclado
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    // Limpia los campos al volver (New Calculation)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstField.text = ""
        secondField.text = ""
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @objc func calculate() {
        let text1 = (firstField.text ?? "").replacingOccurrences(of: ",", with: ".")
        let text2 = (secondField.text ?? "").replacingOccurrences(of: ",", with: ".")

        guard let a = Double(text1), let b = Double(text2) else {
            showAlert("Ingresa dos números válidos")
            return
        }

        var result = 0.0
        switch selectedOperation {
        case "Addition (+)":
            result = a + b
        case "Subtraction (-)":
            result = a - b
        case "Multiplication (×)":
            result = a * b
        default:
            if b == 0 {
                showAlert("No se puede dividir entre 0")
                return
            }
            result = a / b
        }

        let resultVC = ResultViewController()
        resultVC.operationText = selectedOperation
        resultVC.firstNumber = a
        resultVC.secondNumber = b
        resultVC.result = result
        navigationController?.pushViewController(resultVC, animated: true)
    }

    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
