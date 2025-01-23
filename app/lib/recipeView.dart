import 'dart:async';
import 'dart:convert';

import 'package:app/modals.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class Recipeview extends StatefulWidget {
  String url;
  Recipeview(this.url, {super.key});

  @override
  State<Recipeview> createState() => _RecipeviewState();
}

class _RecipeviewState extends State<Recipeview> {
  List<RecipeModal> recipeList = <RecipeModal>[];
  getReceipe(String query) async {
    String url = "https://www.themealdb.com/api/json/v1/1/search.php?s=$query";

    try {
      var response = await http.get(Uri.parse(url));
      Map data = jsonDecode(response.body);
      recipeList.clear();
      // Successfully fetched data
      if (data["meals"] != null) {
        data["meals"].forEach((element) {
          RecipeModal recipeModal = RecipeModal();
          recipeModal = RecipeModal.fromMap(element);
          recipeList.add(recipeModal);
        });
        for (var recipe in recipeList) {
          print(recipe.applabel);
        }
      } else {
        print("No meals found for query: $query");
      }
    } catch (e) {
      print("Error fetching or processing data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Food Recipe App"),
        ),
        body: Column(children: [
          Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0.0,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      recipeList[index].appImgUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(color: Colors.black26),
                          child: Text(
                            recipeList.applabel,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ))),
                  Positioned(
                    right: 0,
                    width: 100,
                    height: 30,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            )),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_fire_department,
                                size: 15,
                              ),
                              Text(recipeList[index].appCategory),
                            ],
                          ),
                        )),
                  )
                ],
              )),
        ]));
  }
}
