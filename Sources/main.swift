//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

// Create HTTP server.
let server = HTTPServer()

// Register your own routes and handlers
var routes = Routes()
routes.add(method: .get, uri: "/", handler: {
		request, response in
		response.setHeader(.contentType, value: "text/html")
		response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
		response.completed()
	}
)

//添加一个新的
routes.add(method: .get, uri: "/img/**") { (request, response) in
    let param = request.queryParams
    var name:String = ""
    for dict in param{
       if dict.0 == "name"{
        name = dict.1
        }
    }
    
    

    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "\(name)")
    response.completed()
}


routes.add(method: .post, uri: "/") { (request, response) in
    
    let param = request.param(name: "name")
    
    print(param)
    
    
    //let params = request.postParams(name: <String>)
    var name:String = ""
    /*
    for obj in param{
        if obj.0 == "name"{
            name = obj.1
        }
        
    }*/
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "\(name)")
    response.completed()
}

var aa = [(String,String)]()
// Add the routes to the server.
server.addRoutes(routes)

// Set a listen port of 8181
server.serverPort = 8181

// Set a document root.
// This is optional. If you do not want to serve static content then do not set this.
// Setting the document root will automatically add a static file handler for the route /**
server.documentRoot = "./webroot"


// Gather command line options and further configure the server.
// Run the server with --help to see the list of supported arguments.
// Command line arguments will supplant any of the values set above.
configureServer(server)

do {
	// Launch the HTTP server.
	try server.start()
} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
