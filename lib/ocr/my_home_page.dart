import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'helper.dart';


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
    "Gynecology",
    "Obstetrics",
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

  @override
  void initState() {
    super.initState();
    medicalDepartments.sort((a, b) => a.compareTo(b));
  }

  Future<void> _captureAndExtractText(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        selectedMedia = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose An Option",textAlign: TextAlign.center,),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context); // Close the dialog
                  _captureAndExtractText(ImageSource.camera); // Choose camera
                },
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt,size: 25),
                    SizedBox(height: 4),
                    Text("Camera"),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context); // Close the dialog
                  _captureAndExtractText(ImageSource.gallery); // Choose camera
                },
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo,size: 25),
                    SizedBox(height: 4),
                    Text("Gallery"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDepartmentDialog(BuildContext context, String department) {
    TextEditingController departmentController = TextEditingController();
    departmentController.text = department;

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
                setState(() {
                  detectedDepartment = departmentController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }


  Stream<String?> processText(List<String> words) async* {
    for (String word in words) {
      // Perform binary search for exact match
      int exactMatchIndex = binarySearch(medicalDepartments, word.toLowerCase());
      if (exactMatchIndex != -1) {
        yield medicalDepartments[exactMatchIndex]; // Exact match found
        continue;
      }

      // Fuzzy matching for words that don't have an exact match
      double threshold = 0.65; // Set similarity threshold to 75%
      String? closestDepartment;
      double maxSimilarity = 0.0;

      for (String department in medicalDepartments) {
        double similarity = calculateSimilarity(word.toLowerCase(), department.toLowerCase());

        if (similarity >= threshold && similarity > maxSimilarity) {
          maxSimilarity = similarity;
          closestDepartment = department;
        }
      }

      // Yield the closest matching department if found
      if (closestDepartment != null) {
        yield closestDepartment;
      }
    }

    yield "No matching department found"; // Yield if no matches were found
  }

  //Work on the OCR
  Future<List<String>?> _extractText(String file) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFilePath(file);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    List<String> words = [];
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        words.addAll(line.text.split(RegExp(r'\s+')));
      }
    }
    print(words);
    return words;
  }

  Stream<String?> processTextStream() async* {
    if (selectedMedia != null) {
      final extractedText = await _extractText(selectedMedia!.path);
      if (extractedText != null) {
        yield* processText(extractedText);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showImageSourceDialog,
        tooltip: 'Image Source',
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

}