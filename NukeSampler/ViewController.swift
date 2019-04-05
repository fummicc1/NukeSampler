import UIKit
import Nuke
import FirebaseStorage

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let imageNameArray: [String] = [
        "error.png",
        "icon004.png",
        "memoryleak.png",
        "status.png"
    ]
    var imageArray: [UIImage] = []
    
    override func loadView() {
        super.loadView()
        guard let view = UINib(nibName: "ViewController", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        for imageName in imageNameArray {
            Storage.storage().reference().child(imageName).downloadURL(completion: { (url, error) in
                guard let url = url else { return }
                ImagePipeline.shared.loadImage(with: url, progress: nil, completion: { [weak self] (response, error) in
                    guard let image = response?.image else {
                        return
                    }
                    self?.imageArray.append(image)
                    if self?.imageArray.count == 4 {
                        self?.tableView.reloadData()
                    }
                })
            })
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else { return UITableViewCell() }
        cell.storageImageView.image = imageArray[indexPath.row]
        return cell
    }
}
