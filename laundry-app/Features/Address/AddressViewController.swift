import UIKit

final class AddressViewController: UIViewController, ViewCodeProtocol, UITextFieldDelegate {
    
    private lazy var progress: ProgressBar = {
        let progressBar = ProgressBar()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    private lazy var labelAddress: UILabel = {
        let label = UILabel()
        label.text = "Preencha o endereço onde deseja que a coleta seja realizada"
        label.font = Fonts.title3
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dividerLine: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray4
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let cepComponent: AddressComponent = {
        let c = AddressComponent()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    private let logradouroComponent: AddressComponent = {
        let c = AddressComponent()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    private let cidadeComponent: AddressComponent = {
        let c = AddressComponent()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    private let numberComponent: AddressComponent = {
        let c = AddressComponent()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    private let complementComponent: AddressComponent = {
        let c = AddressComponent()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private lazy var button: GradientButton = {
        let btn = GradientButton()
        btn.title = "Próximo"
        btn.isShowingIcon = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isActive = false
        btn.addTarget(self, action: #selector(goToPaymentVC), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Endereço"
        view.backgroundColor = .systemBackground
        navigationItem.backButtonTitle = "Voltar"
        setup()
        configureFields()
        setupFieldListeners()
        updateButtonState()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField == cepComponent.textField,
              let cepText = cepComponent.text, !cepText.isEmpty else {
            updateButtonState()
            return
        }
        CEPService.fetchAddress(by: cepText) { [weak self] json in
            guard let self = self, let data = json else { return }
            DispatchQueue.main.async {
                if let log = data["logradouro"] as? String {
                    self.logradouroComponent.textField.text = log
                }
                if let city = data["localidade"] as? String {
                    self.cidadeComponent.textField.text = city
                }
                self.updateButtonState()
            }
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        updateButtonState()
    }
    
    private func updateButtonState() {
        let cepFilled        = !(cepComponent.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let logradouroFilled = !(logradouroComponent.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let cidadeFilled     = !(cidadeComponent.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let numberFilled     = !(numberComponent.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        button.isActive = cepFilled && logradouroFilled && cidadeFilled && numberFilled
    }
    
    private func setupFieldListeners() {
        [cepComponent,
         logradouroComponent,
         cidadeComponent,
         numberComponent].forEach {
            $0.textField.delegate = self
            $0.textField.addTarget(self,
                                   action: #selector(textFieldDidChange(_:)),
                                   for: .editingChanged)
        }
    }
    
    private func configureFields() {
        cepComponent.configure(label: "CEP", placeholder: "00000-000")
        logradouroComponent.configure(label: "Logradouro", placeholder: "Rua, Av…")
        cidadeComponent.configure(label: "Cidade", placeholder: "Cidade")
        numberComponent.configure(label: "Número", placeholder: "000")
        complementComponent.configure(label: "Complemento (opcional)", placeholder: "Apto, Bloco…")
        
        cepComponent.textField.keyboardType    = .numberPad
        numberComponent.textField.keyboardType = .numberPad
        
        [logradouroComponent, cidadeComponent].forEach {
            $0.textField.isEnabled = false
        }
    }
    
    @objc private func goToPaymentVC() {
        let cep        = cepComponent.text ?? ""
        let logradouro = logradouroComponent.textField.text ?? ""
        let cidade     = cidadeComponent.textField.text ?? ""
        let numero     = numberComponent.text ?? ""
        let compl      = complementComponent.text ?? ""
        let fullAddress = """
        CEP: \(cep)
        \(cidade)
        \(logradouro), \(numero)
        \(compl.isEmpty ? "" : "\(compl)")
        """
        OrderFlowViewModel.shared.pickupAddress = fullAddress
        let paymentVC = PaymentMethodViewController()
        navigationController?.pushViewController(paymentVC, animated: true)
    }
    
    func avançouParaPasso(_ passo: Int) {
        progress.setStep(passo, animated: true)
    }
    
    func addSubViews() {
        [
            dividerLine, labelAddress,
            cepComponent, logradouroComponent,
            cidadeComponent, numberComponent,
            complementComponent, button, progress
        ].forEach(view.addSubview)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dividerLine.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dividerLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            labelAddress.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 16),
            labelAddress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            labelAddress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            progress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            progress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            progress.heightAnchor.constraint(equalToConstant: 4),
            
            cepComponent.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 16),
            cepComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cepComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            logradouroComponent.topAnchor.constraint(equalTo: cepComponent.bottomAnchor, constant: 16),
            logradouroComponent.leadingAnchor.constraint(equalTo: cepComponent.leadingAnchor),
            logradouroComponent.trailingAnchor.constraint(equalTo: cepComponent.trailingAnchor),
            
            cidadeComponent.topAnchor.constraint(equalTo: logradouroComponent.bottomAnchor, constant: 16),
            cidadeComponent.leadingAnchor.constraint(equalTo: cepComponent.leadingAnchor),
            cidadeComponent.trailingAnchor.constraint(equalTo: cepComponent.trailingAnchor),
            
            numberComponent.topAnchor.constraint(equalTo: cidadeComponent.bottomAnchor, constant: 16),
            numberComponent.leadingAnchor.constraint(equalTo: cepComponent.leadingAnchor),
            numberComponent.trailingAnchor.constraint(equalTo: cepComponent.trailingAnchor),
            
            complementComponent.topAnchor.constraint(equalTo: numberComponent.bottomAnchor, constant: 16),
            complementComponent.leadingAnchor.constraint(equalTo: cepComponent.leadingAnchor),
            complementComponent.trailingAnchor.constraint(equalTo: cepComponent.trailingAnchor),
            
            button.leadingAnchor.constraint(equalTo: cepComponent.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: cepComponent.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 56)
        ])
        progress.numberOfSteps = 4
        progress.setStep(2, animated: false)
    }
}

