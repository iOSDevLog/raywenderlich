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
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import UIKit

class AccountTableViewCell: UITableViewCell {
  private lazy var contentStackView: UIStackView = {
    var stackView = UIStackView(arrangedSubviews: [labelStackView])
    stackView.axis = .horizontal
    return stackView
  }()

  private lazy var labelStackView: UIStackView = {
    var stackView = UIStackView(arrangedSubviews: [nameLabel,
                                                   phoneNumberLabel,
                                                   emailLabel])
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    return stackView
  }()

  let nameLabel: UILabel = {
    var label = UILabel()
    label.text = "John Doe"
    return label
  }()

  let phoneNumberLabel: UILabel = {
    var label = UILabel()
    label.text = "(000) 000-0000"
    return label
  }()

  let emailLabel: UILabel = {
    var label = UILabel()
    label.text = "address@email.com"
    return label
  }()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(contentStackView)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    contentStackView.frame = contentView.bounds
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not supported by this class.")
  }
}

