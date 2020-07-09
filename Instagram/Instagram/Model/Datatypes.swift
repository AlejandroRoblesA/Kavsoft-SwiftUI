//
//  Datatype.swift
//  Instagram
//
//  Created by Omar Alejandro Robles Altamirano on 09/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI

struct Datatype: Identifiable{
    var id: String
    var name: String
    var image: String
}


struct PostsDatatype: Identifiable{
    var id:       String
    var name:     String
    var image:    String
    var comments: String
    var likes:    String
}
