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

    func startDragging(_ string: String, shouldDrop: @escaping (Int) -> Bool) {
        // The actual code passes a CGPoint instead of a random location
        let randomLocation = Int.random(in: 0...10)
        if shouldDrop(randomLocation) {
            label.text = "dropped"
        } else {
            label.text = "can't drop"
        }
    }

}

protocol ViewControllerDelegate: AnyObject {
    func didTapButton(date: Date)
}
