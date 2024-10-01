//
//  ContentView.swift
//  routingexample
//
//  Created by Bernardo Tolosa on 10/1/24.
//

import SwiftUI

struct ViewA: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Button("Go to View B") {
                router.navigateTo(.containerIdWithParam("view-c", "hello from a"))
            }
            
            Button("Go to View C") {
                router.navigateTo(.containerId("view-c"))
            }
        }
        .navigationTitle("View A")
        .padding()
    }
}

struct ViewB: View {
    @EnvironmentObject var router: Router
    let description: String
    
    var body: some View {
        VStack {
            Button("Go to View C") {
                router.navigateTo(.containerId("view-c"))
            }
        }
        .padding()
    }
}

struct ViewC: View {
    var body: some View {
        VStack {
            Text("View C")
        }
        .padding()
    }
}

// wrapped View
struct ContentView: View {
    var body: some View {
        RouterView() {
            ViewA()
        }
    }
}

#Preview {
    ContentView()
}
