class FirestoreFields {
  FirestoreFields._();

  static const id = 'id';
  static const gymId = 'gymId';

  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';

  static const createdBy = 'createdBy';
  static const updatedBy = 'updatedBy';

  static const status = 'status';
  static const isDeleted = 'isDeleted';

  //==============================
// Common
//==============================

  static const version = 'version';

//==============================
// Invoice
//==============================

  static const invoiceId = 'invoiceId';
  static const invoiceNumber = 'invoiceNumber';
  static const invoiceType = 'invoiceType';

//==============================
// References
//==============================

  static const memberId = 'memberId';
  static const customerId = 'customerId';
  static const supplierId = 'supplierId';
  static const trainerId = 'trainerId';
  static const productId = 'productId';
  static const dietPlanId = 'dietPlanId';

//==============================
// Payment
//==============================

  static const paymentId = 'paymentId';
  static const paymentMethod = 'paymentMethod';
  static const paymentStatus = 'paymentStatus';

//==============================
// Product Usage
//==============================

  static const quantity = 'quantity';

//==============================
// Dates
//==============================

  static const invoiceDate = 'invoiceDate';
  static const paymentDate = 'paymentDate';
  static const issuedDate = 'issuedDate';
  static const startDate = 'startDate';
  static const endDate = 'endDate';
}