import 'package:flutter/foundation.dart';

import '../core/result/failures.dart';
import '../core/result/result.dart';
import '../domain/repositories/member_repository.dart';
import '../models/member_model.dart';

class MemberProvider extends ChangeNotifier {
  MemberProvider({
    required MemberRepository repository,
  }) : _repository = repository;

  final MemberRepository _repository;

  List<MemberModel> _members = [];

  bool _loading = false;

  AppFailure? _failure;

  List<MemberModel> get members => List.unmodifiable(_members);

  bool get loading => _loading;

  AppFailure? get failure => _failure;

  Future<void> loadMembers() async {
    _loading = true;
    _failure = null;
    notifyListeners();

    final result = await _repository.getMembers();

    switch (result) {
      case Success<List<MemberModel>>():
        _members = result.data;

      case FailureResult<List<MemberModel>>():
        _failure = result.failure;
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> search(String keyword) async {
    final result = await _repository.searchMembers(keyword);

    switch (result) {
      case Success<List<MemberModel>>():
        _members = result.data;

      case FailureResult<List<MemberModel>>():
        _failure = result.failure;
    }

    notifyListeners();
  }

  Future<void> refresh() async {
    await loadMembers();
  }

  Future<bool> add(MemberModel member) async {
    _loading = true;
    _failure = null;
    notifyListeners();

    final result = await _repository.addMember(member);

    switch (result) {
      case Success<void>():
        await loadMembers();
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

  Future<void> update(MemberModel member) async {
    final result = await _repository.updateMember(member);

    switch (result) {
      case Success<void>():
        await loadMembers();

      case FailureResult<void>():
        _failure = result.failure;
        notifyListeners();
    }
  }

  Future<void> delete(String memberId) async {
    final result = await _repository.deleteMember(memberId);

    switch (result) {
      case Success<void>():
        await loadMembers();

      case FailureResult<void>():
        _failure = result.failure;
        notifyListeners();
    }
  }

  int get totalMembers => _members.length;

  int get activeMembers =>
      _members.where((e) => e.isActive).length;

  int get inactiveMembers =>
      _members.where((e) => !e.isActive).length;
}