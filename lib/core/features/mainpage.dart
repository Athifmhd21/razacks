import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _bookingSectionKey = GlobalKey();

  Future<void> _callNumber(String number) async {
    final Uri callUri = Uri(scheme: 'tel', path: number);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $number';
    }
  }

  Future<void> _openWhatsApp(String number, String message) async {
    final String encodedMessage = Uri.encodeComponent(message);

    // Preferred WhatsApp package on most devices
    const String whatsappPackage = "com.whatsapp";

    final Uri whatsappUri = Uri.parse(
      "whatsapp://send?phone=$number&text=$encodedMessage",
    );

    // STEP 1 — Check if WhatsApp package exists
    final bool isInstalled = await canLaunchUrl(
      Uri(scheme: "package", path: whatsappPackage),
    );

    if (isInstalled) {
      // STEP 2 — Try launching using the package name
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      print("WhatsApp NOT installed, opening web fallback.");
      final Uri webFallback = Uri.parse(
        "https://wa.me/$number?text=$encodedMessage",
      );
      await launchUrl(webFallback, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: _scrollController, // <-- controller added
        child: Column(
          children: [
            //////////////////////// CLINIC IMAGE + CENTER TITLE ////////////////////////////////

            ////////////////////////////////////////////////////////////////////////////////////
            Stack(
              children: [
                //  Clinic Logo (Top Left)
                Image.asset(
                  "assets/clinic.jpeg",
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  top: 20,
                  left: 15,
                  child: Image.asset(
                    "assets/razack.png",
                    width: 30,
                    height: 30,
                  ),
                ),

                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "DR. RAZACK'S HOMEOPATHY",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aboreto(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        height: 1.0,
                      ).copyWith(letterSpacing: -3),
                    ),
                  ),
                ),

                Positioned(
                  top: 179,
                  left: MediaQuery.of(context).size.width * 0.60,
                  child: Text(
                    "ESTD. 1982",
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ).copyWith(letterSpacing: -1),
                  ),
                ),

                // "BOOK AN APPOINTMENT" Button (Scrolls to bottom)
                Positioned(
                  top: 250,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Scrollable.ensureVisible(
                          _bookingSectionKey.currentContext!,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF000548),
                        foregroundColor: const Color(0xFFFFFFFF),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: Color(0xFF000548),
                            width: 1.2,
                          ),
                        ),
                      ),
                      child: Text(
                        "BOOK AN APPOINTMENT",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            ////////////////////////////// CLINIC DESCRPTION ////////////////////////////////////

            ////////////////////////////////////////////////////////////////////////////////////
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF000548),
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(text: "Welcome to "),
                    TextSpan(
                      text: "DR.RAZACK’S HOMEOPATHY",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ", where gentle and natural healing meets our personalized care. We focus on treating from the root cause of health concerns through safe, holistic remedies tailored to each individual. Our overall mission is to support your well-being with compassionate guidance, long-term relief, and treatments that respect the body’s natural ability to heal.",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            ///////////////////////////// "WHY CHOOSE US" TITLE/////////////////////////////////

            ////////////////////////////////////////////////////////////////////////////////////
            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Color(0xFF000548)),
                  children: [
                    TextSpan(
                      text: "WHY ",
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: "CHOOSE US",
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ////////////////////////////// BLUR CARD WITH STATS /////////////////////////////////

            ////////////////////////////////////////////////////////////////////////////////////
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: SizedBox(
                height: 600,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          "assets/medicine.jpg",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 25,
                              horizontal: 18,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.white.withOpacity(0.15),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "100K+",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF000548),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "Patients Treated",
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            color: Color(0xFF000548),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "35+",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF000548),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "Years of Practice",
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            color: Color(0xFF000548),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 28),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "4.5",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF000548),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "Rating",
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            color: Color(0xFF000548),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "10K+",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF000548),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "Under Continuous Care",
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            color: Color(0xFF000548),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ------------------ PARAGRAPH ------------------ \\
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "With structured and clinical procedures, experienced practitioners, and consistent treatment outcomes, we provide reliable homeopathic care for both chronic and acute conditions. Our focus is on long-term wellness and measurable progress.",
                textAlign: TextAlign.justify,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: const Color(0xFF000548),
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 50),

            ///////////////////////////// MEET DR MAHSOOM /////////////////////////////////////
            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Color(0xFF000548)),
                  children: [
                    TextSpan(
                      text: "MEET ",
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: " DR. MAHSOOM",
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: 380,
              height: 380,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  ),

                  Positioned(
                    top: -20,
                    child: Image.asset(
                      "assets/dr.png",
                      width: 280,
                      fit: BoxFit.contain,
                    ),
                  ),

                  Positioned(
                    top: 100,
                    left: 0,
                    child: Container(
                      width: 130,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF000548),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(blurRadius: 8, offset: Offset(0, 3)),
                        ],
                      ),
                      child: Text(
                        "8+ Years of Practice in Homeopathic Healing",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 100,
                    right: 0,
                    child: Container(
                      width: 130,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF000548),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(blurRadius: 8, offset: Offset(0, 3)),
                        ],
                      ),
                      child: Text(
                        "B.H.M.S, CCH Certified  ",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 120,
                    left: 0,
                    child: Container(
                      width: 140,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF000548),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(blurRadius: 8, offset: Offset(0, 3)),
                        ],
                      ),
                      child: Text(
                        "Successfully Treated 1000+ Chronic Cases",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 130,
                    right: 0,
                    child: Container(
                      width: 130,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF000548),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(blurRadius: 8, offset: Offset(0, 3)),
                        ],
                      ),
                      child: Text(
                        "One-to-One Patient Attention",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            ////////////////////////////// ABOUT THE DOCTOR /////////////////////////////////////
            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Color(0xFF000548)),
                  children: [
                    TextSpan(
                      text: "ABOUT ",
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr. Mahsoom, a dedicated homeopathic physician (B.H.M.S.) from Athanikkal, brings over 8 years of clinical experience in treating acute and chronic conditions. His approach is rooted in understanding the individual — medical history, lifestyle, emotional health, and root causes—not just the illness.",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xFF000548),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "He focuses on root-cause based treatment to restore balance, offering calm, detailed, and patient-centered consultations. Dr. Mahsoom has successfully helped patients with respiratory issues, skin disorders, digestive concerns, migraines, and chronic illnesses. His philosophy emphasizes gentle, non-invasive, and evidence-based remedies for safety and long-term wellness. The clinic is a trusted space for holistic, reliable, and compassionate family care.",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xFF000548),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            ///////////////////////// OUR SERVICES ///////////////////////////////
            Text(
              "OUR SERVICES",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF000548),
                letterSpacing: 1.3,
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF04002D),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    ////////////////// CARD 1
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF000543), Color(0xFF000B8E)],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chronic Disease Management",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Deep & recurring conditions treated at root.",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ////////////////// CARD 2
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF000543), Color(0xFF000B8E)],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chronic Disease Management",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Deep & recurring conditions treated at root.",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ////////////////// CARD 3
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF000543), Color(0xFF000B8E)],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chronic Disease Management",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Deep & recurring conditions treated at root.",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ////////////////// CARD 4
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF000543), Color(0xFF000B8E)],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chronic Disease Management",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Deep & recurring conditions treated at root.",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 60),

            ////////////////////////// WHAT OTHERS SAY PART /////////////////////
            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Color(0xFF000548)),
                  children: [
                    TextSpan(
                      text: "WHAT ",
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: "OTHERS SAY",
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF000543),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),

            SizedBox(
              height: 270,
              child: PageView(
                controller: PageController(viewportFraction: 0.90),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF000B8E), Color(0xFF000543)],
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset(
                                  "assets/doc.jpg",
                                  width: 65,
                                  height: 65,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 18),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dr. Athif Aslam",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "MBBS, Aster MIMS",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "I have referred several chronic cases here, especially lot of patients with long standing respiratory and skin conditions. The improvement I’ve observed over all the follow-ups has been steady and clinically meaningful.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              height: 1.6,
                              color: Colors.white.withOpacity(0.95),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF000B8E), Color(0xFF000543)],
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset(
                                  "assets/fem.jpg",
                                  width: 65,
                                  height: 65,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 18),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dr. Shahana Rahim",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "MD, General Medicine",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "A very compassionate and clinically accurate approach. Patients receive personalised and holistic homeopathic care that leads to reliable long term improvements.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              height: 1.6,
                              color: Colors.white.withOpacity(0.95),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            ///////////////////////// FIND US AT ///////////////////////////////
            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Color(0xFF000548)),
                  children: [
                    TextSpan(
                      text: "FIND ",
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: "US AT",
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF000543),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF000543), width: 3),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset("assets/map.png", fit: BoxFit.cover),
                ),
              ),
            ),

            const SizedBox(height: 35),

            Column(
              children: [
                Text(
                  "Dr Razack's homeopathy",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF000548),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Near CBHSS School Stop\nVallikkunnu Athanikkal",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    height: 1.4,
                    color: const Color(0xFF000548),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  "OPEN : 9 am–8:45 pm Everyday",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF000548),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 50),

            ////////////////////BOOK APPOINTMENT SECTION/////////////////////////////////

            /////////////////////////////////////////////////////////////////////////////
            Container(
              key: _bookingSectionKey,
              child: Column(
                children: [
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Color(0xFF000548)),
                        children: [
                          TextSpan(
                            text: "BOOK ",
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "AN APPOINTMENT",
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Complete your appointment within minutes!",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFF000548),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          "assets/treat1.jpg",
                          width: 150,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          "assets/treat2.jpg",
                          width: 150,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  //////////////////// BOOKING THROUGH NUMBER ///////////////////

                  ///////////////////////////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        _callNumber("9844533685");
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 18,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          "Call us at: +91 98445 33685",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xFF000548),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  ////////////////// BOOKING THROUGH WHATSAPP ///////////////////

                  ///////////////////////////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        _openWhatsApp(
                          "919844533685",
                          "Hello, I would like to book an appointment.",
                        );
                      },

                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 18,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Click here to book via ",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xFF000548),
                              ),
                            ),
                            Text(
                              "Whatsapp! ",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Image.asset(
                              "assets/whatsapp.png",
                              width: 22,
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            ////////////////////////// FOOTER SECTION /////////////////////////////
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 35,
                  horizontal: 25,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF000B8E), Color(0xFF000543)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Razackshomeo@gmail.com",
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "+91 9844533685",
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "+91 9846531826",
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Privacy Policy | Terms & Conditions",
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "All rights reserved ©2025 Dr. Razack’s Homeopathy",
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
