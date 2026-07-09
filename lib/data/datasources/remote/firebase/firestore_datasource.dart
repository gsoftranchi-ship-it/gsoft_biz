import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../models/user_model.dart';
import '../../../../models/gym_model.dart';
import '../../../../models/member_model.dart';
import '../../../../models/membership_invoice_model.dart';
import '../../../../models/membership_payment_model.dart';
import '../../../../models/purchase_model.dart';
import '../../../../models/product_model.dart';
import '../../../../core/services/document_number_service.dart';


class FirestoreDataSource {
  FirestoreDataSource({
    FirebaseFirestore? firestore,
    required DocumentNumberService documentNumberService,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _documentNumberService = documentNumberService;

  final FirebaseFirestore _firestore;
  final DocumentNumberService _documentNumberService;

  static const String _usersCollection = 'users';
  static const String _gymsCollection = 'gyms';
  static const String _membersCollection = 'members';
  static const String _systemCollection = 'system';
  static const String _memberCounterDocument = 'member_counter';
  static const String _membershipInvoicesCollection = 'membershipInvoices';
  static const String _membershipPaymentsCollection = 'membershipPayments';
  static const String _purchasesCollection = 'purchases';
  static const String _productsCollection = 'products';

  Future<UserModel?> getUser(String uid) async {
    final snapshot =
    await _firestore.collection(_usersCollection).doc(uid).get();

    if (!snapshot.exists) {
      return null;
    }

    final data = snapshot.data();

    if (data == null) {
      return null;
    }

    return UserModel.fromMap(
      data,
      snapshot.id,
    );
  }
  Future<GymModel?> getGym(
      String gymId,
      ) async {
    final snapshot =
    await _firestore
        .collection(_gymsCollection)
        .doc(gymId)
        .get();

    if (!snapshot.exists) {
      return null;
    }

    final data = snapshot.data();

    if (data == null) {
      return null;
    }

    return GymModel.fromMap(
      data,
      snapshot.id,
    );
  }
  Future<List<MemberModel>> getMembers({
    required String gymId,
  }) async {
    final snapshot = await _firestore
        .collection(_membersCollection)
        .where('gymId', isEqualTo: gymId)
        .orderBy('searchName')
        .get();

    return snapshot.docs
        .map(
          (doc) => MemberModel.fromMap(
        doc.id,
        doc.data(),
      ),
    )
        .toList();
  }
  Future<void> addMember(
      MemberModel member,
      ) async {
    final data = Map<String, dynamic>.from(member.toMap());

    data['searchName'] = member.fullName.trim().toLowerCase();

    data['version'] = 1;

    data['createdAt'] = FieldValue.serverTimestamp();

    data['updatedAt'] = FieldValue.serverTimestamp();

    await _firestore
        .collection(_membersCollection)
        .doc(member.memberId)
        .set(data);
  }
  Future<String> generateNextMemberId() async {
    final counterRef = _firestore
        .collection(_systemCollection)
        .doc(_memberCounterDocument);

    return _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(counterRef);

      int lastNumber = 0;

      if (snapshot.exists) {
        final data = snapshot.data();

        if (data != null) {
          lastNumber = (data['lastNumber'] as int?) ?? 0;
        }
      }

      final nextNumber = lastNumber + 1;

      transaction.set(
        counterRef,
        {
          'lastNumber': nextNumber,
        },
        SetOptions(merge: true),
      );

      return 'MEM${nextNumber.toString().padLeft(6, '0')}';
    });
  }
  Future<void> updateMember(
      MemberModel member,
      ) async {
    await _firestore
        .collection(_membersCollection)
        .doc(member.memberId)
        .update(member.toMap());
  }
  Future<void> deleteMember(
      String id,
      ) async {
    await _firestore
        .collection(_membersCollection)
        .doc(id)
        .delete();
  }
  Future<List<MemberModel>> searchMembers({
    required String gymId,
    required String keyword,
  }) async {
    final members = await getMembers(gymId: gymId,);

    final query = keyword.trim().toLowerCase();

    return members.where((member) {

      return member.fullName
          .toLowerCase()
          .contains(query)

          ||

          member.memberId
              .toLowerCase()
              .contains(query);

    }).toList();
  }
  Future<void> createMembershipInvoice(
      MembershipInvoiceModel invoice,
      ) async {
    final documentRef = invoice.invoiceId.isEmpty
        ? _firestore.collection(_membershipInvoicesCollection).doc()
        : _firestore
        .collection(_membershipInvoicesCollection)
        .doc(invoice.invoiceId);

    MembershipInvoiceModel finalInvoice = invoice.copyWith(
      invoiceId: documentRef.id,
    );

    if (finalInvoice.invoiceNumber.isEmpty) {
      final invoiceNumber =
      await _documentNumberService.generateNumber(
        gymId: finalInvoice.tenantInfo.gymId,
        documentType: 'membership_invoice',
        prefix: 'INV',
      );

      finalInvoice = finalInvoice.copyWith(
        invoiceNumber: invoiceNumber,
      );
    }

    await documentRef.set(finalInvoice.toMap());
  }

  Future<List<MembershipInvoiceModel>> getMembershipInvoices({
    required String gymId,
  }) async {
    final snapshot = await _firestore
        .collection(_membershipInvoicesCollection)
        .where('gymId', isEqualTo: gymId)
        .orderBy('invoiceDate', descending: true)
        .get();

    return snapshot.docs
        .map(
          (doc) => MembershipInvoiceModel.fromMap(
        doc.data(),
        doc.id,
      ),
    )
        .toList();
  }

  Future<MembershipInvoiceModel?> getMembershipInvoiceById({
    required String invoiceId,
  }) async {
    final snapshot = await _firestore
        .collection(_membershipInvoicesCollection)
        .doc(invoiceId)
        .get();

    if (!snapshot.exists) {
      return null;
    }

    final data = snapshot.data();

    if (data == null) {
      return null;
    }

    return MembershipInvoiceModel.fromMap(
      data,
      snapshot.id,
    );
  }

  Future<void> updateMembershipInvoice(
      MembershipInvoiceModel invoice,
      ) async {
    await _firestore
        .collection(_membershipInvoicesCollection)
        .doc(invoice.invoiceId)
        .update(invoice.toMap());
  }

  Future<void> deleteMembershipInvoice(
      String invoiceId,
      ) async {
    await _firestore
        .collection(_membershipInvoicesCollection)
        .doc(invoiceId)
        .delete();
  }

  Future<List<MembershipInvoiceModel>> getMemberInvoices({
    required String gymId,
    required String memberId,
  }) async {
    final snapshot = await _firestore
        .collection(_membershipInvoicesCollection)
        .where('gymId', isEqualTo: gymId)
        .where('memberId', isEqualTo: memberId)
        .orderBy('invoiceDate', descending: true)
        .get();

    return snapshot.docs
        .map(
          (doc) => MembershipInvoiceModel.fromMap(
        doc.data(),
        doc.id,
      ),
    )
        .toList();
  }

  Future<List<MembershipInvoiceModel>> getDueMembershipInvoices({
    required String gymId,
  }) async {
    final snapshot = await _firestore
        .collection(_membershipInvoicesCollection)
        .where('gymId', isEqualTo: gymId)
        .where('isPaid', isEqualTo: false)
        .orderBy('dueDate')
        .get();

    return snapshot.docs
        .map(
          (doc) => MembershipInvoiceModel.fromMap(
        doc.data(),
        doc.id,
      ),
    )
        .toList();
  }
  Future<List<MembershipPaymentModel>> getMembershipPayments({
    required String gymId,
    required String invoiceId,
  }) async {
    final snapshot = await _firestore
        .collection(_membershipPaymentsCollection)
        .where('gymId', isEqualTo: gymId)
        .where('invoiceId', isEqualTo: invoiceId)
        .orderBy('paymentDate', descending: true)
        .get();

    return snapshot.docs
        .map(
          (doc) => MembershipPaymentModel.fromMap(
        doc.data(),
        doc.id,
      ),
    )
        .toList();
  }

  Future<void> collectMembershipPayment(
      MembershipPaymentModel payment,
      ) async {
    await _firestore
        .collection(_membershipPaymentsCollection)
        .doc(payment.paymentId)
        .set(payment.toMap());
  }

  Future<double> getOutstandingAmount({
    required String gymId,
    required String memberId,
  }) async {
    final invoices = await getMemberInvoices(
      gymId: gymId,
      memberId: memberId,
    );

    double total = 0;

    for (final invoice in invoices) {
      total += invoice.dueAmount;
    }

    return total;
  }
  //==================================================
  // PURCHASES
 //==================================================

  Future<List<PurchaseModel>> getPurchases({
    required String gymId,
  }) async {
    final snapshot = await _firestore
        .collection(_purchasesCollection)
        .where('gymId', isEqualTo: gymId)
        .orderBy('purchaseDate', descending: true)
        .get();

    return snapshot.docs
        .map(
          (doc) => PurchaseModel.fromMap(
        doc.id,
        doc.data(),
      ),
    )
        .toList();
  }

  Future<PurchaseModel?> getPurchase({
    required String purchaseId,
  }) async {
    final snapshot = await _firestore
        .collection(_purchasesCollection)
        .doc(purchaseId)
        .get();

    if (!snapshot.exists) {
      return null;
    }

    final data = snapshot.data();

    if (data == null) {
      return null;
    }

    return PurchaseModel.fromMap(
      snapshot.id,
      data,
    );
  }

  Future<void> addPurchase(
      PurchaseModel purchase,
      ) async {
    await _firestore
        .collection(_purchasesCollection)
        .doc(purchase.purchaseId)
        .set(
      purchase.toMap(),
    );
  }

  Future<void> updatePurchase(
      PurchaseModel purchase,
      ) async {
    await _firestore
        .collection(_purchasesCollection)
        .doc(purchase.purchaseId)
        .update(
      purchase.toMap(),
    );
  }//==================================================
// PRODUCTS
//==================================================

  Future<List<ProductModel>> getProducts({
    required String gymId,
  }) async {
    final snapshot = await _firestore
        .collection(_productsCollection)
        .where('gymId', isEqualTo: gymId)
        .orderBy('searchName')
        .get();

    return snapshot.docs
        .map(
          (doc) => ProductModel.fromMap(
        doc.id,
        doc.data(),
      ),
    )
        .toList();
  }

  Future<ProductModel?> getProduct({
    required String productId,
  }) async {
    final snapshot = await _firestore
        .collection(_productsCollection)
        .doc(productId)
        .get();

    if (!snapshot.exists) {
      return null;
    }

    final data = snapshot.data();

    if (data == null) {
      return null;
    }

    return ProductModel.fromMap(
      snapshot.id,
      data,
    );
  }

  Future<void> addProduct(
      ProductModel product,
      ) async {
    final data = Map<String, dynamic>.from(
      product.toMap(),
    );

    data['searchName'] =
        product.productName.trim().toLowerCase();

    data['version'] = 1;

    data['createdAt'] = FieldValue.serverTimestamp();

    data['updatedAt'] = FieldValue.serverTimestamp();

    await _firestore
        .collection(_productsCollection)
        .doc(product.productId)
        .set(data);
  }

  Future<void> updateProduct(
      ProductModel product,
      ) async {
    await _firestore
        .collection(_productsCollection)
        .doc(product.productId)
        .update(product.toMap());
  }

  Future<void> deleteProduct(
      String productId,
      ) async {
    await _firestore
        .collection(_productsCollection)
        .doc(productId)
        .delete();
  }

  Future<List<ProductModel>> searchProducts({
    required String gymId,
    required String keyword,
  }) async {
    final products = await getProducts(
      gymId: gymId,
    );

    final query = keyword.trim().toLowerCase();

    return products.where((product) {
      return product.productName
          .toLowerCase()
          .contains(query) ||
          product.productId
              .toLowerCase()
              .contains(query);
    }).toList();
  }

  Future<String> generateNextProductId() async {
    const productCounterDocument = 'product_counter';

    final counterRef = _firestore
        .collection(_systemCollection)
        .doc(productCounterDocument);

    return _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(counterRef);

      int lastNumber = 0;

      if (snapshot.exists) {
        final data = snapshot.data();

        if (data != null) {
          lastNumber = (data['lastNumber'] as int?) ?? 0;
        }
      }

      final nextNumber = lastNumber + 1;

      transaction.set(
        counterRef,
        {
          'lastNumber': nextNumber,
        },
        SetOptions(merge: true),
      );

      return 'PRD${nextNumber.toString().padLeft(6, '0')}';
    });
  }

  Future<void> deletePurchase(
      String purchaseId,
      ) async {
    await _firestore
        .collection(_purchasesCollection)
        .doc(purchaseId)
        .delete();
  }

  Future<List<PurchaseModel>> searchPurchases({
    required String gymId,
    required String keyword,
  }) async {
    final purchases = await getPurchases(
      gymId: gymId,
    );

    final query = keyword.trim().toLowerCase();

    return purchases.where((purchase) {
      return purchase.invoiceNumber
          .toLowerCase()
          .contains(query) ||
          purchase.purchaseId
              .toLowerCase()
              .contains(query);
    }).toList();
  }

}