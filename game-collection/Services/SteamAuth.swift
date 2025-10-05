//
//  SteamAuth.swift
//  game-collection
//
//  Created by Rafael Venetikides on 30/09/25.
//

import AuthenticationServices

class SteamAuth: NSObject {
    private var session: ASWebAuthenticationSession?

    func login(completion: @escaping (String?) -> Void) {
        let openIDUrl = "https://steamcommunity.com/openid/login"
        let returnTo = "https://steam-auth.veneti.codes/api/auth/steam/callback"
        guard
            let encodedReturnTo = returnTo.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ),
            let url = URL(
                string:
                    "\(openIDUrl)?openid.ns=http://specs.openid.net/auth/2.0&openid.mode=checkid_setup&openid.return_to=\(encodedReturnTo)&openid.realm=\(encodedReturnTo)&openid.identity=http://specs.openid.net/auth/2.0/identifier_select&openid.claimed_id=http://specs.openid.net/auth/2.0/identifier_select"
            )
        else {
            completion(nil)
            return
        }

        session = ASWebAuthenticationSession(
            url: url,
            callbackURLScheme: "myapp"
        ) { [weak self] callbackURL, error in
            defer { self?.session = nil }

            if let error = error {
                completion(nil)
                return
            }

            guard
                let callbackURL = callbackURL,
                let components = URLComponents(
                    url: callbackURL,
                    resolvingAgainstBaseURL: false
                ),
                let steamId = components.queryItems?.first(where: {
                    $0.name == "steamId"
                })?.value
            else {
                completion(nil)
                return
            }

            completion(steamId)
        }

        if #available(iOS 13.0, *) {
            session?.prefersEphemeralWebBrowserSession = true
        }

        session?.presentationContextProvider = self
        session?.start()
    }
}

extension SteamAuth: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession)
        -> ASPresentationAnchor
    {
       return ASPresentationAnchor()
    }
}
