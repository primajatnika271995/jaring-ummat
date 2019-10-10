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
    String userEmail;
    String userStreetAddress;
    String userId;
    DateTime timestamp;
    List<Image> images;
    String id;
    String userContact;
    String description;
    String type;
    dynamic totalDonation;
    DateTime createdDate;
    DateTime endDate;
    String version;
    String title;
    dynamic targetDonation;
    String userName;
    String userCategory;
    String createdBy;
    String category;
    int elasticIndex;

    Source({
        this.userEmail,
        this.userStreetAddress,
        this.userId,
        this.timestamp,
        this.images,
        this.id,
        this.userContact,
        this.description,
        this.type,
        this.totalDonation,
        this.createdDate,
        this.endDate,
        this.version,
        this.title,
        this.targetDonation,
        this.userName,
        this.userCategory,
        this.createdBy,
        this.category,
        this.elasticIndex,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        userEmail: json["user_email"] == null ? null : json["user_email"],
        userStreetAddress: json["user_street_address"] == null ? null : json["user_street_address"],
        userId: json["user_id"] == null ? null : json["user_id"],
        timestamp: json["@timestamp"] == null ? null : DateTime.parse(json["@timestamp"]),
        images: json["images"] == null ? null : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        id: json["id"] == null ? null : json["id"],
        userContact: json["user_contact"] == null ? null : json["user_contact"],
        description: json["description"] == null ? null : json["description"],
        type: json["type"] == null ? null : json["type"],
        totalDonation: json["total_donation"] == null ? null : json["total_donation"],
        createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        version: json["@version"] == null ? null : json["@version"],
        title: json["title"] == null ? null : json["title"],
        targetDonation: json["target_donation"] == null ? null : json["target_donation"],
        userName: json["user_name"] == null ? null : json["user_name"],
        userCategory: json["user_category"] == null ? null : json["user_category"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        category: json["category"] == null ? null : json["category"],
        elasticIndex: json["elastic_index"] == null ? null : json["elastic_index"],
    );

    Map<String, dynamic> toJson() => {
        "user_email": userEmail == null ? null : userEmail,
        "user_street_address": userStreetAddress == null ? null : userStreetAddress,
        "user_id": userId == null ? null : userId,
        "@timestamp": timestamp == null ? null : timestamp.toIso8601String(),
        "images": images == null ? null : List<dynamic>.from(images.map((x) => x.toJson())),
        "id": id == null ? null : id,
        "user_contact": userContact == null ? null : userContact,
        "description": description == null ? null : description,
        "type": type == null ? null : type,
        "total_donation": totalDonation == null ? null : totalDonation,
        "created_date": createdDate == null ? null : createdDate.toIso8601String(),
        "end_date": endDate == null ? null : endDate.toIso8601String(),
        "@version": version == null ? null : version,
        "title": title == null ? null : title,
        "target_donation": targetDonation == null ? null : targetDonation,
        "user_name": userName == null ? null : userName,
        "user_category": userCategory == null ? null : userCategory,
        "created_by": createdBy == null ? null : createdBy,
        "category": category == null ? null : category,
        "elastic_index": elasticIndex == null ? null : elasticIndex,
    };
}

class Image {
    String fileThumbnailUrl;
    String fileResourceType;
    String fileId;
    String fileFormat;
    String fileCreatedBy;
    String fileUrlType;
    String fileUrl;
    DateTime fileCreatedDate;

    Image({
        this.fileThumbnailUrl,
        this.fileResourceType,
        this.fileId,
        this.fileFormat,
        this.fileCreatedBy,
        this.fileUrlType,
        this.fileUrl,
        this.fileCreatedDate,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        fileThumbnailUrl: json["file_thumbnail_url"] == null ? null : json["file_thumbnail_url"],
        fileResourceType: json["file_resource_type"] == null ? null : json["file_resource_type"],
        fileId: json["file_id"] == null ? null : json["file_id"],
        fileFormat: json["file_format"] == null ? null : json["file_format"],
        fileCreatedBy: json["file_created_by"] == null ? null : json["file_created_by"],
        fileUrlType: json["file_url_type"] == null ? null : json["file_url_type"],
        fileUrl: json["file_url"] == null ? null : json["file_url"],
        fileCreatedDate: json["file_created_date"] == null ? null : DateTime.parse(json["file_created_date"]),
    );

    Map<String, dynamic> toJson() => {
        "file_thumbnail_url": fileThumbnailUrl == null ? null : fileThumbnailUrl,
        "file_resource_type": fileResourceType == null ? null : fileResourceType,
        "file_id": fileId == null ? null : fileId,
        "file_format": fileFormat == null ? null : fileFormat,
        "file_created_by": fileCreatedBy == null ? null : fileCreatedBy,
        "file_url_type": fileUrlType == null ? null : fileUrlType,
        "file_url": fileUrl == null ? null : fileUrl,
        "file_created_date": fileCreatedDate == null ? null : fileCreatedDate.toIso8601String(),
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
