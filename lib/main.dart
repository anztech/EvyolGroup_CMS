import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ManagementSystem(),
    );
  }
}

class ManagementSystem extends StatefulWidget {
  @override
  _ManagementSystemState createState() => _ManagementSystemState();
}

class _ManagementSystemState extends State<ManagementSystem> {
  List<Complaint> complaints = [];

  void addComplaint(Complaint complaint) {
    setState(() {
      complaints.add(complaint);
    });
  }

  List<Complaint> getPendingComplaints() {
    return complaints.where((complaint) => complaint.status == ComplaintStatus.Pending).toList();
  }

  List<Complaint> getInProcessComplaints() {
    return complaints.where((complaint) => complaint.status == ComplaintStatus.InProcess).toList();
  }

  List<Complaint> getCompletedComplaints() {
    return complaints.where((complaint) => complaint.status == ComplaintStatus.Completed).toList();
  }

  Map<String, int> getComplaintCountsByDepartment() {
    final complaintCounts = <String, int>{};
    for (final complaint in complaints) {
      final department = complaint.department;
      complaintCounts[department] = (complaintCounts[department] ?? 0) + 1;
    }
    return complaintCounts;
  }

  @override
  Widget build(BuildContext context) {
    final complaintCounts = getComplaintCountsByDepartment();
    final pendingComplaints = getPendingComplaints();
    final inProcessComplaints = getInProcessComplaints();
    final completedComplaints = getCompletedComplaints();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Evyol Group Complaint Management System'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildDashboardBox(
                  label: 'Total Complaints',
                  value: complaints.length.toString(),
                  icon: Icons.library_books,
                  color: Colors.blue,
                ),
                _buildDashboardBox(
                  label: 'Pending',
                  value: pendingComplaints.length.toString(),
                  icon: Icons.pending_actions,
                  color: Colors.orange,
                ),
                _buildDashboardBox(
                  label: 'In Process',
                  value: inProcessComplaints.length.toString(),
                  icon: Icons.timelapse,
                  color: Colors.yellow,
                ),
                _buildDashboardBox(
                  label: 'Completed',
                  value: completedComplaints.length.toString(),
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          ...complaintCounts.entries.map(
                (entry) => DepartmentDashboardEntry(
              department: entry.key,
              complaintCount: entry.value,
            ),
          ),
          const SizedBox(height: 16),
          DepartmentTab(
            department: 'Administration',
            complaints: complaints,
            addComplaint: addComplaint,
            backgroundColor: Color(0xFF3EBD9C),
            textColor: Colors.white,
          ),
          DepartmentTab(
            department: 'Marketing',
            complaints: complaints,
            addComplaint: addComplaint,
            backgroundColor: Color(0xFFEE6352),
            textColor: Colors.white,
          ),
          DepartmentTab(
            department: 'Sales',
            complaints: complaints,
            addComplaint: addComplaint,
            backgroundColor: Color(0xFF2D4059),
            textColor: Colors.white,
          ),
          DepartmentTab(
            department: 'Human Resources',
            complaints: complaints,
            addComplaint: addComplaint,
            backgroundColor: Color(0xFFE76F51),
            textColor: Colors.white,
          ),
          DepartmentTab(
            department: 'Customer Service',
            complaints: complaints,
            addComplaint: addComplaint,
            backgroundColor: Color(0xFF264653),
            textColor: Colors.white,
          ),
          DepartmentTab(
            department: 'Information Technology',
            complaints: complaints,
            addComplaint: addComplaint,
            backgroundColor: Color(0xFF457B9D),
            textColor: Colors.white,
          ),
          DepartmentTab(
            department: 'Research and Development',
            complaints: complaints,
            addComplaint: addComplaint,
            backgroundColor: Color(0xFFA8DADC),
            textColor: Colors.black,
          ),
          DepartmentTab(
            department: 'Operations',
            complaints: complaints,
            addComplaint: addComplaint,
            backgroundColor: Color(0xFF1D3557),
            textColor: Colors.white,
          ),
          DepartmentTab(
            department: 'Finance',
            complaints: complaints,
            addComplaint: addComplaint,
            backgroundColor: Color(0xFF457B9D),
            textColor: Colors.white,
          ),
          DepartmentTab(
            department: 'Legal',
            complaints: complaints,
            addComplaint: addComplaint,
            backgroundColor: Color(0xFFE9C46A),
            textColor: Colors.black,
          ),
          DepartmentTab(
            department: 'Risk Management',
            complaints: complaints,
            addComplaint: addComplaint,
            backgroundColor: Color(0xFFF4A261),
            textColor: Colors.black,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add Complaint'),
                content: AddComplaintForm(
                  addComplaint: addComplaint,
                  departments: [
                    'Administration',
                    'Marketing',
                    'Sales',
                    'Human Resources',
                    'Customer Service',
                    'Information Technology',
                    'Research and Development',
                    'Operations',
                    'Finance',
                    'Legal',
                    'Risk Management',
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDashboardBox({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          size: 48,
          color: color,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class DepartmentDashboardEntry extends StatelessWidget {
  final String department;
  final int complaintCount;

  const DepartmentDashboardEntry({
    Key? key,
    required this.department,
    required this.complaintCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        department,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text('Complaints: $complaintCount'),
    );
  }
}

class DepartmentTab extends StatelessWidget {
  final String department;
  final List<Complaint> complaints;
  final Function(Complaint) addComplaint;
  final Color backgroundColor;
  final Color textColor;

  const DepartmentTab({
    Key? key,
    required this.department,
    required this.complaints,
    required this.addComplaint,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final departmentComplaints = complaints.where((complaint) => complaint.department == department).toList();
    final pendingComplaints = departmentComplaints.where((complaint) => complaint.status == ComplaintStatus.Pending).toList();
    final inProcessComplaints = departmentComplaints.where((complaint) => complaint.status == ComplaintStatus.InProcess).toList();
    final completedComplaints = departmentComplaints.where((complaint) => complaint.status == ComplaintStatus.Completed).toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      child: ListTile(
        title: Text(
          department,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Pending: ${pendingComplaints.length} | In Process: ${inProcessComplaints.length} | Completed: ${completedComplaints.length}',
          style: TextStyle(
            color: textColor,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DepartmentComplaintsPage(
                department: department,
                complaints: complaints,
              ),
            ),
          );
        },
      ),
    );
  }
}

class DepartmentComplaintsPage extends StatefulWidget {
  final String department;
  final List<Complaint> complaints;

  const DepartmentComplaintsPage({
    Key? key,
    required this.department,
    required this.complaints,
  }) : super(key: key);

  @override
  _DepartmentComplaintsPageState createState() => _DepartmentComplaintsPageState();
}

class _DepartmentComplaintsPageState extends State<DepartmentComplaintsPage> {
  late List<Complaint> departmentComplaints;

  @override
  void initState() {
    super.initState();
    departmentComplaints = getDepartmentComplaints();
  }

  List<Complaint> getDepartmentComplaints() {
    return widget.complaints.where((complaint) => complaint.department == widget.department).toList();
  }

  void updateComplaintStatus(int index, ComplaintStatus newStatus) {
    setState(() {
      departmentComplaints[index].status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints - ${widget.department}'),
      ),
      body: ListView.builder(
        itemCount: departmentComplaints.length,
        itemBuilder: (context, index) {
          final complaint = departmentComplaints[index];
          return ListTile(
            title: Text(complaint.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Employee ID: ${complaint.employeeId}'),
                Text('Employee Name: ${complaint.employeeName}'),
                Text('Posting Date: ${complaint.postingDate}'),
                Text('Posting Time: ${complaint.postingTime}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (complaint.status == ComplaintStatus.Pending)
                  ElevatedButton(
                    onPressed: () => updateComplaintStatus(index, ComplaintStatus.InProcess),
                    child: const Text('Process'),
                  ),
                if (complaint.status == ComplaintStatus.InProcess)
                  ElevatedButton(
                    onPressed: () => updateComplaintStatus(index, ComplaintStatus.Completed),
                    child: const Text('Complete'),
                  ),
                if (complaint.status == ComplaintStatus.Pending ||
                    complaint.status == ComplaintStatus.InProcess)
                  ElevatedButton(
                    onPressed: () => updateComplaintStatus(index, ComplaintStatus.Rejected),
                    child: const Text('Reject'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AddComplaintForm extends StatefulWidget {
  final Function(Complaint) addComplaint;
  final List<String> departments;

  const AddComplaintForm({
    Key? key,
    required this.addComplaint,
    required this.departments,
  }) : super(key: key);

  @override
  _AddComplaintFormState createState() => _AddComplaintFormState();
}

class _AddComplaintFormState extends State<AddComplaintForm> {
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? selectedDepartment;

  @override
  void dispose() {
    _employeeIdController.dispose();
    _employeeNameController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DropdownButtonFormField<String>(
          value: selectedDepartment,
          onChanged: (value) {
            setState(() {
              selectedDepartment = value;
            });
          },
          items: widget.departments.map<DropdownMenuItem<String>>((String department) {
            return DropdownMenuItem<String>(
              value: department,
              child: Text(department),
            );
          }).toList(),
          decoration: const InputDecoration(
            labelText: 'Department',
          ),
        ),
        TextField(
          controller: _employeeIdController,
          decoration: const InputDecoration(
            labelText: 'Employee ID',
          ),
        ),
        TextField(
          controller: _employeeNameController,
          decoration: const InputDecoration(
            labelText: 'Employee Name',
          ),
        ),
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Title',
          ),
        ),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final complaint = Complaint(
              title: _titleController.text,
              description: _descriptionController.text,
              department: selectedDepartment ?? '',
              employeeId: _employeeIdController.text,
              employeeName: _employeeNameController.text,
              postingDate: DateTime.now().toString(),
              postingTime: TimeOfDay.now().toString(),
              status: ComplaintStatus.Pending,
            );
            widget.addComplaint(complaint);
            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class Complaint {
  final String title;
  final String description;
  final String department;
  final String employeeId;
  final String employeeName;
  final String postingDate;
  final String postingTime;
  ComplaintStatus status;

  Complaint({
    required this.title,
    required this.description,
    required this.department,
    required this.employeeId,
    required this.employeeName,
    required this.postingDate,
    required this.postingTime,
    this.status = ComplaintStatus.Pending,
  });
}

enum ComplaintStatus {
  Pending,
  InProcess,
  Completed,
  Rejected,
}
