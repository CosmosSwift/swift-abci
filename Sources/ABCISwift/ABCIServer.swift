/*
 Copyright 2019 Alex Tran Qui (alex.tranqui@asymtech.eu)
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation
import Logging

public protocol ABCIServer {
    init( application: ABCIApplication, logger: Logger)
    func start(host: String, port: Int) throws
    func stop() throws
}

extension ABCIServer {
    public init( _ application: ABCIApplication) {
        self.init(application: application, logger: Logger(label: "ABCIServer"))
    }
    public func start() throws {
        try self.start(host: "127.0.0.1", port: 26658)
    }
    
    public func start(host: String = "127.0.0.1") throws {
        try self.start(host: host, port: 26658)
    }
    
    public func start(port: Int) throws {
        try self.start(host: "127.0.0.1", port: port)
    }

}
