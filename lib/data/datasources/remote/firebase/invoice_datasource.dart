import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../models/invoice_model.dart';
import '../../../../models/base/entity_status.dart';
import '../../base/base_firestore_datasource.dart';
import '../../../../core/services/document_number_service.dart';

class InvoiceDataSource
    implements BaseFirestoreDataSource<InvoiceModel> {
  InvoiceDataSource({
    FirebaseFirestore? firestore,
    required DocumentNumberService documentNumberService,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _documentNumberService = documentNumberService;

  final FirebaseFirestore _firestore;
  final DocumentNumberService _documentNumberService;

  CollectionReference<Map<String, dynamic>> _invoiceCollection(
      String gymId,
      ) {
    return _firestore
        .collection(FirestorePaths.gyms)
        .doc(gymId)
        .collection(FirestorePaths.invoices);
  }

  @override
  Future<void> create(
      String gymId,
      InvoiceModel invoice,
      ) async {
    final doc = _invoiceCollection(gymId).doc();

    await doc.set(
      InvoiceModel(
        invoiceId: doc.id,
        invoiceNumber: invoice.invoiceNumber,
        invoiceType: invoice.invoiceType,
        memberId: invoice.memberId,
        customerId: invoice.customerId,
        supplierId: invoice.supplierId,
        customerName: invoice.customerName,
        customerPhone: invoice.customerPhone,
        customerEmail: invoice.customerEmail,
        customerAddress: invoice.customerAddress,
        customerGstin: invoice.customerGstin,
        invoiceDate: invoice.invoiceDate,
        dueDate: invoice.dueDate,
        subtotal: invoice.subtotal,
        discountAmount: invoice.discountAmount,
        discountPercentage: invoice.discountPercentage,
        taxableAmount: invoice.taxableAmount,
        cgstAmount: invoice.cgstAmount,
        sgstAmount: invoice.sgstAmount,
        igstAmount: invoice.igstAmount,
        taxAmount: invoice.taxAmount,
        grandTotal: invoice.grandTotal,
        receivedAmount: invoice.receivedAmount,
        balanceAmount: invoice.balanceAmount,
        paymentStatus: invoice.paymentStatus,
        paymentMethod: invoice.paymentMethod,
        amountInWords: invoice.amountInWords,
        notes: invoice.notes,
        version: invoice.version,
        tenantInfo: invoice.tenantInfo,
        auditInfo: invoice.auditInfo,
        status: invoice.status,
      ).toMap(),
    );
  }

  @override
  Future<void> update(
      String gymId,
      InvoiceModel invoice,
      ) async {
    await _invoiceCollection(gymId)
        .doc(invoice.invoiceId)
        .update(invoice.toMap());
  }

  @override
  Future<InvoiceModel?> get(
      String gymId,
      String invoiceId,
      ) async {
    final document = await _invoiceCollection(gymId)
        .doc(invoiceId)
        .get();

    if (!document.exists || document.data() == null) {
      return null;
    }

    return InvoiceModel.fromMap(
      document.data()!,
      document.id,
    );
  }
  ///===========================================================
  /// Get All Invoices
  ///===========================================================
  @override
  Future<List<InvoiceModel>> getAll(
      String gymId,
      ) async {
    final snapshot = await _invoiceCollection(gymId)
        .orderBy('invoiceDate', descending: true)
        .get();

    return snapshot.docs
        .map(
          (doc) => InvoiceModel.fromMap(
        doc.data(),
        doc.id,
      ),
    )
        .toList();
  }
  ///===========================================================
  /// Soft Delete Invoice
  ///===========================================================
  @override
  Future<void> softDelete(
      String gymId,
      String invoiceId,
      ) async {
    await _invoiceCollection(gymId)
        .doc(invoiceId)
        .update({
      'status': EntityStatus.inactive.name,
      'updatedAt': Timestamp.now(),
    });
  }
  Future<String> generateInvoiceNumber(
      String gymId,
      ) {
    return _documentNumberService.generateNumber(
      gymId: gymId,
      documentType: 'invoice',
      prefix: 'INV',
    );
  }
}