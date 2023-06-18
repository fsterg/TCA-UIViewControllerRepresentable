import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    weak var delegate: ViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.didTapButton(date: Date())
    }

    public func setLabelText(string: String) {
        label.text = string
    }

}

protocol ViewControllerDelegate: AnyObject {
    func didTapButton(date: Date)
}
