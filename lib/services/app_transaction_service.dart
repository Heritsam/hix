part of 'service.dart';

class AppTransactionService {
  static CollectionReference transactionCollection =
      Firestore.instance.collection('transactions');

  static Future<void> saveTransaction(AppTransaction appTransaction) async {
    await transactionCollection.document().setData({
      'userId': appTransaction.userId,
      'title': appTransaction.title,
      'subtitle': appTransaction.subtitle,
      'time': appTransaction.time,
      'total': appTransaction.total,
      'picture': appTransaction.picture,
    });
  }

  static Future<List<AppTransaction>> getTransactions(String userId) async {
    QuerySnapshot snapshot = await transactionCollection.getDocuments();

    var documents = snapshot.documents
        .where((document) => document.data['userId'] == userId);

    return documents.map((e) {
      return AppTransaction(
        userId: e.data['userId'],
        title: e.data['title'],
        subtitle: e.data['subtitle'],
        time: DateTime.fromMillisecondsSinceEpoch(
            e.data['time'].millisecondsSinceEpoch),
        total: e.data['total'],
        picture: e.data['picture'],
      );
    }).toList();
  }
}
