import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Attendance"),
        actions: [

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.calendar_month),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download),
          ),

        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Attendance Marked Successfully"),
            ),
          );

        },
        icon: const Icon(Icons.check),
        label: const Text("Check In"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Text(
            "Today's Attendance",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [

              Expanded(
                child: _summary(
                  "Present",
                  "148",
                  Colors.green,
                  Icons.check_circle,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _summary(
                  "Absent",
                  "18",
                  Colors.red,
                  Icons.cancel,
                ),
              ),

            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [

              Expanded(
                child: _summary(
                  "Late",
                  "05",
                  Colors.orange,
                  Icons.watch_later,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _summary(
                  "Leave",
                  "02",
                  Colors.blue,
                  Icons.beach_access,
                ),
              ),

            ],
          ),

          const SizedBox(height: 25),

          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: "Search Member",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Today's Members",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          _member(
            "Rahul Kumar",
            "08:05 AM",
            true,
          ),

          _member(
            "Amit Kumar",
            "07:58 AM",
            true,
          ),

          _member(
            "Rohit Singh",
            "--",
            false,
          ),

          _member(
            "Pankaj",
            "08:18 AM",
            true,
          ),

          _member(
            "Deepak",
            "--",
            false,
          ),

          const SizedBox(height: 80),

        ],
      ),
    );
  }

  Widget _summary(
      String title,
      String value,
      Color color,
      IconData icon,
      ) {

    return Card(

      child: Padding(

        padding: const EdgeInsets.all(18),

        child: Column(

          children: [

            CircleAvatar(
              backgroundColor:
              color.withValues(alpha: .15),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(title),

          ],
        ),
      ),
    );
  }

  Widget _member(
      String name,
      String time,
      bool present,
      ) {

    return Card(

      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(

        leading: CircleAvatar(
          child: Text(name[0]),
        ),

        title: Text(name),

        subtitle: Text(
          present
              ? "Check In : $time"
              : "Absent",
        ),

        trailing: present

            ? FilledButton(
          onPressed: () {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "$name Checked Out",
                ),
              ),
            );

          },
          child: const Text("Check Out"),
        )

            : FilledButton(
          onPressed: () {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "$name Checked In",
                ),
              ),
            );

          },
          child: const Text("Check In"),
        ),
      ),
    );
  }
}