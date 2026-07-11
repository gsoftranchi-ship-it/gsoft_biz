class FirestorePaths {
  FirestorePaths._();

  static const gyms = 'gyms';
  static const users = 'users';
  static const members = 'members';
  static const membershipPlans = 'membershipPlans';
  static const attendance = 'attendance';
  static const membershipInvoices = 'membershipInvoices';
  static const membershipPayments = 'membershipPayments';
  static const payments = 'payments';
  static const products = 'products';
  static const categories = 'categories';
  static const suppliers = 'suppliers';
  static const purchases = 'purchases';
  static const purchaseItems = 'purchaseItems';
  static const sales = 'sales';
  static const expenses = 'expenses';
  static const notifications = 'notifications';
  static const settings = 'settings';
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