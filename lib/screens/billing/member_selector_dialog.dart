import 'package:flutter/material.dart';

import '../../models/member_model.dart';

class MemberSelectorDialog extends StatefulWidget {
  const MemberSelectorDialog({
    super.key,
    required this.members,
    this.onSelected,
  });

  final List<MemberModel> members;
  final ValueChanged<MemberModel>? onSelected;

  @override
  State<MemberSelectorDialog> createState() =>
      _MemberSelectorDialogState();
}

class _MemberSelectorDialogState
    extends State<MemberSelectorDialog> {

  final TextEditingController _searchController =
  TextEditingController();

  late List<MemberModel> _filteredMembers;

  @override
  void initState() {
    super.initState();

    _filteredMembers = widget.members;

    _searchController.addListener(_filterMembers);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterMembers);
    _searchController.dispose();
    super.dispose();
  }

  void _filterMembers() {
    final keyword =
    _searchController.text.trim().toLowerCase();

    setState(() {
      _filteredMembers = widget.members.where((member) {

        return member.fullName
            .toLowerCase()
            .contains(keyword) ||

            member.memberId
                .toLowerCase()
                .contains(keyword) ||

            member.phone
                .toLowerCase()
                .contains(keyword);

      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Dialog(

      child: SizedBox(
        width: 600,
        height: 550,

        child: Column(
          children: [

            AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                'Select Member',
              ),
              actions: [

                IconButton(
                  onPressed: () =>
                      Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText:
                  'Search Name / Member ID / Mobile',
                ),
              ),
            ),

            Expanded(
              child: _filteredMembers.isEmpty
                  ? const Center(
                child: Text(
                  'No members found',
                ),
              )
                  : ListView.separated(

                itemCount:
                _filteredMembers.length,

                separatorBuilder: (context, index) =>
                const Divider(height: 1),

                itemBuilder:
                    (context, index) {

                  final member =
                  _filteredMembers[index];

                  return ListTile(

                    leading:
                    const CircleAvatar(
                      child:
                      Icon(Icons.person),
                    ),

                    title:
                    Text(member.fullName),

                    subtitle: Text(

                      '${member.memberId}\n'
                          '${member.phone}',

                    ),

                    isThreeLine: true,

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),

                    onTap: () {

                      widget.onSelected
                          ?.call(member);

                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}