class Flavor {
  final String id;
  final String name;
  bool isSelected;

  Flavor({
    required this.id,
    required this.name,
    this.isSelected = false,
  });
}