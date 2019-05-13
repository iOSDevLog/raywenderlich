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

import UIKit
import NotificationCenter
import InfoService

class TodayViewController: UIViewController, NCWidgetProviding {
  
  @IBOutlet weak var label: UILabel!

  let model = Model()
  var nextRun: (TrainLine, LineSchedule.Run)? = nil

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    model.lines.forEach { line in
      model.schedule(forId: line.lineId, completion: { [weak self] schedule in
        guard let strongSelf = self else {
          return
        }

        schedule.schedule.forEach { run in
          strongSelf.checkRunIfItsNext(run, line: line)
        }
      })
    }
  }

  func checkRunIfItsNext(_ run: LineSchedule.Run, line: TrainLine) {
    guard run.departs > Date() else {
      return
    }

    guard let latestRun = self.nextRun else {
      self.nextRun = (line, run)
      self.updateOnMain()
      return
    }

    if run.departs < latestRun.1.departs {
      self.nextRun = (line, run)
      self.updateOnMain()
    }
  }

  func updateOnMain() {
    DispatchQueue.main.async { [weak self] in
      guard let strongSelf = self else {
        return
      }

      strongSelf.updateLabel()
    }
  }

  func updateLabel() {
    if let (line, run) = nextRun {
      let formatter = DateFormatter()
      formatter.dateStyle = .none
      formatter.timeStyle = .short
      let time = formatter.string(from: run.departs)
      let train = line.name
      self.label.text = "Next train: \(train) (\(run.train)): @ \(time)"
    } else {
      self.label.text = "No train information at this time."
    }
  }

  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData
    
    completionHandler(NCUpdateResult.newData)
  }
}
