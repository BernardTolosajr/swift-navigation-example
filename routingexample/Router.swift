//
//  Router.swift
//  routingexample
//
//  Created by Bernardo Tolosa on 10/1/24.
//

import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router = Router()
    
    private let content: Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content.navigationDestination(for: Router.Route.self) { route in
                router.view(for: route)
            }
        }.environmentObject(router)
    }
}

class Router: ObservableObject {
    // Contains the possible destinations in our Router
    enum Route: Hashable {
        case containerId(String)
        case containerIdWithParam(String, String)
    }
    
    @Published var path: NavigationPath = NavigationPath()
    
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .containerId(let id):
            // id is the container id comming from somewhere
            if id == "view-a" {
                ViewA()
            }
            if id == "view-c" {
                ViewC()
            }
        case .containerIdWithParam(let id, let params):
            if id == "view-b" {
                ViewB(description: params)
            }
        }
    }
    
    // Used by views to navigate to another view
    func navigateTo(_ appRoute: Route) {
            path.append(appRoute)
    }
        
    // Used to go back to the previous screen
    func navigateBack() {
        path.removeLast()
    }
        // Pop to the root screen in our hierarchy
    func popToRoot() {
        path.removeLast(path.count)
    }
}
