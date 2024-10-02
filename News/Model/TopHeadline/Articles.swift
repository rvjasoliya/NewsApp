import Foundation
import ObjectMapper

struct Articles : Mappable {
    
	var source : Source?
	var author : String?
	var title : String?
	var description : String?
	var url : String?
	var urlToImage : String?
	var publishedAt : String?
	var content : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
		source <- map["source"]
		author <- map["author"]
		title <- map["title"]
		description <- map["description"]
		url <- map["url"]
		urlToImage <- map["urlToImage"]
		publishedAt <- map["publishedAt"]
		content <- map["content"]
	}

}
