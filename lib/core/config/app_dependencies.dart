import '../../data/datasources/remote/firebase/auth_datasource.dart';
import '../../data/datasources/remote/firebase/firestore_datasource.dart';
import '../../data/repositories/impl/auth_repository_impl.dart';
import '../../core/services/document_number_service.dart';
import '../../data/repositories/impl/membership_repository_impl.dart';
import '../../data/repositories/gym_repository.dart';
import '../../data/repositories/member_repository.dart';
import '../../data/datasources/remote/firebase/attendance_datasource.dart';
import '../../data/repositories/impl/attendance_repository_impl.dart';
import '../../data/repositories/impl/product_repository_impl.dart';
import '../../data/datasources/remote/firebase/invoice_datasource.dart';
import '../../data/datasources/remote/firebase/payment_datasource.dart';
import '../../data/repositories/impl/invoice_repository_impl.dart';
import '../../data/repositories/impl/payment_repository_impl.dart';
import '../../data/datasources/remote/firebase/invoice_item_datasource.dart';
import '../../data/repositories/impl/invoice_item_repository_impl.dart';

class AppDependencies {
  AppDependencies._();

  static final AuthDataSource authDataSource = AuthDataSource();

  static final DocumentNumberService documentNumberService =
  DocumentNumberService();

  static final FirestoreDataSource firestoreDataSource =
  FirestoreDataSource(
    documentNumberService: documentNumberService,
  );

  static final AuthRepositoryImpl authRepository =
  AuthRepositoryImpl(
    authDataSource: authDataSource,
    firestoreDataSource: firestoreDataSource,
  );
  static final GymRepositoryImpl gymRepository =
  GymRepositoryImpl(
    firestoreDataSource: firestoreDataSource,
  );
  static final MemberRepositoryImpl memberRepository =
  MemberRepositoryImpl(
    firestoreDataSource: firestoreDataSource,
  );
  static final MembershipRepositoryImpl membershipRepository =
  MembershipRepositoryImpl(
    firestoreDataSource: firestoreDataSource,
  );
  static final AttendanceDataSource attendanceDataSource =
  AttendanceDataSource();

  static final AttendanceRepositoryImpl attendanceRepository =
  AttendanceRepositoryImpl(
    dataSource: attendanceDataSource,
  );
  static final ProductRepositoryImpl productRepository =
  ProductRepositoryImpl(
    firestoreDataSource: firestoreDataSource,
  );
  //==========================================================
// BILLING
//==========================================================

  static final InvoiceDataSource invoiceDataSource =
  InvoiceDataSource(
    documentNumberService: documentNumberService,
  );

  static final PaymentDataSource paymentDataSource =
  PaymentDataSource();

  static final InvoiceRepositoryImpl invoiceRepository =
  InvoiceRepositoryImpl(
    invoiceDataSource: invoiceDataSource,
  );

  static final PaymentRepositoryImpl paymentRepository =
  PaymentRepositoryImpl(
    paymentDataSource: paymentDataSource,
  );
  static final InvoiceItemDataSource invoiceItemDataSource =
  InvoiceItemDataSource();

  static final InvoiceItemRepositoryImpl invoiceItemRepository =
  InvoiceItemRepositoryImpl(
    invoiceItemDataSource: invoiceItemDataSource,
  );
}
