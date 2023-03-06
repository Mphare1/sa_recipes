enum Complexity {
  Simple,
  Challenging,
  Hard,
}

class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final Duration duration;
  final Complexity complexity;
  final double cost;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.cost,
  });

  List<String> getIngredients() {
    return ingredients;
  }
}
