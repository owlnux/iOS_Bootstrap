//
//  TrendingMoviesViewDelegator.swift
//  iOS_Bootstrap_Example
//
//  Created by Ahmad Mahmoud on 10/30/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import iOS_Bootstrap

protocol TrendingMoviesViewDelegator : BaseViewDelegator {
    func didGetMovieSummary(summary: String)
    func didFailToGetTrendingMovies(error: String)
}







