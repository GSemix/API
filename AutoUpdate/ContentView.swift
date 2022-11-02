//
//  ContentView.swift
//  AutoUpdate
//
//  Created by Семен Безгин on 14.09.2022.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    let mainURL: String = "http://127.0.0.1:8080/api/books"
    
    var body: some View {
        VStack {
            Spacer()
            
            TextField("Text", text: $text)
            
            Spacer()
            
            Button("GET all books") {
                Task {
                    await getAllBooks()
                }
            }
            
            Spacer()
            
            Button("GET book by Id") {
                Task {
                    await getBookById(id: text)
                }
            }
            
            Spacer()
            
            Button("GET book by Title") {
                Task {
                    await getBookByTitle(title: text)
                }
            }
            
            VStack {
                Spacer()
                
                Button("POST create book") {
                    Task {
                        await postCreateBook()
                    }
                }
                
                Spacer()
                
                Button("PUT update book") {
                    Task {
                        await putUpdateBook(id: text)
                    }
                }
                
                Spacer()
                
                Button("DELETE book") {
                    Task {
                        await deleteBook(id: text)
                    }
                }
                
                Spacer()
            }
        }
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { showingConfirmation = false }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func getText() -> String {
        return "Other text"
    }
    
    func getAllBooks() async {
        guard let url = URL(string: mainURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                showingConfirmation = true
                confirmationMessage = """
                    \(json)
                """
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    func getBookById(id: String = "fe5008fd-d6aa-4084-853c-750b17e8c954") async {
        guard let url = URL(string: mainURL + "/id/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                showingConfirmation = true
                confirmationMessage = """
                    \(json)
                """
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    func getBookByTitle(title: String = "new") async {
        guard let url = URL(string: mainURL + "/title/\(title)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                showingConfirmation = true
                confirmationMessage = """
                    \(json)
                """
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    func postCreateBook() async {
        guard let url = URL(string: mainURL) else { return }
        let parameters: Dictionary<String, Any> = [
            "title" : "swift",
            "author" : "swift1",
            "year" : 123
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                showingConfirmation = true
                confirmationMessage = """
                    \(json)
                """
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    func putUpdateBook(id: String = "fe5008fd-d6aa-4084-853c-750b17e8c954") async {
        guard let url = URL(string: mainURL + "/id/\(id)") else { return }
        let parameters: Dictionary<String, Any> = [
            "title" : "updated1",
            "author" : "updated2",
            "year" : 333
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                showingConfirmation = true
                confirmationMessage = """
                    \(json)
                """
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    func deleteBook(id: String = "fe5008fd-d6aa-4084-853c-750b17e8c954") async {
        guard let url = URL(string: mainURL + "/id/\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                showingConfirmation = true
                confirmationMessage = """
                    \(json)
                """
            } catch {
                print(error)
            }
        }
        .resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
