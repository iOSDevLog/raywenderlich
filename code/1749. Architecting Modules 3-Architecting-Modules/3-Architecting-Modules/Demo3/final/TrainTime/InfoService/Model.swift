/// Copyright (c) 2017 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import Helpers
import PersistenceFacade

private enum PersistenceKeys: String {
  case trainLine
  case schedule
  case geography
}

public class Model {

  private let api: API
  private let db: Persistence
  public var lines: [TrainLine] = []

  private var geographyReloadedFromServer = false

  public init(api: API = API()) {
    // Swap these to switch between two different persistence libraries
    // self.db = Persistence(layer: ClioPersistenceLayer())
    self.db = Persistence(layer: MuninPersistenceLayer())

    self.lines = db.load(key: PersistenceKeys.trainLine.rawValue) ?? []

    self.api = api
    api.loadTrainLines { [weak self] result in
      guard let strongSelf = self,
        let lines = result.value else {
          return
      }

      strongSelf.lines = lines
      strongSelf.db.save(key: PersistenceKeys.trainLine.rawValue, items: lines)
    }
  }

  public func line(forId id: Int) -> TrainLine? {
    return lines.filter { $0.lineId == id }.first
  }

  public func schedule(forId id: Int, completion: @escaping (LineSchedule) -> ()) {
    api.loadSchedule { [weak self] result in
      guard let strongSelf = self,
        let lines = result.value else {
          return
      }

      strongSelf.db.save(key: PersistenceKeys.schedule.rawValue, items: lines)
      let schedule = lines.filter { $0.lineId == id }.first
      if let schedule = schedule {
        completion(schedule)
      }
    }
  }

  public func geography(forId id: Int, completion: @escaping (TrainLineGeography?) -> ()) {
    loadGeography { geography in
      let lineGeometry = geography.filter { $0.lineId == id }.first
      DispatchQueue.main.async {
        completion(lineGeometry)
      }
    }

  }

  fileprivate func loadGeographyFromAPI(_ completion: @escaping ([TrainLineGeography]) -> ()) {
    api.loadLineGeography { [weak self] result in
      guard let strongSelf = self else {
        return
      }

      switch result {
      case .success(let geography):
        strongSelf.db.save(key: PersistenceKeys.geography.rawValue, items: geography)
        strongSelf.geographyReloadedFromServer = true
        completion(geography)
      case .failure(let error):
        print("error loading geography: \(error)")
        completion([])
      }
    }
  }

  private func loadGeography(completion: @escaping ([TrainLineGeography]) -> ()) {
    if geographyReloadedFromServer {
      if let geography: [TrainLineGeography] = self.db.load(key: PersistenceKeys.geography.rawValue) {
        completion(geography)
      } else {
        loadGeographyFromAPI(completion)
      }
    } else {
      loadGeographyFromAPI(completion)
    }
  }
}
