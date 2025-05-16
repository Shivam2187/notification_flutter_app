// import 'package:flutter/material.dart';
// import 'package:notification_flutter_app/presentation/widgets/top_snake_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:notification_flutter_app/presentation/providers/employee_provider.dart';
// import 'package:notification_flutter_app/presentation/widgets/loader.dart';

// class EmployeeAddForm extends StatefulWidget {
//   const EmployeeAddForm({
//     super.key,
//   });

//   @override
//   _EmployeeAddFormState createState() => _EmployeeAddFormState();
// }

// class _EmployeeAddFormState extends State<EmployeeAddForm> {
//   final _formKey = GlobalKey<FormState>();

//   final _nameController = TextEditingController();
//   final _mobileController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _emailController = TextEditingController();

//   Future<void> _submitForm(BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       final employeeName = _nameController.text.trim();
//       final mobileNumber = _mobileController.text.trim();
//       final description = _descriptionController.text.trim();
//       final address = _addressController.text.trim();
//       final emailId = _emailController.text.trim();
//       if (!mounted) return;
//       LoaderDialog.show(context: context);
//       // Here you can call the API to add the employee
//       final status = await context.read<EmployeProvider>().addEmployee(
//             employeeName: employeeName,
//             mobileNumber: mobileNumber,
//             emailId: emailId,
//             description: description,
//             address: address,
//           );

//       LoaderDialog.hide(context);
//       if (status) {
//         showTopSnackBar(
//             context: context,
//             message: 'Employee added successfully',
//             bgColor: Colors.green);
//         Navigator.pop(context); // Close the bottom sheet
//       } else {
//         showTopSnackBar(
//           context: context,
//           message: 'Failed to add employee',
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _mobileController.dispose();
//     _descriptionController.dispose();
//     _addressController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             shrinkWrap: true,
//             children: [
//               _buildTextField(
//                 _nameController,
//                 'Name*',
//                 prefixIcon: const Icon(Icons.person),
//                 keyboardType: TextInputType.text,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) return 'Name is required';
//                   return null;
//                 },
//               ),
//               _buildTextField(
//                 _mobileController,
//                 'Mobile Number*',
//                 prefixIcon: const Icon(Icons.phone),
//                 keyboardType: TextInputType.phone,
//                 maxLength: 10,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Mobile number required';
//                   }
//                   if (!RegExp(r'^\d{10}$').hasMatch(value)) {
//                     return 'Enter valid 10-digit number';
//                   }
//                   return null;
//                 },
//               ),
//               _buildTextField(
//                 _emailController,
//                 'Email ID*',
//                 prefixIcon: const Icon(Icons.email),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null ||
//                       value.isEmpty ||
//                       !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Enter Valid Email'; // Optional
//                   }

//                   return null;
//                 },
//               ),
//               _buildTextField(
//                 _addressController,
//                 'Address',
//                 maxLines: 2,
//                 prefixIcon: const Icon(Icons.home),
//               ),
//               _buildTextField(
//                 _descriptionController,
//                 'Description',
//                 maxLines: 2,
//                 prefixIcon: const Icon(Icons.description),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => _submitForm(context),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   backgroundColor: Colors.deepPurple,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 child: const Text(
//                   'Submit',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//     TextEditingController controller,
//     String label, {
//     int maxLines = 1,
//     TextInputType keyboardType = TextInputType.text,
//     String? Function(String?)? validator,
//     int? maxLength,
//     Widget? prefixIcon,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: TextFormField(
//         maxLength: maxLength,
//         controller: controller,
//         decoration: InputDecoration(
//           prefixIcon: prefixIcon,
//           contentPadding: const EdgeInsets.all(8),
//           labelText: label,
//           border: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(8))),
//           counterText: '',
//         ),
//         keyboardType: keyboardType,
//         maxLines: maxLines,
//         validator: validator,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notification_flutter_app/presentation/widgets/loader.dart';
import 'package:notification_flutter_app/presentation/widgets/top_snake_bar.dart';
import 'package:notification_flutter_app/presentation/providers/employee_provider.dart';

class EmployeeAddForm extends StatefulWidget {
  const EmployeeAddForm({super.key});

  @override
  EmployeeAddFormState createState() => EmployeeAddFormState();
}

class EmployeeAddFormState extends State<EmployeeAddForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();

  Future<void> handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final employeeName = _nameController.text.trim();
      final mobileNumber = _mobileController.text.trim();
      final description = _descriptionController.text.trim();
      final address = _addressController.text.trim();
      final emailId = _emailController.text.trim();

      if (!mounted) return;
      LoaderDialog.show(context: context);

      final status = await context.read<EmployeProvider>().addEmployee(
            employeeName: employeeName,
            mobileNumber: mobileNumber,
            emailId: emailId,
            description: description,
            address: address,
          );

      LoaderDialog.hide(context: context);

      if (status) Navigator.pop(context);

      showTopSnackBar(
        context: context,
        message:
            status ? 'Employee added successfully' : 'Failed to add employee',
        bgColor: status ? Colors.green : Colors.red,
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTextField(
            _nameController,
            'Name*',
            prefixIcon: const Icon(Icons.person),
            validator: (value) =>
                value == null || value.isEmpty ? 'Name is required' : null,
          ),
          _buildTextField(
            _mobileController,
            'Mobile Number*',
            prefixIcon: const Icon(Icons.phone),
            keyboardType: TextInputType.phone,
            maxLength: 10,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mobile number required';
              }
              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                return 'Enter valid 10-digit number';
              }
              return null;
            },
          ),
          _buildTextField(
            _emailController,
            'Email ID',
            prefixIcon: const Icon(Icons.email),
            keyboardType: TextInputType.emailAddress,
          ),
          _buildTextField(
            _addressController,
            'Address',
            maxLines: 3,
            prefixIcon: const Icon(Icons.home),
          ),
          _buildTextField(
            _descriptionController,
            'Description',
            maxLines: 3,
            prefixIcon: const Icon(Icons.description),
          ),
          const SizedBox(height: 100), // space for keyboard
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    int? maxLength,
    Widget? prefixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          counterText: '',
          contentPadding: const EdgeInsets.all(12),
        ),
      ),
    );
  }
}
