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

private extension String {
  static let doctorSegue = "doctorDetail"
}

class AppointmentsViewController: UITableViewController {
  var appointments: [Appointment]? {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let primaryCareDoctor = Doctor(name: "Dr. General", phone: "555-123-4321", address: "123 Main St, Suite 250", city: "Frisco", state: "TX", zip: "75034", notes: "Office hours MTW 9:00 am - 2:00 pm", image: #imageLiteral(resourceName: "profile"))
    let specialist = Doctor(name: "Dr. Specialist", phone: "321-555-1234", address: "321 Central Ave", city: "Dallas", state: "TX", zip: "75001", notes: "Does surgery on Thursday", image: #imageLiteral(resourceName: "profile"))
    appointments = [Appointment(dateTime: DateComponents(calendar: .current, year: 2017, month: 6, day: 1, hour: 12, minute: 30).date!, doctor: primaryCareDoctor),
                    Appointment(dateTime: DateComponents(calendar: .current, year: 2017, month: 7, day: 15, hour: 15, minute: 45).date!, doctor: specialist)]
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == .doctorSegue {
      guard let cell = sender as? AppointmentCell,
        let appointment = cell.appointment,
        let controller = segue.destination as? DoctorViewController else { fatalError() }
      
      controller.doctor = appointment.doctor
    }
  }
}

extension AppointmentsViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return appointments?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentCell.cellIdentifier, for: indexPath) as? AppointmentCell else { fatalError() }
    guard let appointment = appointments?[indexPath.row] else { fatalError() }
    cell.appointment = appointment
    return cell
  }
}
