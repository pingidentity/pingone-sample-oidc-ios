import UIKit
import Alamofire
import JWTDecode

class MainViewController: DefaultViewController {
    
    private let authUtil = AuthConfigUtil.shared
    private let ouathUtil = OAuthUtil.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        proceedWithFlow()
    }
    
    @IBAction func infoUserClick(sender: UIButton) {
        ouathUtil.fetchUserInfo { userInfo, error in
            self.hideLoading()
            if error == nil {
                self.openDetails(dictionary: userInfo!.asDictionary)
            } else {
                self.logout()
            }
        }
    }
    
    @IBAction func infoTokenClick(sender: UIButton) {
        let jwt = authUtil.getJWT()
        self.openDetails(dictionary: jwt.asDictionary)
    }
    
    @IBAction func logoutClick(sender: UIButton) {
        logout()
    }
    
    private func logout() {
        ouathUtil.logout()
        openLoginView()
    }
    
    private func proceedWithPKCE() {
        if (authUtil.accessCode != nil) {
            showLoading()
            self.ouathUtil.proceedWithPKCE { success in
                self.proceedAfterLogin(success: success)
            }
        }
    }

    private func proceedWithFlow() {
        if (authUtil.accessCode != nil) {
            showLoading()
            switch (authUtil.configData?.token_method) {
                case TokenMethod.CLIENT_SECRET_BASIC.description:
                    self.ouathUtil.proceedWithBasic { success in
                        self.proceedAfterLogin(success: success)
                }
                case TokenMethod.CLIENT_SECRET_POST.description:
                    self.ouathUtil.proceedWithPost { success in
                        self.proceedAfterLogin(success: success)
                }
                case TokenMethod.NONE.description:
                    self.ouathUtil.proceedWithPKCE { success in
                        self.proceedAfterLogin(success: success)
                }
                default:
                    print("Method not allowed")
            }
        }
    }
    
    private func proceedAfterLogin(success: Bool) {
        success ? self.hideLoading() : self.openLoginView()
        authUtil.accessCode = nil
    }
}
