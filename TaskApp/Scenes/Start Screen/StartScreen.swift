//
//  StartScreen.swift
//  TaskApp
//
//  Created by Pavel on 25.02.23.
//

import UIKit

class StartScreen: UIViewController,
                   UICollectionViewDelegate,
                   UICollectionViewDataSource,
                   StartViewable, StartNavigable {
    let horizontalBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(rgb: 0x333333)
        return view
    }()
    
    // MARK: Variables
    var presenter: (any StartPresentable)!
    let menuItems = ["LOG IN", "SIGN UP"]
    
    // MARK: Outlets
    @IBOutlet weak var navigationCollectionView: UICollectionView!
    @IBOutlet weak var navigationCollectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var shadowCover: UIView!
    @IBOutlet weak var pagesCollectionView: UICollectionView!
    @IBOutlet weak var pagesCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    // MARK: Constraints
    var horizontalBarLeadingConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = StartFactory.default().presenter
        presenter.view = self
        
        presenter.viewDidLoad()
        configureNavigationCollectionView()
        configurePagesCollectionView()
        setupHorizontalBar()
        self.hideKeyboardWhenTappedAround()
        
        addObservers()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Viewable
    func showLoadingIndicator() {
        AlertManager.shared.loadingAlert(from: self)
    }
    
    func showAlertMessage(with alertType: AlertType) {
        AlertManager.shared.alert(onBehalfOf: self, with: alertType)
    }
    
    func dismissLoadingIndicator(completion: @escaping () -> Void) {
        AlertManager.shared.dismissLoadingIndicator(onBehalfOf: self, completion: completion)
    }
    
    func populateCredentials() {
        guard let loginCell = pagesCollectionView.cellForItem(at: .init(row: 0, section: 0)) as? LoginCell else { return }
        loginCell.populateCredentials()
    }
    
    private func configureNavigationCollectionView() {
        addCollectionViewShadow()
        navigationCollectionView.register(UINib(nibName: MenuItem.identifier, bundle: nil),
                                          forCellWithReuseIdentifier: MenuItem.identifier)
        navigationCollectionView.selectItem(at: .init(row: 0, section: 0),
                                            animated: false,
                                            scrollPosition: .centeredHorizontally)
        navigationCollectionViewFlowLayout.itemSize = CGSize(width: view.frame.size.width/2,
                                                             height: 60)
        navigationCollectionViewFlowLayout.minimumInteritemSpacing = 0
        navigationCollectionViewFlowLayout.minimumLineSpacing = 0
        navigationCollectionView.layer.zPosition = -1
    }
    
    private func setupHorizontalBar() {
        view.addSubview(horizontalBarView)
        NSLayoutConstraint.activate([
            horizontalBarView.leadingAnchor.constraint(
                equalTo: navigationCollectionView.leadingAnchor)
            .storing(in: &horizontalBarLeadingConstraint),
            horizontalBarView.bottomAnchor.constraint(equalTo: navigationCollectionView.bottomAnchor),
            horizontalBarView.widthAnchor.constraint(
                equalToConstant: CGFloat(view.frame.size.width / CGFloat(menuItems.count))),
            horizontalBarView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    // MARK: - Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === navigationCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItem.identifier,
                                                                for: indexPath) as? MenuItem else {
                return UICollectionViewCell() }
            cell.setupLabel(with: menuItems[indexPath.row])
            return cell
        } else if collectionView === pagesCollectionView {
            switch indexPath.row {
            case 0:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginCell.identifier,
                                                                    for: indexPath) as? LoginCell else {
                    return UICollectionViewCell() }
                
                cell.delegate = self
                
                return cell
            case 1:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignupCell.identifier,
                                                                    for: indexPath) as? SignupCell else {
                    return UICollectionViewCell() }
                return cell
            default: fatalError()
            }
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView === navigationCollectionView {
            // Due to a bug in UICollectionView in iOS 14 and above with scrollToItem,
            // ( https://stackoverflow.com/questions/50237180/uicollectionview-scrolltoitem-not-working-in-ios-14 )
            // the following ```hack``` needs to be provided
            pagesCollectionView.isPagingEnabled = false
            scrollToNavigationMenuIndex(at: indexPath)
            pagesCollectionView.isPagingEnabled = true
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === navigationCollectionView {
            return 2
        } else if collectionView === pagesCollectionView {
            return 2
        } else {
            return 0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        horizontalBarLeadingConstraint?.constant = scrollView.contentOffset.x / CGFloat(menuItems.count)
    }
    
    // MARK: Helpers
    private func scrollToNavigationMenuIndex(at indexPath: IndexPath) {
        pagesCollectionView.scrollToItem(at: indexPath,
                                         at: .centeredHorizontally,
                                         animated: true)
    }
    
    private func configurePagesCollectionView() {
        pagesCollectionView.delegate = self
        pagesCollectionView.dataSource = self
        pagesCollectionView.register(UINib(nibName: LoginCell.identifier, bundle: nil),
                                     forCellWithReuseIdentifier: LoginCell.identifier)
        pagesCollectionView.register(UINib(nibName: SignupCell.identifier, bundle: nil),
                                     forCellWithReuseIdentifier: SignupCell.identifier)
        pagesCollectionViewFlowLayout.scrollDirection = .horizontal
        pagesCollectionViewFlowLayout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        pagesCollectionViewFlowLayout.minimumLineSpacing = 0
        
        pagesCollectionView.isPagingEnabled = true
        pagesCollectionView.showsHorizontalScrollIndicator = false
        pagesCollectionView.layer.zPosition = -2
    }
    
    func addCollectionViewShadow() {
        navigationCollectionView.layer.masksToBounds = false
        navigationCollectionView.layer.shadowOpacity = 0.7
        navigationCollectionView.layer.shadowOffset = CGSize(width: 3, height: 3)
        navigationCollectionView.layer.shadowRadius = 15.0
        navigationCollectionView.layer.shadowColor = UIColor.darkGray.cgColor
    }
}

// MARK: - UI Table View Delegates
extension StartScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier,
                                                 for: indexPath)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: PasswordTableViewCell.identifier,
                                                 for: indexPath)
        default:
            cell = UITableViewCell()
        }
        
        cell.layoutIfNeeded()
        cell.selectionStyle = .none
        cell.clipsToBounds = true
        
        return cell
    }
}

// MARK: Login Cell Protocol
extension StartScreen: LoginCellProtocol {
    func userDidTapLoginButton(credentials: (email: String, password: String)) {
        presenter.userDidTapLoginButton(credentials: credentials)
    }
    
    func userDidTapResetButton() {
        presenter.userDidTapResetButton()
    }
    
    func userDidTapGuestButton() {
        presenter.userDidTapGuestButton()
    }
}
