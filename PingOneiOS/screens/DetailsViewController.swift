import UIKit

class DetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dictionary: Dictionary<String, Any>?
    
    @IBAction func close(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dictionary?.keys.count ?? 0
    }

    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailViewCell", for: indexPath as IndexPath) as! DetailViewCell

        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        let key = Array(dictionary!.keys)[indexPath.row]
        cell.keyLabel.text = key
        let data = dictionary![key]
        if let str = data as? Int {
            cell.dataLabel.text = String(str)
            return cell
        }
        cell.dataLabel.text = dictionary![key] as? String
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}
