//===----------------------------------------------------------------------===//
//
// This source file is part of the CosmsosSwift/ABCI open source project
//
// Copyright (c) 2019 CosmsosSwift/ABCI project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of CosmsosSwift/ABCI project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import Foundation
import SwiftProtobuf

public class Evidence {
    public let type: String
    public let validator: Validator
    public let height: Int64
    public let time: Date
    public let totalVotingPower: Int64
    
    public init(_ type: String, _ validator: Validator, _ height: Int64, _ time: Date, _ totalVotingPower: Int64) {
        self.type = type
        self.validator = validator
        self.height = height
        self.time = time
        self.totalVotingPower = totalVotingPower
    }
}

extension Evidence {
    convenience init(protobuf: Types_Evidence) {
        self.init(protobuf.type, Validator(protobuf: protobuf.validator), protobuf.height, protobuf.time.date, protobuf.totalVotingPower)
    }
}

extension Types_Evidence {
    init(_ e: Evidence) {
        self.type = e.type
        self.validator = Types_Validator(e.validator)
        self.height = e.height
        self.time = Google_Protobuf_Timestamp(date: e.time)
        self.totalVotingPower = e.totalVotingPower
    }
}
