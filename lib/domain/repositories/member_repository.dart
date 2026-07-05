import '../../core/result/result.dart';
import '../../models/member_model.dart';

abstract class MemberRepository {
  Future<Result<List<MemberModel>>> getMembers({
    required String gymId,
  });
  Future<Result<String>> generateNextMemberId();

  Future<Result<void>> addMember(
      MemberModel member,
      );

  Future<Result<void>> updateMember(
      MemberModel member,
      );

  Future<Result<void>> deleteMember(
      String id,
      );

  Future<Result<List<MemberModel>>> searchMembers({
    required String gymId,
    required String keyword,
  });
}