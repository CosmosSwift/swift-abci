public enum Method: String, Codable {
    case abci_query
    case tx
    
}


//import ABCIMessages
//
//public enum Method: Codable {
//    case abci_query(RequestQuery)
//    
//    
//    
//    var string: String {
//        switch self {
//        case abci_query:
//            return "abci_query"
//    }
//    }
//}
