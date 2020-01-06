import UIKit

class LaunchViewController: DefaultViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load initial data from bundle and auth configuration
        let authUtil = AuthConfigUtil.shared
        try! authUtil.setUP { isLoaded in
            if (authUtil.authData != nil && authUtil.configData != nil) {
                if (!authUtil.isUserAuthorized()) {
                    self.openLoginView()
                } else {
                    self.openMainView()
                }
            }
        }
    }
}
