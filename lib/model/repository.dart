import 'dart:async';
import 'dart:convert';

import 'package:utopian_rocks/model/model.dart';

import 'package:http/http.dart' show Client;

class Api {
  final Client _client = Client();
  // static url for the API endpoint
  static const String _url = 'https://utopian.rocks/api/posts?status={0}';

  // grab the contributions from the endpoint based on the tabname.
  Future<List<Contribution>> updateContributions(String tabName) async {
    List<Contribution> items = [];
    await _client
        // add the tabname to the url to change the API endpoint based on the page request
        // Decode the json and then serialize it into [Contribution] objects.
        .get(Uri.parse(_url.replaceFirst("{0}", tabName ?? "unreviewed")))
        .then((res) => res.body)
        .then(json.decode)
        .then((json) => json.forEach(
            (contribution) => items.add(Contribution.fromJson(contribution))));

    return items;
  }
}
