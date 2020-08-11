import UIKit

protocol WireframeInterface: class {
}

class b_BaseWireframe {

    private unowned var _viewController: UIViewController

    //to retain view controller reference upon first access
    private var _temporaryStoredViewController: UIViewController?

    init(viewController: UIViewController) {
        _temporaryStoredViewController = viewController
        _viewController = viewController
    }

}

extension b_BaseWireframe: WireframeInterface {

}

extension b_BaseWireframe {

    var viewController: UIViewController {
        defer { _temporaryStoredViewController = nil }
        return _viewController
    }

    var navigationController: UINavigationController? {
        return viewController.navigationController
    }

}

extension UIViewController {

    func presentWireframe(_ wireframe: b_BaseWireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }

}

extension UINavigationController {

    func pushWireframe(_ wireframe: b_BaseWireframe, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }

    func setRootWireframe(_ wireframe: b_BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }

}
