import 'package:flutter/foundation.dart';

import '../core/result/failures.dart';
import '../core/result/result.dart';
import '../domain/repositories/membership_repository.dart';
import '../models/membership_invoice_model.dart';
import '../models/membership_payment_model.dart';

class MembershipProvider extends ChangeNotifier {
  MembershipProvider({
    required MembershipRepository repository,
  }) : _repository = repository;

  final MembershipRepository _repository;

  List<MembershipInvoiceModel> _invoices = [];
  List<MembershipPaymentModel> _payments = [];

  String? _currentGymId;

  bool _loading = false;

  AppFailure? _failure;

  double _outstandingAmount = 0;

  List<MembershipInvoiceModel> get invoices =>
      List.unmodifiable(_invoices);

  List<MembershipPaymentModel> get payments =>
      List.unmodifiable(_payments);

  bool get loading => _loading;

  AppFailure? get failure => _failure;

  double get outstandingAmount => _outstandingAmount;

  Future<void> loadInvoices({
    required String gymId,
  }) async {
    _currentGymId = gymId;

    _loading = true;
    _failure = null;
    notifyListeners();

    final result = await _repository.getInvoices(
      gymId: gymId,
    );

    switch (result) {
      case Success<List<MembershipInvoiceModel>>():
        _invoices = result.data;

      case FailureResult<List<MembershipInvoiceModel>>():
        _failure = result.failure;
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    if (_currentGymId == null) return;

    await loadInvoices(
      gymId: _currentGymId!,
    );
  }

  Future<bool> createInvoice(
      MembershipInvoiceModel invoice,
      ) async {
    _loading = true;
    _failure = null;
    notifyListeners();

    final result =
    await _repository.createInvoice(invoice);

    switch (result) {
      case Success<void>():
        await refresh();
        _loading = false;
        notifyListeners();
        return true;

      case FailureResult<void>():
        _failure = result.failure;
        _loading = false;
        notifyListeners();
        return false;
    }
  }

  Future<void> updateInvoice(
      MembershipInvoiceModel invoice,
      ) async {
    final result =
    await _repository.updateInvoice(invoice);

    switch (result) {
      case Success<void>():
        await refresh();

      case FailureResult<void>():
        _failure = result.failure;
        notifyListeners();
    }
  }

  Future<void> deleteInvoice(
      String invoiceId,
      ) async {
    final result =
    await _repository.deleteInvoice(invoiceId);

    switch (result) {
      case Success<void>():
        await refresh();

      case FailureResult<void>():
        _failure = result.failure;
        notifyListeners();
    }
  }

  Future<List<MembershipInvoiceModel>>
  loadMemberInvoices({
    required String memberId,
  }) async {
    if (_currentGymId == null) return [];

    final result =
    await _repository.getMemberInvoices(
      gymId: _currentGymId!,
      memberId: memberId,
    );

    switch (result) {
      case Success<List<MembershipInvoiceModel>>():
        return result.data;

      case FailureResult<List<MembershipInvoiceModel>>():
        _failure = result.failure;
        notifyListeners();
        return [];
    }
  }

  Future<List<MembershipInvoiceModel>>
  loadDueInvoices() async {
    if (_currentGymId == null) return [];

    final result =
    await _repository.getDueInvoices(
      gymId: _currentGymId!,
    );

    switch (result) {
      case Success<List<MembershipInvoiceModel>>():
        return result.data;

      case FailureResult<List<MembershipInvoiceModel>>():
        _failure = result.failure;
        notifyListeners();
        return [];
    }
  }

  Future<List<MembershipPaymentModel>>
  loadPayments({
    required String invoiceId,
  }) async {
    if (_currentGymId == null) return [];

    final result = await _repository.getPayments(
      gymId: _currentGymId!,
      invoiceId: invoiceId,
    );

    switch (result) {
      case Success<List<MembershipPaymentModel>>():
        _payments = result.data;
        notifyListeners();
        return result.data;

      case FailureResult<List<MembershipPaymentModel>>():
        _failure = result.failure;
        notifyListeners();
        return [];
    }
  }

  Future<bool> collectPayment(
      MembershipPaymentModel payment,
      ) async {
    final result =
    await _repository.collectPayment(payment);

    switch (result) {
      case Success<void>():
        return true;

      case FailureResult<void>():
        _failure = result.failure;
        notifyListeners();
        return false;
    }
  }

  Future<void> loadOutstandingAmount({
    required String memberId,
  }) async {
    if (_currentGymId == null) return;

    final result =
    await _repository.getOutstandingAmount(
      gymId: _currentGymId!,
      memberId: memberId,
    );

    switch (result) {
      case Success<double>():
        _outstandingAmount = result.data;

      case FailureResult<double>():
        _failure = result.failure;
    }

    notifyListeners();
  }

  int get totalInvoices => _invoices.length;

  int get paidInvoices =>
      _invoices.where((e) => e.isPaid).length;

  int get dueInvoices =>
      _invoices.where((e) => !e.isPaid).length;
}