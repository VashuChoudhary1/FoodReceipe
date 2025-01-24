class RecipeModal {
  late String applabel;
  late String appImgUrl;
  late String appCategory;
  late String appInstruction; //youtube url

  RecipeModal(
      {this.applabel = "LABEL",
      this.appImgUrl = "IMAGE",
      this.appCategory = "CATEGORY",
      this.appInstruction = "INSTRUCTIONS"});
  factory RecipeModal.fromMap(Map recipe) {
    return RecipeModal(
        applabel: recipe["strMeal"],
        appImgUrl: recipe["strMealThumb"],
        appCategory: recipe["strCategory"],
        appInstruction: recipe["strInstructions"]);
  }
}
