import '../../core/result/failures.dart';
import '../../core/result/result.dart';
import '../../domain/repositories/member_repository.dart';
import '../../models/member_model.dart';
import '../datasources/remote/firebase/firestore_datasource.dart';

class MemberRepositoryImpl implements MemberRepository {
  MemberRepositoryImpl({
    required FirestoreDataSource firestoreDataSource,
  }) : _firestoreDataSource = firestoreDataSource;

  final FirestoreDataSource _firestoreDataSource;

  @override
  Future<Result<List<MemberModel>>> getMembers({
    required String gymId,
  }) async {
    try {
      final members = await _firestoreDataSource.getMembers(gymId: gymId,);
      return Success(members);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }
  @override
  Future<Result<String>> generateNextMemberId() async {
    try {
      final memberId =
      await _firestoreDataSource.generateNextMemberId();

      return Success(memberId);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> addMember(
      MemberModel member,
      ) async {
    try {
      await _firestoreDataSource.addMember(member);
      return const Success(null);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> updateMember(
      MemberModel member,
      ) async {
    try {
      await _firestoreDataSource.updateMember(member);
      return const Success(null);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> deleteMember(
      String id,
      ) async {
    try {
      await _firestoreDataSource.deleteMember(id);
      return const Success(null);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<List<MemberModel>>> searchMembers({
    required String gymId,
    required String keyword,
  }) async {
    try {
      final members =
      await _firestoreDataSource.searchMembers( gymId: gymId,
        keyword: keyword,);

      return Success(members);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }
}