import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? _counter;

  Color _boxColor = Colors.white;
  Color _secondary = Color(0xFF1A3838);
  String _studentName = 'Levy Rozman';
  String _studentId = '210041137';
  String _department = 'CSE';
  String _program = 'B.Sc in CSE';
  String _country = 'Bangladesh';
  File? _selectedImage;
  Uint8List? _webImage;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _deptController = TextEditingController();
  final TextEditingController _programController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void setStudentInfo(String id, String name, String dept, String program, String country) {
    setState(() {
      _studentName = name;
      _studentId = id;
      _department = dept;
      _program = program;
      _country = country;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        if (kIsWeb) {
          // For web platform
          final bytes = await image.readAsBytes();
          setState(() {
            _webImage = bytes;
            _selectedImage = null;
          });
        } else {
          // For mobile platforms
          setState(() {
            _selectedImage = File(image.path);
            _webImage = null;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  TextStyle _currentFont = GoogleFonts.lato();

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  TextStyle getRandomFont() {
    final List<TextStyle> fonts = [
      GoogleFonts.lato(),
      GoogleFonts.roboto(),
      GoogleFonts.openSans(),
      GoogleFonts.montserrat(),
      GoogleFonts.oswald(),
      GoogleFonts.raleway(),
      GoogleFonts.poppins(),
      GoogleFonts.nunito(),
      GoogleFonts.ubuntu(),
      GoogleFonts.merriweather(),
    ];
    final Random random = Random();
    return fonts[random.nextInt(fonts.length)];
  }

  void _incrementCounter() {
    setState(() {
      if (_counter == null) {
        _counter = 1;
      } else {
        _counter = _counter! + 1;
      }
    });
  }

  void _changeBoxColor() {
    setState(() {
      _boxColor = getRandomColor();
    });
  }

  void _changeFont() {
    setState(() {
      _currentFont = getRandomFont();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              Container(
                width: 300,
                height: 418,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: DefaultTextStyle(
                  style: _currentFont,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: const BoxDecoration(
                              color: Color(0xFF1A3838),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                            child: Column(
                              children: [
                                Image.asset('assets/images/IUT_logo_v_1.png', height: 50),
                                const SizedBox(height: 4),
                                const Text(
                                  'Islamic University of Technology',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 47),
                              ],
                            ),
                          ),
                          const SizedBox(height: 90),
                          Center(
                            child: SizedBox(
                              width: 155, // Adjust this width as needed
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Left align text
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.key, size: 16, color: Colors.black),
                                      SizedBox(width: 4),
                                      Text('Student Id', style: TextStyle(color: Colors.blueGrey)),
                                    ],
                                  ),
                                  // Text(_studentId, style: const TextStyle(fontSize: 18)),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1A3838), // Dark box
                                      borderRadius: BorderRadius.circular(20), // Pill shape
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 12,
                                          height: 12,
                                          decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          _studentId,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Row(
                                    children: [
                                      Icon(Icons.person_4, size: 16, color: Colors.black),
                                      SizedBox(width: 4),
                                      Text('Student Name', style: TextStyle(color: Colors.blueGrey)),
                                    ],
                                  ),
                                  Text(
                                    _studentName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.school, size: 16, color: Colors.black),
                                      const SizedBox(width: 4),
                                      Row(
                                        children: [
                                          const Text(
                                            'Program ',
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            _program,
                                            style: const TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.public, size: 16, color: Colors.black),
                                      const SizedBox(width: 4),
                                      Row(
                                        children: [
                                          const Text(
                                            'Department ',
                                            style: TextStyle(color: Colors.blueGrey),
                                          ),
                                          Text(
                                            _department,
                                            style: const TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on, size: 16, color: Colors.black),
                                      const SizedBox(width: 4),
                                      Text(_country),
                                    ],
                                  ),
                                ],
                              ),

                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            decoration: const BoxDecoration(
                              color: Color(0xFF1A3838),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: const Column(
                              children: [
                                SizedBox(height: 0),
                                Text(
                                  'A subsidiary organ of OIC',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Positioned image that overlaps both sections
                      Positioned(
                        top: 90, // Adjust this value to control vertical position
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: _secondary, width: 5),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: _webImage != null
                                  ? Image.memory(
                                _webImage!,
                                width: 100,
                                height: 120,
                                fit: BoxFit.cover,
                              )
                                  : _selectedImage != null
                                  ? Image.file(
                                _selectedImage!,
                                width: 100,
                                height: 120,
                                fit: BoxFit.cover,
                              )
                                  : Image.asset(
                                'assets/images/idCard.jpeg',
                                width: 100,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _changeFont();
        },
        tooltip: 'Change Font',
        child: const Icon(Icons.font_download),
      ),
    );
  }
}