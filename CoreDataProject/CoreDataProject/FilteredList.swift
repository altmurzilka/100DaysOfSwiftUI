//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Алтын on 7/8/20.
//

import CoreData
import SwiftUI

enum Predicates: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
    case beginsWithIgnoreCase = "BEGINSWITH[c]"
    case containsIgnoreCase = "CONTAINS[c]"
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}


