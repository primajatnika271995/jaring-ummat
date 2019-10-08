import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/elasticSearchAutocompleteModel.dart';
import 'package:flutter_jaring_ummat/src/models/elasticSearchModel.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

class ElasticSearchProvider {
  Client _client = new Client();

  Future<List<String>> fetchAutoCompleteManual(String dataSearch) async {
    List<String> matches = List();

    //  Headers
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    Map body = {
      "query": {
        "match_phrase_prefix": {"title": dataSearch}
      },
      "size": 0,
      "aggs": {
        "title_sugestion": {
          "terms": {"size": 10, "field": "title.keyword"}
        },
        "description_sugestion": {
          "terms": {"size": 10, "field": "description.keyword"}
        }
      }
    };

    final response = await _client.post(ELASTIC_SEARCH_URL, headers: header, body: json.encode(body));
    print("Ini data Yang dicari ==>");
    print(dataSearch);
    if (response.statusCode == 200) {
      var value = elasticSearchAutoCompleteModelFromJson(response.body);
      print("ini hasil nya =>");
      value.aggregations.descriptionSugestion.buckets.forEach((f) {
        matches.add(f.key);
      });
      value.aggregations.titleSugestion.buckets.forEach((z) {
        matches.add(z.key);
      });

      print(matches.length);
      return matches;
    }
    return null;
  }

  Future<ElasticSearchModel> fetchElasticSearch(String dataSearch) async {
    //  Headers
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    // Parameter Body
    Map body = {
      "query": {
        "multi_match": {
          "type": "best_fields",
          "query": dataSearch,
          "analyzer": "standard",
          "fields": [
            "user_email",
            "user_name",
            "user_category",
            "title",
            "description",
            "category"
          ]
        }
      }
    };

    final response = await _client.post(ELASTIC_SEARCH_URL,
        headers: header, body: json.encode(body));

    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      return compute(elasticSearchModelFromJson, response.body);
    }
    return null;
  }
}
