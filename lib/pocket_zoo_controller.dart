import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:pokemon_data_app/pocket_zoo_modal.dart';

class PocketController {
  // Google App Script Web URL
  //TODO url
  static const String URL =
      "https://script.google.com/macros/s/AKfycbxUOIA0pIPCD-xuoRar8tWufyqaQgEltrZUWCar4uZphOeI6as/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  ///async function which saves the form data , parses [FeedForm] parameters
  ///and sends HTTP GET request on [URL]. on success [callback] is called.

  void submitForm(PocketModal feedForm, void Function(String) callback) async {
    try {
      await http.post(URL, body: feedForm.toJson()).then((response) async {
        print("response code:${response.statusCode}");
      //  print("URL: $URL");
        if (response.statusCode == 302) {

          var url = response.headers['location'];
          await http.get(url).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (ex) {
      print("exception occurred in webapp: $ex");
    }
  }

  //Method to get the users data
  Future<List<PocketModal>> getFeedList() async {
    return await http.get(URL).then((response) {
      var jsonFeedResult = convert.jsonDecode(response.body) as List;
      print(
          "response: ${jsonFeedResult.map((v) => PocketModal.fromJson(v).toJson())}");

      return jsonFeedResult.map((json) => PocketModal.fromJson(json)).toList();
    });
  }
}
