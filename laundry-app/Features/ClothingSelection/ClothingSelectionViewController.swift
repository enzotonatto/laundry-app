import UIKit

class ClothingSelectionViewController: UIViewController {
    
    private let progress = StepProgressView()
    
    lazy var returnButton: ReturnButton = {
        let button = ReturnButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var clothingSelector: ClothesCouting = {
        let counter = ClothesCouting()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.title = "Camiseta"
        return counter
    }()
    
    lazy var clothingSelector2: ClothesCouting = {
        let counter = ClothesCouting()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.title = "Casaco"
        counter.imageName = "jacket.fill"
        return counter
    }()
        
    lazy var clothingSelector3: ClothesCouting = {
        let counter = ClothesCouting()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.title = "Terno"
        counter.imageName = "coat.fill"
        return counter
    }()
    
    lazy var clothingSelector4: ClothesCouting = {
        let counter = ClothesCouting()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.title = "Lençol"
        counter.imageName = "bed.double.fill"
        return counter
    }()
    
    lazy var clothingSelector5: ClothesCouting = {
        let counter = ClothesCouting()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.title = "Calça"
        counter.imageName = "pants"
        return counter
    }()
    
    lazy var nextButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Próximo"
        button.isShowingIcon = true
        button.addTarget(self, action: #selector(goToOrderAdressVC), for: .touchUpInside)
        return button
    }()
    
    lazy var dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()
    
    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adicione todas as peças que você deseja lavar:"
        label.numberOfLines = 0
        label.font = Fonts.title2
        label.textColor = .label
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Peças"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        progress.translatesAutoresizingMaskIntoConstraints = false
        
        setup()
        hideKeyboardWhenTappedAround()  
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            navigationController?.setNavigationBarHidden(true, animated: animated)
            
        }
    }
    
    @objc func goToOrderAdressVC() {
        var lines: [String] = []
        
        let camisetaCount = clothingSelector.getCount()
        if camisetaCount > 0 {
            lines.append("Camiseta: \(camisetaCount)")
        }
        let casacoCount = clothingSelector2.getCount()
        if casacoCount > 0 {
            lines.append("Casaco: \(casacoCount)")
        }
        let ternoCount = clothingSelector3.getCount()
        if ternoCount > 0 {
            lines.append("Terno: \(ternoCount)")
        }
        let lencolCount = clothingSelector4.getCount()
        if lencolCount > 0 {
            lines.append("Lençol: \(lencolCount)")
        }
        let calcaCount = clothingSelector5.getCount()
        if calcaCount > 0 {
            lines.append("Calça: \(calcaCount)")
        }
        
        if lines.isEmpty {
            lines.append("Nenhuma peça selecionada")
        }
        
        OrderFlowViewModel.shared.selectedClothes = lines.joined(separator: "\n")
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        let addressVC = AddressViewController()
        navigationController?.pushViewController(addressVC, animated: true)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension ClothingSelectionViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(dividerLine)
        view.addSubview(instructionsLabel)
        view.addSubview(nextButton)
        view.addSubview(clothingSelector)
        view.addSubview(clothingSelector2)
        view.addSubview(clothingSelector3)
        view.addSubview(clothingSelector4)
        view.addSubview(clothingSelector5)
        view.addSubview(progress)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            progress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            progress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            progress.heightAnchor.constraint(equalToConstant: 4),
            
            dividerLine.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dividerLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            instructionsLabel.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 16),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            clothingSelector.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            clothingSelector.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            clothingSelector.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 16),
            
            clothingSelector2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            clothingSelector2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            clothingSelector2.topAnchor.constraint(equalTo: clothingSelector.bottomAnchor, constant: 16),
            
            clothingSelector3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            clothingSelector3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            clothingSelector3.topAnchor.constraint(equalTo: clothingSelector2.bottomAnchor, constant: 16),
            
            clothingSelector4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            clothingSelector4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            clothingSelector4.topAnchor.constraint(equalTo: clothingSelector3.bottomAnchor, constant: 16),
            
            clothingSelector5.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            clothingSelector5.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            clothingSelector5.topAnchor.constraint(equalTo: clothingSelector4.bottomAnchor, constant: 16),
        ])
        progress.numberOfSteps = 4
        progress.setStep(1, animated: false)
      
       
    }
    func avançouParaPasso(_ passo: Int) {
        progress.setStep(passo, animated: true)
      
    
    }
}
