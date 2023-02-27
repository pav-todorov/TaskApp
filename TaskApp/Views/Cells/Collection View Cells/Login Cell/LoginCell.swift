//
//  LoginCell.swift
//  TaskApp
//
//  Created by Pavel on 26.02.23.
//

import UIKit

protocol LoginCellProtocol: AnyObject {
    func userDidTapLoginButton(credentials: (email: String, password: String))
    func userDidTapResetButton()
    func userDidTapGuestButton()
    func userDidTapAppleButton()
    func userDidTapGoogleButton()
    func userDidTapFacebookButton()
}

class LoginCell: UICollectionViewCell {
    // MARK: Variables
    static let identifier = "LoginCell"
    weak var delegate: LoginCellProtocol?
    private typealias LocStrings = LocalizedStrings.Views.LoginCell
    
    // MARK: Outlets
    @IBOutlet weak var userCredentialsTableView: UITableView!
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var welcomeTitle: UILabel!
    @IBOutlet weak var welcomeSubtitle: UILabel!
    @IBOutlet weak var externalLoginSectionTitle: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    // MARK: Constraints
    @IBOutlet weak var credentialsTableViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUserCredentialsTableView()
        configureButtons()
        addLocalizedText()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userCredentialsTableView.reloadData()
        userCredentialsTableView.layoutIfNeeded()
        mainStack.layoutIfNeeded()
        credentialsTableViewHeight.constant = userCredentialsTableView.contentSize.height
    }
    
    // MARK: IB Actions
    @IBAction func didTapResetPassword(_ sender: Any) {
        delegate?.userDidTapResetButton()
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        let userCredentials = getUserCredentials()
        delegate?.userDidTapLoginButton(credentials: userCredentials)
    }
    
    @IBAction func didTapGuestButton(_ sender: Any) {
        delegate?.userDidTapGuestButton()
    }
    
    @IBAction func didTapAppleButton(_ sender: Any) {
        delegate?.userDidTapAppleButton()
    }
    
    @IBAction func didTapGoogleButton(_ sender: Any) {
        delegate?.userDidTapGoogleButton()
    }
    
    @IBAction func didTapFacebookButton(_ sender: Any) {
        delegate?.userDidTapFacebookButton()
    }
    
    private func addLocalizedText() {
        welcomeTitle.text = LocStrings.login_cell_title
        welcomeSubtitle.text = LocStrings.login_cell_subtitle
        externalLoginSectionTitle.text = LocStrings.login_cell_external_login_section_title
    }
    
    func configureUserCredentialsTableView() {
        userCredentialsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        userCredentialsTableView.isScrollEnabled = false
        userCredentialsTableView.delegate = self
        userCredentialsTableView.dataSource = self
        
        userCredentialsTableView.register(UINib(nibName: UserTableViewCell.identifier, bundle: nil),
                                          forCellReuseIdentifier: UserTableViewCell.identifier)
        userCredentialsTableView.register(UINib(nibName: PasswordTableViewCell.identifier, bundle: nil),
                                          forCellReuseIdentifier: PasswordTableViewCell.identifier)
        
        userCredentialsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        userCredentialsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: Helpers
    func populateCredentials() {
        getUserCells().forEach({ cell in
            switch cell {
            case is UserTableViewCell:
                cell.userInputTextField.text = "a@cafe.bg"
            case is PasswordTableViewCell:
                cell.userInputTextField.text = "parola"
            default:
                break
            }
            cell.showHideTitleLabel(cell.userInputTextField)
        })
    }
    
    private func getUserCredentials() -> (email: String, password: String) {
        var userCredentials = ("", "")
        
        getUserCells().forEach({ cell in
            switch cell {
            case is UserTableViewCell:
                userCredentials.0 = cell.userInputTextField.text ?? ""
            case is PasswordTableViewCell:
                userCredentials.1 = cell.userInputTextField.text ?? ""
            default: break
            }
        })
        
        return userCredentials
    }
    
    private func getUserCells() -> [BaseCredentialsTableViewCell] {
        guard let cells = userCredentialsTableView.visibleCells as? [BaseCredentialsTableViewCell] else { return [] }
        return cells
    }
    
    private func configureButtons() {
        loginButton.setTitle(LocStrings.login_cell_buttons_login, for: .normal)
        
        resetPasswordButton.setTitle(LocStrings.login_cell_buttons_reset, for: .normal)
        
        appleButton.setImage(.init(named: "apple"), for: .normal)
        appleButton.setTitle(LocStrings.login_cell_buttons_apple, for: .normal)
        
        googleButton.setImage(.init(named: "google"), for: .normal)
        googleButton.setTitle(LocStrings.login_cell_buttons_google, for: .normal)
        
        facebookButton.setImage(.init(named: "facebook"), for: .normal)
        facebookButton.setTitle(LocStrings.login_cell_buttons_facebook, for: .normal)
        
        guestButton.setTitle(LocStrings.login_cell_buttons_guest, for: .normal)
    }
}

// MARK: - UI Table View Delegates
extension LoginCell: UITableViewDelegate, UITableViewDataSource {
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
