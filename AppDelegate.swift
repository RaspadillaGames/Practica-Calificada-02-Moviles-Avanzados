import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Pestaña 1: lista de docentes
        let teachersNav = UINavigationController(rootViewController: TeachersViewController())
        teachersNav.tabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.bullet"), tag: 0)

        // Pestaña 2: calculadora
        let calcNav = UINavigationController(rootViewController: CalculatorViewController())
        calcNav.tabBarItem = UITabBarItem(title: "Calculator", image: UIImage(systemName: "plus.forwardslash.minus"), tag: 1)

        // Tab Bar Controller
        let tabBar = UITabBarController()
        tabBar.viewControllers = [teachersNav, calcNav]

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        return true
    }
}
