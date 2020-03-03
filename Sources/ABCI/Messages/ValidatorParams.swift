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

public class ValidatorParams {
    public let pubKeyTypes: [String]
    
    public init(pubKeyTypes: [String]) {
        self.pubKeyTypes = pubKeyTypes
    }
}

extension Types_ValidatorParams {
    init(_ v: ValidatorParams) {
        self.pubKeyTypes = v.pubKeyTypes
    }
}
