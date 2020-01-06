import UIKit
import SafariServices

class LoginViewController: UIViewController, SFSafariViewControllerDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginClick(sender: UIButton){
        // open webview with auth
        showLinksClicked()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        if navigationType == UIWebView.NavigationType.linkClicked {
           self.showLinksClicked()
           return false

        }
        return true;
    }

    func showLinksClicked() {

        let safariVC = SFSafariViewController(url: buildLoginUrl())
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self as SFSafariViewControllerDelegate
    }

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func buildLoginUrl() -> URL {
        let configData = AuthConfigUtil.shared.configData!
        let authData = AuthConfigUtil.shared.authData
        
        let url = URL(string: authData!.authorization_endpoint)!
        let queryItems = [
            URLQueryItem(name: "redirect_uri", value: configData.redirect_uri),
            URLQueryItem(name: "client_id", value: configData.client_id),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "nonce", value: UUID().uuidString),
            URLQueryItem(name: "prompt", value: "login"),
            URLQueryItem(name: "code_challenge", value: AuthConfigUtil.shared.generateCodeChallenge()),
            URLQueryItem(name: "code_challenge_method", value: "S256")
        ]
        
        return url.appending(queryItems: queryItems)!
    }
}
