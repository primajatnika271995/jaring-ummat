import 'package:flutter_jaring_ummat/src/models/requestVAModel.dart';
import 'package:flutter_jaring_ummat/src/services/requestVA.dart';

class RequestVARepository {
  final provider = RequestVAProvider();
  Future<RequestVaModel> requestVAAnonimous(double amount,
      String customerEmail,
      String customerName,
      String customerPhone,
      String transactionId,
      String transactionType) => provider.requestVirtualAccountAnonymous(amount, customerEmail, customerName, customerPhone, transactionId, transactionType);

  Future<RequestVaModel> requestVAoauth(double amount,
      String customerEmail,
      String customerName,
      String customerPhone,
      String transactionId,
      String transactionType) => provider.requestVirtualAccountOAuth(amount, customerEmail, customerName, customerPhone, transactionId, transactionType);

  Future pembayaran(String transaksiId, String va) => provider.pembayaran(transaksiId, va);
}