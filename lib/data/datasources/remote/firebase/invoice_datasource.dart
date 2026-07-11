class FirestorePaths {
  FirestorePaths._();

  static const gyms = 'gyms';
  static const users = 'users';
  static const members = 'members';
  static const membershipPlans = 'membershipPlans';
  static const attendance = 'attendance';

  // Legacy
  static const membershipInvoices = 'membershipInvoices';
  static const membershipPayments = 'membershipPayments';

  // RC1 Billing
  static const invoices = 'invoices';
  static const invoiceItems = 'invoiceItems';
  static const payments = 'payments';

  // Inventory
  static const products = 'products';
  static const categories = 'categories';
  static const suppliers = 'suppliers';
  static const purchases = 'purchases';
  static const purchaseItems = 'purchaseItems';
  static const sales = 'sales';

  // RC1 Nutrition
  static const dietPlans = 'dietPlans';
  static const dietPlanItems = 'dietPlanItems';
  static const memberProductUsage = 'memberProductUsage';

  // Masters
  static const trainers = 'trainers';

  static const expenses = 'expenses';
  static const notifications = 'notifications';
  static const settings = 'settings';
}