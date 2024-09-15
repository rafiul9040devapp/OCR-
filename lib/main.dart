import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'OCR'),
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
  File? selectedMedia;
  final ImagePicker _picker = ImagePicker();
  String? detectedDepartment;
  bool _isDialogShown = false;

  List<String> medicalDepartments = [
    "Anesthesiology",
    "Cardiology",
    "Dermatology",
    "Emergency Medicine",
    "Endocrinology",
    "Gastroenterology",
    "General Surgery",
    "Hematology",
    "Infectious Disease",
    "Internal Medicine",
    "Neonatology",
    "Nephrology",
    "Neurology",
    "Neurosurgery",
    "Obstetrics and Gynecology",
    "Oncology",
    "Ophthalmology",
    "Orthopedics",
    "Otolaryngology (ENT)",
    "Pediatrics",
    "Plastic Surgery",
    "Psychiatry",
    "Pulmonology",
    "Radiology",
    "Rheumatology",
    "Urology",
    "Vascular Surgery",
    "Pathology",
    "Immunology",
    "Geriatrics",
    "Pain Management",
    "Rehabilitation Medicine",
    "Palliative Care",
    "Dentistry",
    "Sports Medicine",
    "Allergy and Immunology",
    "Family Medicine",
    "Nuclear Medicine",
    "Occupational Medicine",
    "Orthodontics",
    "Prosthodontics",
    "Oral and Maxillofacial Surgery",
    "Public Health",
    "Traumatology",
    "Thoracic Surgery",
    "Hepatology",
    "Audiology",
    "Sleep Medicine",
    "Medical Genetics",
    "Transplant Surgery",
    "Gynecology", // Explicitly mentioned separately
    "Andrology",
    "Bariatric Surgery",
    "Colorectal Surgery",
    "Critical Care Medicine",
    "Endodontics",
    "Gastrointestinal Surgery",
    "Hand Surgery",
    "Maxillofacial Surgery",
    "Nephrology",
    "Orthopedic Oncology",
    "Phlebology",
    "Proctology",
    "Psychosomatic Medicine",
    "Sexology",
    "Spine Surgery",
    "Trauma Surgery",
    "Vascular Medicine",
    "Clinical Immunology",
    "Addiction Medicine",
    "Hyperbaric Medicine",
    "Medical Toxicology",
    "Perinatology",
    "Forensic Medicine",
    "Genomic Medicine",
    "Laboratory Medicine",
    "Preventive Medicine",
    "Telemedicine",
    "Neurocritical Care",
    "Sleep Disorders Medicine",
    "Dermatopathology",
    "Pediatric Surgery",
    "Neonatal Surgery",
    "Hematologic Oncology",
    "Infectious Disease and Immunology",
    "Interventional Radiology"
  ];


  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedMedia = File(image.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        selectedMedia = File(image.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    medicalDepartments.sort((a, b) => a.compareTo(b));
  }

  int binarySearch(List<String> sortedList, String target) {
    int left = 0;
    int right = sortedList.length - 1;
    while (left <= right) {
      int middle = (left + right) ~/ 2;
      int compare = sortedList[middle].toLowerCase().compareTo(target);

      if (compare == 0) {
        return middle;
      } else if (compare < 0) {
        left = middle + 1;
      } else {
        right = middle - 1;
      }
    }
    return -1; // Not found
  }

  int levenshteinDistance(String s1, String s2) {
    List<List<int>> dp = List.generate(
        s1.length + 1, (i) => List.generate(s2.length + 1, (j) => 0));

    for (int i = 0; i <= s1.length; i++) {
      for (int j = 0; j <= s2.length; j++) {
        if (i == 0) {
          dp[i][j] = j;
        } else if (j == 0) {
          dp[i][j] = i;
        } else if (s1[i - 1] == s2[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1];
        } else {
          dp[i][j] = 1 +
              [dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]].reduce((a, b) => a < b ? a : b);
        }
      }
    }
    return dp[s1.length][s2.length];
  }

  Stream<String?> processText(String recognizedText) async* {
    // Stream exact matches first
    for (String department in medicalDepartments) {
      if (binarySearch(medicalDepartments, recognizedText.toLowerCase()) != -1) {
        yield department;
        return;
      }
    }

    // Stream fuzzy matches
    String? closestDepartment;
    int minDistance = recognizedText.length;

    for (String department in medicalDepartments) {
      int distance = levenshteinDistance(recognizedText.toLowerCase(), department.toLowerCase());
      if (distance < minDistance) {
        minDistance = distance;
        closestDepartment = department;
      }
      yield closestDepartment;
    }
  }

  Future<String?> _extractText(String file) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFilePath(file);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    // Process the recognized text as a stream
    return recognizedText.text;
  }

  Stream<String?> processTextStream() async* {
    if (selectedMedia != null) {
      final extractedText = await _extractText(selectedMedia!.path);
      if (extractedText != null) {
        yield* processText(extractedText);
      }
    }
  }

  void _showDepartmentDialog(BuildContext context, String department) {
    TextEditingController departmentController = TextEditingController();
    departmentController.text = department; // Pre-fill the text field

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Detected Department'),
          content: TextField(
            controller: departmentController,
            decoration: const InputDecoration(
              labelText: 'Department Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update the detectedDepartment variable with the value from TextField
               setState(() {
                 detectedDepartment = departmentController.text;
               });

                // Rebuild the UI to show the department in the column
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _extractTextView() {
    if (selectedMedia == null) {
      return const Center(child: Text('No Result'));
    }

    return StreamBuilder<String?>(
      stream: processTextStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data != null) {
          if (!_isDialogShown) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showDepartmentDialog(context, snapshot.data!);
              _isDialogShown = true; // Mark as shown
            });
          }
          return detectedDepartment != null
              ? Text(detectedDepartment!)
              : const Text('');
        } else {
          return const Text("No Department Found");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: _pickImageFromCamera,
            child: const Icon(Icons.camera),
          )
        ],
      ),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImageFromGallery,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildUI() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 32),
          _imageView(),
          const SizedBox(height: 32),
          _extractTextView(),
        ],
      ),
    );
  }

  Widget _imageView() {
    if (selectedMedia == null) {
      return const Center(
        child: Text('Select An Image To Text Recognition'),
      );
    }
    return Center(
      child: Image.file(selectedMedia!, width: 200),
    );
  }
}
