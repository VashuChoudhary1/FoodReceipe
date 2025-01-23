class RecipeModal {
  late String applabel;
  late String appImgUrl;
  late String appCategory;
  late String appUrl; //youtube url

  RecipeModal(
      {this.applabel = "LABEL",
      this.appImgUrl = "IMAGE",
      this.appCategory = "CATEGORY",
      this.appUrl = "URL"});
  factory RecipeModal.fromMap(Map recipe) {
    return RecipeModal(
        applabel: recipe["strMeal"],
        appImgUrl: recipe["strMealThumb"],
        appCategory: recipe["strCategory"],
        appUrl: recipe["strYoutube"]);
  }
}
