import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/member_provider.dart';
import 'add_member/add_member_page.dart';
import '../../providers/auth_provider.dart';


class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MemberProvider>(context);

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
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FilledButton.icon(
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
              itemCount: provider.members.length,
              itemBuilder: (context, index) {
                final member = provider.members[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        member.fullName.isEmpty
                            ? "?"
                            : member.fullName[0].toUpperCase(),
                      ),
                    ),

                    title: Text(member.fullName),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(member.memberId),

                        const SizedBox(height: 4),

                        Chip(
                          label: Text(
                            member.isActive ? "Active" : "Inactive",
                          ),
                          visualDensity: VisualDensity.compact,
                        )
                      ],
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