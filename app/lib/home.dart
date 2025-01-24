import 'package:app/modals.dart';
import 'package:app/recipeView.dart';
import 'package:app/search.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<RecipeModal> recipeList = <RecipeModal>[];
  TextEditingController searchController = TextEditingController();

  getReceipe() async {
    String url = "https://www.themealdb.com/api/json/v1/1/random.php";

    try {
      recipeList.clear();
      for (int i = 0; i < 10; i++) {
        var response = await http.get(Uri.parse(url));
        Map data = jsonDecode(response.body);

        // Successfully fetched data
        if (data["meals"] != null) {
          data["meals"].forEach((element) {
            RecipeModal recipeModal = RecipeModal();
            recipeModal = RecipeModal.fromMap(element);
            recipeList.add(recipeModal);
          });
        } else {
          print("No meals found for query");
        }
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching or processing data: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReceipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 138, 5),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff213A50), Color(0xff071938)])),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Search Bar
                      SafeArea(
                        child: Container(
                          //Search Wala Container

                          padding: EdgeInsets.symmetric(horizontal: 8),
                          margin: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24)),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if ((searchController.text)
                                          .replaceAll(" ", "") ==
                                      "") {
                                    print("Blank search");
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Search(searchController.text)));
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Let's Cook Something!"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "WHAT DO YOU WANT TO COOK",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Let's cook something new ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))
                          ],
                        ),
                      ),
                      Container(
                        child: isLoading
                            ? CircularProgressIndicator()
                            : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: recipeList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Recipeview(
                                                  recipeList[index])));
                                    },
                                    child: Card(
                                        margin: EdgeInsets.all(10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        elevation: 0.0,
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
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
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.black26),
                                                    child: Text(
                                                      recipeList[index]
                                                          .applabel,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ))),
                                            Positioned(
                                              right: 0,
                                              width: 100,
                                              height: 30,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                      )),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .local_fire_department,
                                                          size: 15,
                                                        ),
                                                        Text(recipeList[index]
                                                            .appCategory),
                                                      ],
                                                    ),
                                                  )),
                                            )
                                          ],
                                        )),
                                  );
                                }),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                color: const Color(0xff071938),
                alignment: Alignment.bottomCenter,
                child: ListView.builder(
                  itemCount: recipeList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Recipeview(recipeList[index])));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 0.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18.0),
                            child: Container(
                              height: 80,
                              width: 150,
                              color: const Color.fromARGB(255, 221, 218, 209),
                              child: Center(
                                child: Text(
                                  recipeList[index].appCategory,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
