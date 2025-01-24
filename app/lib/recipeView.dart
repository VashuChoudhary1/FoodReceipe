import 'dart:async';
import 'dart:convert';

import 'package:app/modals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Recipeview extends StatelessWidget {
  final RecipeModal recipe; // Change this line to accept RecipeModal

  Recipeview(this.recipe, {super.key}); // Change this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Recipe App"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff213A50), Color(0xff071938)])),
        child: SingleChildScrollView(
          child: Column(children: [
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
                      recipe.appImgUrl, // Use recipe's image URL
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
                        recipe.applabel, // Use recipe's label
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
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
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              size: 15,
                            ),
                            Text(recipe.appCategory), // Use recipe's category
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                recipe.appInstruction,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
