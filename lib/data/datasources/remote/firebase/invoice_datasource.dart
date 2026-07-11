import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/invoice_model.dart';

class InvoiceDataSource {
  InvoiceDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const String _collection = 'invoices';

  CollectionReference<Map<String, dynamic>> get _invoiceCollection =>
      _firestore.collection(_collection);