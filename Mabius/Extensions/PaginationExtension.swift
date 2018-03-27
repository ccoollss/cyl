//
//  PaginationExtension.swift
//  Mabius
//
//  Created by Andrey Toropchin on 20.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import Foundation

extension Pagination
{
    convenience init(page: Int, perPage: Int) {
        self.init()
        self.perPage = perPage
        self.currentPage = page
    }

    func next() -> Pagination {
        self.currentPage = self.currentPage + 1
        return self
    }
}