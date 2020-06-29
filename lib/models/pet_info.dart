class PetInfo{
  int _id;
  int _petId;
  String _description;
  DateTime _date;

  PetInfo(this._petId, this._description, this._date);

  int get id => _id;
  int get petId => _petId;
  String get description => _description;
  DateTime get date => _date;

  set petId(int id){
    _petId = id;
  }

  set description(String text){
    _description = text;
  }

  set date(DateTime date){
    _date = date;
  }

  PetInfo.fromJson(Map<String, dynamic> json){
    _petId = json['petInfo'];
    _description = json['description'];
    _date = DateTime.fromMillisecondsSinceEpoch(json['date']);
  }

  Map<String, dynamic> toJson() => {
    'id': _id,
    'petInfo': _petId,
    'description': _description,
    'date': _date.millisecondsSinceEpoch
  };
}