class Transaction {
  final String title;
  final double cost;
  final String Id;
  final DateTime transactionDate;

  Transaction(
      {required this.Id,
      required this.title,
      required this.cost,
      required this.transactionDate});
}
