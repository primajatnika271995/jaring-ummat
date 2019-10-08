// To parse this JSON data, do
//
//     final elasticSearchAutoCompleteModel = elasticSearchAutoCompleteModelFromJson(jsonString);

import 'dart:convert';

ElasticSearchAutoCompleteModel elasticSearchAutoCompleteModelFromJson(String str) => ElasticSearchAutoCompleteModel.fromJson(json.decode(str));

String elasticSearchAutoCompleteModelToJson(ElasticSearchAutoCompleteModel data) => json.encode(data.toJson());

class ElasticSearchAutoCompleteModel {
    int took;
    bool timedOut;
    Shards shards;
    Hits hits;
    Aggregations aggregations;

    ElasticSearchAutoCompleteModel({
        this.took,
        this.timedOut,
        this.shards,
        this.hits,
        this.aggregations,
    });

    factory ElasticSearchAutoCompleteModel.fromJson(Map<String, dynamic> json) => ElasticSearchAutoCompleteModel(
        took: json["took"] == null ? null : json["took"],
        timedOut: json["timed_out"] == null ? null : json["timed_out"],
        shards: json["_shards"] == null ? null : Shards.fromJson(json["_shards"]),
        hits: json["hits"] == null ? null : Hits.fromJson(json["hits"]),
        aggregations: json["aggregations"] == null ? null : Aggregations.fromJson(json["aggregations"]),
    );

    Map<String, dynamic> toJson() => {
        "took": took == null ? null : took,
        "timed_out": timedOut == null ? null : timedOut,
        "_shards": shards == null ? null : shards.toJson(),
        "hits": hits == null ? null : hits.toJson(),
        "aggregations": aggregations == null ? null : aggregations.toJson(),
    };
}

class Aggregations {
    Sugestion descriptionSugestion;
    Sugestion titleSugestion;

    Aggregations({
        this.descriptionSugestion,
        this.titleSugestion,
    });

    factory Aggregations.fromJson(Map<String, dynamic> json) => Aggregations(
        descriptionSugestion: json["description_sugestion"] == null ? null : Sugestion.fromJson(json["description_sugestion"]),
        titleSugestion: json["title_sugestion"] == null ? null : Sugestion.fromJson(json["title_sugestion"]),
    );

    Map<String, dynamic> toJson() => {
        "description_sugestion": descriptionSugestion == null ? null : descriptionSugestion.toJson(),
        "title_sugestion": titleSugestion == null ? null : titleSugestion.toJson(),
    };
}

class Sugestion {
    int docCountErrorUpperBound;
    int sumOtherDocCount;
    List<Bucket> buckets;

    Sugestion({
        this.docCountErrorUpperBound,
        this.sumOtherDocCount,
        this.buckets,
    });

    factory Sugestion.fromJson(Map<String, dynamic> json) => Sugestion(
        docCountErrorUpperBound: json["doc_count_error_upper_bound"] == null ? null : json["doc_count_error_upper_bound"],
        sumOtherDocCount: json["sum_other_doc_count"] == null ? null : json["sum_other_doc_count"],
        buckets: json["buckets"] == null ? null : List<Bucket>.from(json["buckets"].map((x) => Bucket.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "doc_count_error_upper_bound": docCountErrorUpperBound == null ? null : docCountErrorUpperBound,
        "sum_other_doc_count": sumOtherDocCount == null ? null : sumOtherDocCount,
        "buckets": buckets == null ? null : List<dynamic>.from(buckets.map((x) => x.toJson())),
    };
}

class Bucket {
    String key;
    int docCount;

    Bucket({
        this.key,
        this.docCount,
    });

    factory Bucket.fromJson(Map<String, dynamic> json) => Bucket(
        key: json["key"] == null ? null : json["key"],
        docCount: json["doc_count"] == null ? null : json["doc_count"],
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "doc_count": docCount == null ? null : docCount,
    };
}

class Hits {
    Total total;
    dynamic maxScore;
    List<dynamic> hits;

    Hits({
        this.total,
        this.maxScore,
        this.hits,
    });

    factory Hits.fromJson(Map<String, dynamic> json) => Hits(
        total: json["total"] == null ? null : Total.fromJson(json["total"]),
        maxScore: json["max_score"],
        hits: json["hits"] == null ? null : List<dynamic>.from(json["hits"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "total": total == null ? null : total.toJson(),
        "max_score": maxScore,
        "hits": hits == null ? null : List<dynamic>.from(hits.map((x) => x)),
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
