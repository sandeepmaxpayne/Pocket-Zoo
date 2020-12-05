class PocketModal {
  String name;
  String image;
  String height;
  String weight;
  String type;
  String weakness;

  PocketModal(this.name, this.image, this.height, this.weight, this.weakness,
      this.type);

  factory PocketModal.fromJson(dynamic json) {
    //parameters must be same as json String value from URL get
    return PocketModal(
      "${json['name']}",
      "${json['image']}",
      "${json['height']}",
      "${json['weight']}",
      "${json['weakness']}",
      "${json['type']}",
    );
  }

  //method to get parameters
  Map toJson() => {
        'name': name,
        'image': image,
        'height': height,
        'weight': weight,
        'type': type,
        'weakness': weakness,
      };
}
