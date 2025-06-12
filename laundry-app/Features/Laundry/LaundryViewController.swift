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
        view.backgroundColor = .systemBackground
        
        if let appDel = UIApplication.shared.delegate as? AppDelegate {
            LaundryPersistence.shared.context = appDel.persistentContainer.viewContext
        }
        
        LaundryPersistence.shared.mockData()
        laundries = LaundryPersistence.shared.getAllLaundries()
        
        setup()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = makeSearchController()
        navigationItem.hidesSearchBarWhenScrolling = false   

        definesPresentationContext = true

        
        
    }
    
    private func makeSearchController() -> UISearchController {
        let sc = UISearchController()
        sc.obscuresBackgroundDuringPresentation = false
        sc.hidesNavigationBarDuringPresentation = false
        sc.searchBar.placeholder = "Buscar"
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
extension LaundryViewController: UICollectionViewDelegate {
    // se precisar, trate didSelect etc.
}

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
