/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class AppointmentCell: UITableViewCell {
  static let cellIdentifier = "appointmentCell"
  
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var doctorNameLabel: UILabel!
  @IBOutlet var timeLabel: UILabel!
  
  private var commonConstraints: [NSLayoutConstraint] = []
  private var regularConstraints: [NSLayoutConstraint] = []
  private var largeTextConstraints: [NSLayoutConstraint] = []

  private lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
  }()
  
  private lazy var timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
  }()
  
  var appointment: Appointment? {
    didSet {
      guard let appointment = appointment else {
        dateLabel.text = nil
        doctorNameLabel.text = nil
        timeLabel.text = nil
        return
      }
      dateLabel.text = dateFormatter.string(from: appointment.dateTime)
      timeLabel.text = timeFormatter.string(from: appointment.dateTime)
      doctorNameLabel.text = appointment.doctor.name
    }
  }

  private func setupConstraints() {
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    doctorNameLabel.translatesAutoresizingMaskIntoConstraints = false
    timeLabel.translatesAutoresizingMaskIntoConstraints = false
    commonConstraints = [
      dateLabel.leadingAnchor.constraintEqualToSystemSpacingAfter(contentView.leadingAnchor, multiplier: 1.0),
      contentView.bottomAnchor.constraintGreaterThanOrEqualToSystemSpacingBelow(timeLabel.bottomAnchor, multiplier: 1.0)
    ]
    regularConstraints = [
      dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      doctorNameLabel.lastBaselineAnchor.constraint(equalTo: dateLabel.lastBaselineAnchor),
      timeLabel.lastBaselineAnchor.constraint(equalTo: dateLabel.lastBaselineAnchor),

      dateLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
      dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
      doctorNameLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
      doctorNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
      timeLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),

      doctorNameLabel.leadingAnchor.constraintGreaterThanOrEqualToSystemSpacingAfter(dateLabel.trailingAnchor, multiplier: 1.0),
      timeLabel.leadingAnchor.constraintGreaterThanOrEqualToSystemSpacingAfter(doctorNameLabel.trailingAnchor, multiplier: 1.0),

      doctorNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

      contentView.trailingAnchor.constraintEqualToSystemSpacingAfter(timeLabel.trailingAnchor, multiplier: 1.0)
    ]
    largeTextConstraints = [
      dateLabel.topAnchor.constraintEqualToSystemSpacingBelow(contentView.topAnchor, multiplier: 1.0),
      doctorNameLabel.firstBaselineAnchor.constraintEqualToSystemSpacingBelow(dateLabel.lastBaselineAnchor, multiplier: 1.0),
      timeLabel.firstBaselineAnchor.constraintEqualToSystemSpacingBelow(doctorNameLabel.lastBaselineAnchor, multiplier: 1.0),

      doctorNameLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
      timeLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),

      contentView.trailingAnchor.constraint(greaterThanOrEqualTo: dateLabel.trailingAnchor),
      contentView.trailingAnchor.constraint(greaterThanOrEqualTo: doctorNameLabel.trailingAnchor),
      contentView.trailingAnchor.constraint(greaterThanOrEqualTo: timeLabel.trailingAnchor)
    ]
  }
}
