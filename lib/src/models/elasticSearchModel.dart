// To parse this JSON data, do
//
//     final elasticSearchModel = elasticSearchModelFromJson(jsonString);

import 'dart:convert';

ElasticSearchModel elasticSearchModelFromJson(String str) => ElasticSearchModel.fromJson(json.decode(str));

String elasticSearchModelToJson(ElasticSearchModel data) => json.encode(data.toJson());

class ElasticSearchModel {
    int took;
    bool timedOut;
    Shards shards;
    Hits hits;

    ElasticSearchModel({
        this.took,
        this.timedOut,
        this.shards,
        this.hits,
    });

    factory ElasticSearchModel.fromJson(Map<String, dynamic> json) => ElasticSearchModel(
        took: json["took"] == null ? null : json["took"],
        timedOut: json["timed_out"] == null ? null : json["timed_out"],
        shards: json["_shards"] == null ? null : Shards.fromJson(json["_shards"]),
        hits: json["hits"] == null ? null : Hits.fromJson(json["hits"]),
    );

    Map<String, dynamic> toJson() => {
        "took": took == null ? null : took,
        "timed_out": timedOut == null ? null : timedOut,
        "_shards": shards == null ? null : shards.toJson(),
        "hits": hits == null ? null : hits.toJson(),
    };
}

class Hits {
    Total total;
    double maxScore;
    List<Hit> hits;

    Hits({
        this.total,
        this.maxScore,
        this.hits,
    });

    factory Hits.fromJson(Map<String, dynamic> json) => Hits(
        total: json["total"] == null ? null : Total.fromJson(json["total"]),
        maxScore: json["max_score"] == null ? null : json["max_score"].toDouble(),
        hits: json["hits"] == null ? null : List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total == null ? null : total.toJson(),
        "max_score": maxScore == null ? null : maxScore,
        "hits": hits == null ? null : List<dynamic>.from(hits.map((x) => x.toJson())),
    };
}

class Hit {
    String index;
    String type;
    String id;
    double score;
    Source source;

    Hit({
        this.index,
        this.type,
        this.id,
        this.score,
        this.source,
    });

    factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        index: json["_index"] == null ? null : json["_index"],
        type: json["_type"] == null ? null : json["_type"],
        id: json["_id"] == null ? null : json["_id"],
        score: json["_score"] == null ? null : json["_score"].toDouble(),
        source: json["_source"] == null ? null : Source.fromJson(json["_source"]),
    );

    Map<String, dynamic> toJson() => {
        "_index": index == null ? null : index,
        "_type": type == null ? null : type,
        "_id": id == null ? null : id,
        "_score": score == null ? null : score,
        "_source": source == null ? null : source.toJson(),
    };
}

class Source {
    String userCategory;
    String userEmail;
    String title;
    String description;
    String userContact;
    DateTime createdDate;
    double targetDonation;
    DateTime endDate;
    String createdBy;
    DateTime timestamp;
    String version;
    String type;
    String userId;
    double totalDonation;
    String id;
    String userStreetAddress;
    String userName;
    String category;
    int elasticIndex;

    Source({
        this.userCategory,
        this.userEmail,
        this.title,
        this.description,
        this.userContact,
        this.createdDate,
        this.targetDonation,
        this.endDate,
        this.createdBy,
        this.timestamp,
        this.version,
        this.type,
        this.userId,
        this.totalDonation,
        this.id,
        this.userStreetAddress,
        this.userName,
        this.category,
        this.elasticIndex,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        userCategory: json["user_category"] == null ? null : json["user_category"],
        userEmail: json["user_email"] == null ? null : json["user_email"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        userContact: json["user_contact"] == null ? null : json["user_contact"],
        createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
        targetDonation: json["target_donation"] == null ? null : json["target_donation"],
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        createdBy: json["created_by"] == null ? null : json["created_by"],
        timestamp: json["@timestamp"] == null ? null : DateTime.parse(json["@timestamp"]),
        version: json["@version"] == null ? null : json["@version"],
        type: json["type"] == null ? null : json["type"],
        userId: json["user_id"] == null ? null : json["user_id"],
        totalDonation: json["total_donation"] == null ? null : json["total_donation"],
        id: json["id"] == null ? null : json["id"],
        userStreetAddress: json["user_street_address"] == null ? null : json["user_street_address"],
        userName: json["user_name"] == null ? null : json["user_name"],
        category: json["category"] == null ? null : json["category"],
        elasticIndex: json["elastic_index"] == null ? null : json["elastic_index"],
    );

    Map<String, dynamic> toJson() => {
        "user_category": userCategory == null ? null : userCategory,
        "user_email": userEmail == null ? null : userEmail,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "user_contact": userContact == null ? null : userContact,
        "created_date": createdDate == null ? null : createdDate.toIso8601String(),
        "target_donation": targetDonation == null ? null : targetDonation,
        "end_date": endDate == null ? null : endDate.toIso8601String(),
        "created_by": createdBy == null ? null : createdBy,
        "@timestamp": timestamp == null ? null : timestamp.toIso8601String(),
        "@version": version == null ? null : version,
        "type": type == null ? null : type,
        "user_id": userId == null ? null : userId,
        "total_donation": totalDonation == null ? null : totalDonation,
        "id": id == null ? null : id,
        "user_street_address": userStreetAddress == null ? null : userStreetAddress,
        "user_name": userName == null ? null : userName,
        "category": category == null ? null : category,
        "elastic_index": elasticIndex == null ? null : elasticIndex,
    };
}

class Total {
    int value;
    String relation;

    Total({
        this.value,
        this.relation,
    });

    factory Total.fromJson(Map<String, dynamic> json) => Total(
        value: json["value"] == null ? null : json["value"],
        relation: json["relation"] == null ? null : json["relation"],
    );

    Map<String, dynamic> toJson() => {
        "value": value == null ? null : value,
        "relation": relation == null ? null : relation,
    };
}

class Shards {
    int total;
    int successful;
    int skipped;
    int failed;

    Shards({
        this.total,
        this.successful,
        this.skipped,
        this.failed,
    });

    factory Shards.fromJson(Map<String, dynamic> json) => Shards(
        total: json["total"] == null ? null : json["total"],
        successful: json["successful"] == null ? null : json["successful"],
        skipped: json["skipped"] == null ? null : json["skipped"],
        failed: json["failed"] == null ? null : json["failed"],
    );

    Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "successful": successful == null ? null : successful,
        "skipped": skipped == null ? null : skipped,
        "failed": failed == null ? null : failed,
    };
}
