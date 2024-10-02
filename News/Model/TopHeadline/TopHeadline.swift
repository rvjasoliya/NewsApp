import Foundation
import ObjectMapper
import SwiftyJSON

struct TopHeadline : Mappable {
    
	var status : String?
	var totalResults : Int?
	var articles : [Articles]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
		status <- map["status"]
		totalResults <- map["totalResults"]
		articles <- map["articles"]
	}
    
    static func mapTopHeadlineData(json: JSON) -> TopHeadline? {
        var costData: TopHeadline?
        costData = Mapper<TopHeadline>().map(JSONObject: json.rawValue)
        return costData
    }

}
