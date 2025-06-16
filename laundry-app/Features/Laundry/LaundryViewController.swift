//
//  LaundryViewController.swift
//  laundry-app
//
//  Created by Antonio Costa on 11/06/25.
//

import UIKit
import CoreData

class LaundryViewController: UIViewController {
    
    private var laundries: [Laundry] = []
    
    private let gradientLayer = CAGradientLayer()
    
    private lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = 16
        flow.sectionInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        flow.itemSize = .init(
            width: UIScreen.main.bounds.width - 32,
            height: 142
        )
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cv.backgroundColor = .systemBackground
        cv.dataSource = self
        cv.delegate = self
        cv.register(
            LaundryCardCell.self,
            forCellWithReuseIdentifier: LaundryCardCell.reuseIdentifier
        )
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Lavanderias"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = makeSearchController()
        navigationItem.hidesSearchBarWhenScrolling = false

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        if let navBar = navigationController?.navigationBar {
            let height = navBar.bounds.height
                      + view.safeAreaInsets.top
                      + 58
            let size = CGSize(
                width: UIScreen.main.bounds.width,
                height: height
            )
            let gradImg = UIImage.gradientImage(
                size: size,
                colors: [.accent, .lavanda],
                cornerRadius: 24,
                maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            )
            appearance.backgroundImage = gradImg
        }
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        navigationItem.standardAppearance    = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance    = appearance

        view.backgroundColor = .systemBackground
        definesPresentationContext = true
        
        if let appDel = UIApplication.shared.delegate as? AppDelegate {
            LaundryPersistence.shared.context = appDel.persistentContainer.viewContext
        }
        LaundryPersistence.shared.mockData()
        laundries = LaundryPersistence.shared.getAllLaundries()
        setup()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let headerHeigth: CGFloat = 200
        
        gradientLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: headerHeigth
        )
    }
            
    private func makeSearchController() -> UISearchController {
        let sc = UISearchController()
        sc.obscuresBackgroundDuringPresentation = false
        sc.hidesNavigationBarDuringPresentation = false
        sc.searchBar.placeholder = "Buscar"
        
        sc.searchBar.barTintColor = .clear
        sc.searchBar.backgroundImage = UIImage()

        sc.searchBar.tintColor = .gray

        let tf = sc.searchBar.searchTextField
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.leftView?.tintColor = .white
        
        tf.attributedPlaceholder = NSAttributedString(
            string: "Buscar",
            attributes: [
                .foregroundColor: UIColor.white.withAlphaComponent(0.7)
            ]
        )
        
        return sc
    }
}

// MARK: UICollectionViewDataSource
extension LaundryViewController: UICollectionViewDataSource {
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        laundries.count
    }
    func collectionView(
        _ cv: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(
            withReuseIdentifier: LaundryCardCell.reuseIdentifier,
            for: indexPath
        ) as! LaundryCardCell
        cell.configure(with: laundries[indexPath.item] , delegate : self)
        return cell
    }
}

// MARK: UICollectionViewDelegate
//extension LaundryViewController: UICollectionViewDelegate {
//    // se precisar, trate didSelect etc.
//}

extension LaundryViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }
}

extension LaundryViewController: AvalibilityCardDelegate { 
    func isLaundryOpen(for laundry: Laundry) -> Bool {
        guard let open = laundry.openHour, let close = laundry.closeHour else { return false }
        let now = Date()
        return now >= open && now < close
    }
}

extension LaundryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1. Obtém a lavanderia selecionada
        let selectedLaundry = laundries[indexPath.item]

        // 2. Cria o detail view controller
        let detailVC = LaundryDetailViewController(laundry: selectedLaundry)

        // 3. Navega para ele
        navigationController?.pushViewController(detailVC, animated: true)

        // 4. Opcional: desselciona a célula
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
