/*
Copyright, EdexApple
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/

import Foundation
import UIKit

/// <#Description#>
open class BaseRouter {
    ///
	public weak var baseView: UIViewController?
    weak var delegate: BaseRouterDelegate?
    
    /// <#Description#>
    public required init() {}
    
    /// <#Description#>
    /// - Parameter navigationController: <#navigationController description#>
    public static func setRoot(navigationController: UIViewController) {
        guard let window = UIApplication.shared.delegate?.window else {
            return
        }
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
        
    /// <#Description#>
    /// - Parameters:
    ///   - viewControllerToPresent: <#viewControllerToPresent description#>
    ///   - flag: <#flag description#>
    public func rootViewController(_ viewControllerToPresent: UIViewController,
                                   animated flag: Bool) {
        self.delegate?.navigationDone()
        DispatchQueue.main.async {
            self.baseView?.navigationController?.setViewControllers([viewControllerToPresent], animated: flag)
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - viewControllerToPresent: <#viewControllerToPresent description#>
    ///   - flag: <#flag description#>
    public func pushViewController(_ viewControllerToPresent: UIViewController,
                                   animated flag: Bool) {
        self.delegate?.navigationDone()
        DispatchQueue.main.async {
            self.baseView?.navigationController?.pushViewController(viewControllerToPresent, animated: flag)
        }
    }
    
    /// <#Description#>
    /// - Parameter animated: <#animated description#>
    public func popViewController(animated: Bool) {
        self.delegate?.navigationDone()
        DispatchQueue.main.async {
            self.baseView?.navigationController?.popViewController(animated: animated)
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - toViewController: <#toViewController description#>
    ///   - animated: <#animated description#>
    public func popToViewController(toViewController: UIViewController, animated: Bool) {
        self.delegate?.navigationDone()
        DispatchQueue.main.async {
            self.baseView?.navigationController?.popToViewController(toViewController, animated: animated)
        }
    }
    
    /// <#Description#>
    public func popToRootViewController() {
        self.delegate?.navigationDone()
        DispatchQueue.main.async {
            self.baseView?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - viewControllerToPresent: <#viewControllerToPresent description#>
    ///   - flag: <#flag description#>
    ///   - completion: <#completion description#>
    public func present(_ viewControllerToPresent: UIViewController,
                        animated flag: Bool,
                        completion: (() -> Swift.Void)? = nil) {
        self.delegate?.navigationDone()
        DispatchQueue.main.async {
            self.baseView?.present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - flag: <#flag description#>
    ///   - completion: <#completion description#>
    public func dismiss(animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        self.delegate?.navigationDone()
        DispatchQueue.main.async {
            self.baseView?.dismiss(animated: flag, completion: completion)
        }
    }
    
    /// <#Description#>
    /// - Parameter viewController: <#viewController description#>
    public func setRoot(_ viewController: UIViewController) {
        self.delegate?.navigationDone()
        var keyWindow: UIWindow?
        if #available(iOS 13.0, *) {
            keyWindow = UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .first?
                .windows
                .first(where: { $0.isKeyWindow })
        } else {
            // Fallback on earlier versions
            keyWindow = UIApplication.shared.keyWindow
        }
        keyWindow?.rootViewController = viewController
    }
    
    /// <#Description#>
    public func pushMenu() {
        self.delegate?.navigationDone()
        DispatchQueue.main.async {
            self.baseView?.navigationController?.popToRootViewController(animated: false)
        }
    }
}
