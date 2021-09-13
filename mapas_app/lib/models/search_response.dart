import 'dart:convert';

SearchResponse searchResponseFromJson(String str) => SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
    SearchResponse({
        required this.type,
        required this.query,
        required this.features,
        required this.attribution,
    });

    final String type;
    final List<String> query;
    final List<Feature> features;
    final String attribution;

    factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
    };
}

class Feature {
    Feature({
        required this.id,
        required this.type,
        required this.placeType,
        required this.relevance,
        required this.properties,
        required this.text,
        required this.placeName,
        required this.bbox,
        required this.center,
        required this.geometry,
        required this.context,
    });

    final String id;
    final String type;
    final List<String> placeType;
    final int relevance;
    final Properties properties;
    final String text;
    final String placeName;
    final List<double>? bbox;
    final List<double> center;
    final Geometry geometry;
    final List<Context> context;

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"],
        properties: Properties.fromJson(json["properties"]),
        text: json["text"],
        placeName: json["place_name"],
        bbox: json["bbox"] == null ? null : List<double>.from(json["bbox"].map((x) => x.toDouble())),
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context: List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "relevance": relevance,
        "properties": properties.toJson(),
        "text": text,
        "place_name": placeName,
        "bbox": bbox == null ? null : List<dynamic>.from(bbox!.map((x) => x)),
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "context": List<dynamic>.from(context.map((x) => x.toJson())),
    };
}

class Context {
    Context({
        required this.id,
        required this.wikidata,
        required this.shortCode,
        required this.text,
    });

    final Id? id;
    final Wikidata? wikidata;
    final String? shortCode;
    final Text? text;

    factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: idValues.map[json["id"]],
        wikidata: wikidataValues.map[json["wikidata"]],
        shortCode: json["short_code"] == null ? null : json["short_code"],
        text: textValues.map[json["text"]],
    );

    Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "wikidata": wikidataValues.reverse[wikidata],
        "short_code": shortCode == null ? null : shortCode,
        "text": textValues.reverse[text],
    };
}

enum Id { REGION_8442099956787650, COUNTRY_9654124497801190, PLACE_9669980782787650 }

final idValues = EnumValues({
    "country.9654124497801190": Id.COUNTRY_9654124497801190,
    "place.9669980782787650": Id.PLACE_9669980782787650,
    "region.8442099956787650": Id.REGION_8442099956787650
});

enum Text { SANTA_FE, ARGENTINA }

final textValues = EnumValues({
    "Argentina": Text.ARGENTINA,
    "Santa Fe": Text.SANTA_FE
});

enum Wikidata { Q44823, Q414, Q44244 }

final wikidataValues = EnumValues({
    "Q414": Wikidata.Q414,
    "Q44244": Wikidata.Q44244,
    "Q44823": Wikidata.Q44823
});

class Geometry {
    Geometry({
        required this.type,
        required this.coordinates,
    });

    final String type;
    final List<double> coordinates;

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}

class Properties {
    Properties({
        required this.wikidata,
        required this.shortCode,
        required this.foursquare,
        required this.landmark,
        required this.address,
        required this.category,
    });

    final Wikidata? wikidata;
    final String? shortCode;
    final String? foursquare;
    final bool? landmark;
    final String? address;
    final String? category;

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        wikidata: json["wikidata"] == null ? null : wikidataValues.map[json["wikidata"]],
        shortCode: json["short_code"] == null ? null : json["short_code"],
        foursquare: json["foursquare"] == null ? null : json["foursquare"],
        landmark: json["landmark"] == null ? null : json["landmark"],
        address: json["address"] == null ? null : json["address"],
        category: json["category"] == null ? null : json["category"],
    );

    Map<String, dynamic> toJson() => {
        "wikidata": wikidata == null ? null : wikidataValues.reverse[wikidata],
        "short_code": shortCode == null ? null : shortCode,
        "foursquare": foursquare == null ? null : foursquare,
        "landmark": landmark == null ? null : landmark,
        "address": address == null ? null : address,
        "category": category == null ? null : category,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
