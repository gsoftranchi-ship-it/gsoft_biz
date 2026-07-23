import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/member_provider.dart';
import 'add_member/add_member_page.dart';
import '../../providers/auth_provider.dart';
import 'member_details_page.dart';
import '../../core/widgets/erp_page_header.dart';
import '../../core/widgets/erp_search_bar.dart';
import '../../core/widgets/erp_empty_state.dart';
import '../../core/widgets/erp_loading.dart';
import '../../core/widgets/erp_card.dart';
import '../../core/widgets/erp_status_chip.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_radius.dart';


class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  final TextEditingController _searchController =
  TextEditingController();

  String _selectedFilter = 'All';
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final authProvider = context.read<AuthProvider>();

      final gymId =
          authProvider.currentUser!.tenantInfo.gymId;

      context.read<MemberProvider>().loadMembers(
        gymId: gymId,
      );
    });
  }
  Widget _buildFilterChip(String value) {
    final selected = _selectedFilter == value;

    return ChoiceChip(
      selected: selected,
      label: Text(value),
      labelStyle: AppTypography.bodySmall.copyWith(
        color: selected
            ? Colors.black
            : AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: AppColors.cardDark,
      selectedColor: AppColors.primary,
      side: BorderSide(
        color: selected
            ? AppColors.primary
            : AppColors.border,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      onSelected: (_) {
        setState(() {
          _selectedFilter = value;
        });
      },
    );
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MemberProvider>();

    final members = provider.members.where((member) {

      final search = _searchController.text.trim().toLowerCase();

      final matchesSearch =
          search.isEmpty ||
              member.fullName.toLowerCase().contains(search) ||
              member.memberId.toLowerCase().contains(search);

      final matchesFilter =
          _selectedFilter == 'All' ||
              (_selectedFilter == 'Active' && member.isActive) ||
              (_selectedFilter == 'Inactive' && !member.isActive);

      return matchesSearch && matchesFilter;

    }).toList();

    return SafeArea(
      child: Column(
        children: [
          ERPPageHeader(
            title: 'Members',
            trailing: FilledButton.icon(
              onPressed: () async {
                final authProvider = context.read<AuthProvider>();
                final memberProvider = context.read<MemberProvider>();

                final result = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddMemberPage(),
                  ),
                );

                if (!mounted || result != true) return;

                final gymId = authProvider.currentUser!.tenantInfo.gymId;

                await memberProvider.loadMembers(
                  gymId: gymId,
                );
              },
              icon: const Icon(Icons.person_add),
              label: const Text('Admission'),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: ERPSearchBar(
              controller: _searchController,
              hint: 'Search by Member ID, Name or Mobile',
              onChanged: (_) {
                setState(() {});
              },
              onClear: () {
                setState(() {});
              },
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Active'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Inactive'),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: provider.loading
                ? const ERPLoading(
              message: 'Loading members...',
            )
                : provider.members.isEmpty
                ? const ERPEmptyState(
              icon: Icons.people_outline,
              title: 'No Members Found',
              message: 'Click Admission to register your first member.',
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
              ),
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];

                return ERPCard(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MemberDetailsPage(
                            member: member,
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Text(
                        member.fullName.isEmpty
                            ? "?"
                            : member.fullName[0].toUpperCase(),
                      ),
                    ),

                    title: Text(
                      member.fullName,
                      style:AppTypography.cardTitle,
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          member.memberId,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),

                        const SizedBox(height: 4),

                        ERPStatusChip(
                          status: member.isActive
                              ? ERPStatus.active
                              : ERPStatus.inactive,
                        )
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.iconSecondary,
                      size: 18,
                    ),
                  ),

                );
              },
            ),
          ),
        ],
      ),
    );
  }
}