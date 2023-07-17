class RecordDTO {
  final String _id;
  String? date;
  String? name;
  String? type;
  double? amount;
  String? description;

  static String expenseKey = "expense";
  static String incomeKey  = "income";

  RecordDTO(this._id, String this.name, String this.type, double this.amount, String this.date, String this.description);

  String getId(){
    return _id;
  }
}