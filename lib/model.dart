// class Model {
//
//   String ? description;
//   bool check =false;
//   Model(this.description,this.check);
// }
class Model {
  String? description;
  bool check = false;

  Model(this.description, this.check);

  // Convert Model object to a Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'description': description,

      'check': check,
    };
  }

  // Create a Model object from a Map for deserialization
  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      map['description'],
      map['check'],
    );
  }
}
