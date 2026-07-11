import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/member_provider.dart';
import 'add_member/add_member_page.dart';
import '../../providers/auth_provider.dart';
import 'member_details_page.dart';


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
    return ChoiceChip(
      backgroundColor: const Color(0xff1E293B),
      selectedColor: Colors.orange,
      labelStyle: TextStyle(
        color: _selectedFilter == value
            ? Colors.black
            : Colors.white,
        fontWeight: FontWeight.w600,
      ),
      label: Text(value),
      selected: _selectedFilter == value,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Members",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 16,
                    ),
                  ),
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
                  label: const Text("Admission"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xff1E293B),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white70,
                ),
                hintText: 'Search by Member ID, Name or Mobile',
                hintStyle: const TextStyle(
                  color: Colors.white54,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: Colors.white24,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Colors.orange,
                    width: 1.5,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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

          const SizedBox(height: 12),
          Expanded(
            child: provider.loading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : provider.members.isEmpty
                ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 70,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "No Members Found",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Click Admission to register your first member.",
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];

                return Card(
                  color: const Color(0xff1E293B),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: const BorderSide(
                      color: Colors.white12,
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
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
                      backgroundColor: Colors.orange,
                      child: Text(
                        member.fullName.isEmpty
                            ? "?"
                            : member.fullName[0].toUpperCase(),
                      ),
                    ),

                    title: Text(
                      member.fullName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          member.memberId,
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Chip(
                          backgroundColor: member.isActive
                              ? Colors.green.withValues(alpha: 0.80)
                              : Colors.red.withValues(alpha: 0.80),
                          label: Text(
                            member.isActive ? "Active" : "Inactive",
                          ),
                          visualDensity: VisualDensity.compact,
                        )
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white54,
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