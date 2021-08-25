
class CategoryModels {
  final int id;
  final String categoryname;

  get selected => null;
  //late bool selected = false;

  //CategoryModels(this.id, this.categoryname);

  set id(int _id) {
    id = _id;
  }

  set categoryname(String _categoryname) {
    categoryname = _categoryname;
  }

  CategoryModels.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        categoryname = json['categoryname'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryname'] = this.categoryname;
    return data;
  }

  Future<Null> Edit(int id, String categoryname) async {
    print(id.toString());
    print(categoryname.toString());
  }


}
