import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/elasticSearchModel.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

class ElasticSearchProvider {
  Client _client = new Client();

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

    final response =
        await _client.post(ELASTIC_SEARCH_URL, headers: header, body: json.encode(body));

    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      return compute(elasticSearchModelFromJson, response.body);
    }
    return null;
  }
}
