import UIKit

class ClothingSelectionViewController: UIViewController {
    private var clothingSelectors = [ClothesCouting]()

    lazy var returnButton: ReturnButton = {
        let button = ReturnButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var clothingSelector: ClothesCouting = {
        let counter = ClothesCouting()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.title = "Camiseta"
        clothingSelectors.append(counter)
        return counter
    }()

    lazy var clothingSelector2: ClothesCouting = {
        let counter = ClothesCouting()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.title = "Casaco"
        counter.imageName = "jacket.fill"
        clothingSelectors.append(counter)
        return counter
    }()

    lazy var clothingSelector3: ClothesCouting = {
        let counter = ClothesCouting()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.title = "Terno"
        counter.imageName = "coat.fill"
        clothingSelectors.append(counter)
        return counter
    }()

    lazy var clothingSelector4: ClothesCouting = {
        let counter = ClothesCouting()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.title = "Lençol"
        counter.imageName = "bed.double.fill"
        clothingSelectors.append(counter)
        return counter
    }()

    lazy var clothingSelector5: ClothesCouting = {
        let counter = ClothesCouting()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.title = "Calça"
        counter.imageName = "pants"
        clothingSelectors.append(counter)
        return counter
    }()

    lazy var nextButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Próximo"
        button.isShowingIcon = true
        button.isActive = false
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
        label.font = Fonts.title3
        label.textColor = .label
        return label
    }()

    func checkCounts() {
        let allEmpty = clothingSelectors.allSatisfy { $0.count == 0 }
        nextButton.isActive = !allEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Peças"
        navigationItem.backButtonTitle = "Voltar"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        setup()
        clothingSelectors.forEach { $0.delegate = self }
        checkCounts()
        hideKeyboardWhenTappedAround()
    }

    @objc func goToOrderAdressVC() {
        var lines = [String]()
        let counts = [
            ("Camiseta", clothingSelector.getCount()),
            ("Casaco",   clothingSelector2.getCount()),
            ("Terno",    clothingSelector3.getCount()),
            ("Lençol",   clothingSelector4.getCount()),
            ("Calça",    clothingSelector5.getCount())
        ]
        for (name, count) in counts where count > 0 {
            lines.append("\(count)\t \(name)")
        }
        if lines.isEmpty {
            lines.append("Nenhuma peça selecionada")
        }
        OrderFlowViewModel.shared.selectedClothes = lines.joined(separator: "\n")
        navigationController?.setNavigationBarHidden(false, animated: false)
        let addressVC = AddressViewController()
        navigationController?.pushViewController(addressVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      // força a barra de navegação visível
      navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension ClothingSelectionViewController: ClothesCoutingDelegate {
    func counterDidChange(count: Int, for counter: ClothesCouting) {
        checkCounts()
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
        view.addSubview(clothingSelector)
        view.addSubview(clothingSelector2)
        view.addSubview(clothingSelector3)
        view.addSubview(clothingSelector4)
        view.addSubview(clothingSelector5)
        view.addSubview(nextButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            dividerLine.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dividerLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerLine.heightAnchor.constraint(equalToConstant: 0.5),

            instructionsLabel.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 16),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            clothingSelector.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 16),
            clothingSelector.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            clothingSelector.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            clothingSelector2.topAnchor.constraint(equalTo: clothingSelector.bottomAnchor, constant: 16),
            clothingSelector2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            clothingSelector2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            clothingSelector3.topAnchor.constraint(equalTo: clothingSelector2.bottomAnchor, constant: 16),
            clothingSelector3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            clothingSelector3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            clothingSelector4.topAnchor.constraint(equalTo: clothingSelector3.bottomAnchor, constant: 16),
            clothingSelector4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            clothingSelector4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            clothingSelector5.topAnchor.constraint(equalTo: clothingSelector4.bottomAnchor, constant: 16),
            clothingSelector5.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            clothingSelector5.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
