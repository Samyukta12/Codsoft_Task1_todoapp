// class Model {
//
//   String ? description;
//   bool check =false;
//   Model(this.description,this.check);
// }
class Model {
  String? description;
  bool check = false;
  // DateTime dates;
  String ? optionaldiscription;




  Model(this.description, this.check, this.optionaldiscription
      );

  // Convert Model object to a Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'description': description,

      'check': check,
      // 'dates': dates,
      'title':optionaldiscription
    };
  }

  // Create a Model object from a Map for deserialization
  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      map['description'],
      map['check'],
      // map['dates'],
      map['title'],
    );
  }
}
