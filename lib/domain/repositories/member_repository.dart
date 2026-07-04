import '../../core/result/result.dart';
import '../../models/member_model.dart';

abstract class MemberRepository {
  Future<Result<List<MemberModel>>> getMembers();

  Future<Result<void>> addMember(
      MemberModel member,
      );

  Future<Result<void>> updateMember(
      MemberModel member,
      );

  Future<Result<void>> deleteMember(
      String id,
      );

  Future<Result<List<MemberModel>>> searchMembers(
      String keyword,
      );
}