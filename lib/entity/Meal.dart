class Meal {
  String description;
  String cost;
  DateTime time;
  String food;
  String location;
  String meal;

  Meal(
      {this.description,
      this.cost,
      this.time,
      this.food,
      this.meal,
      this.location});

  void printElements() {
    print(
        "desc: $description , cost: $cost , food: $food , mealtype: $location , mea: $meal");
  }
}
