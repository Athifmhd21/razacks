import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:razacks/core/provider/booking_provider.dart';
import 'package:razacks/core/provider/video_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _bookingSectionKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBookingSection() {
    final ctx = _bookingSectionKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.read<BookingProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            //////////////////////// CLINIC IMAGE + CENTER TITLE ////////////////////////////////
            Stack(
              children: [
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
                      onPressed: _scrollToBookingSection,
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

            ////////////////////////////// CLINIC DESCRIPTION ////////////////////////////////////
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

            ///////////////////////////// "WHY CHOOSE US" TITLE //////////////////////////////////
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

            ///////////////////////////// MEET OUR FOUNDER /////////////////////////////////////
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
                      text: "OUR FOUNDER",
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

            // IMAGE IN CENTER WITH CIRCLE BACKGROUND
            SizedBox(
              width: 380,
              height: 380,
              child: Stack(
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

                  // FOUNDER IMAGE
                  Positioned(
                    top: -10,
                    child: Image.asset(
                      "assets/father.png",
                      width: 280,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // PARAGRAPH ABOUT THE FOUNDER (same style as Doctor)
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
                    TextSpan(
                      text:
                          "The institution, Dr. Razack's Homoeopathy, was established in 1982 in the Anangadi Kalalundi Nagaram area of Malappuram district by",
                    ),
                    TextSpan(
                      text: "DR P.A RAZACK",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ", who propagated Homoeopathy in the region, demonstrated proficiency in treating many chronic diseases. He gained expertise in the treatment of diseases like Cancer, Piles, Fissure, Fistula, and various allergies. Due to the shortage of space, the clinic was expanded to a place called Athanikkal, and in 2016, his son, Dr. Muhammed Mahsoom, who holds a BHMS degree from a Bharathesh medical college for Homoeopathy in Belgaum, Karnataka took charge as the Chief Homoeopathic Consultant. Dr. Muhammed Mahsoom has also gained experience by serving in various Homoeopathic hospitals.",
                    ),
                  ],
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
                    top: 50,
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
                    top: 50,
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
                        "B.H.M.S Certified",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
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
                        "Using GERMAN imported Medicines",
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
                    bottom: 200,
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
                        "Serving patients in 12+ countries",
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
                    "Dr. Muhammed Mahsoom, a dedicated homeopathic physician (B.H.M.S.) from Malappuram,India brings over 10+ years of clinical experience in treating acute and chronic conditions. His approach is rooted in understanding the individual — medical history, lifestyle, emotional health, and root causes—not just the illness.",
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
                    // CARD 1
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
                            "Piles-Fissure-Fistula Treatment",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Restore comfort with natural treatment",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // CARD 2
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
                            "Migraine Treatment",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Natural relief for recurring migraine pain.",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // CARD 3
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
                            "Online Treatment",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Delivering medicines to 12+ countries through online treatment.",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // CARD 4
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
                            "Asthma Treatment",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Naturally easing asthma, restoring comfort.",
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
              height: 650,
              child: PageView(
                controller: PageController(viewportFraction: 0.90),
                children: [
                  // FIRST CARD
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
                          // NAME + TITLE (No image)
                          Column(
                            children: [
                              Text(
                                "Gopalakrishnan",
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Ex-military",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // VIDEO PLAYER USING PROVIDER
                          Consumer<VideoProvider>(
                            builder: (context, videoProv, _) {
                              return GestureDetector(
                                onTap: () {
                                  videoProv.togglePlayPause();
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: videoProv.isInitialized
                                      ? Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            AspectRatio(
                                              aspectRatio: videoProv
                                                  .gopalController
                                                  .value
                                                  .aspectRatio,
                                              child: VideoPlayer(
                                                videoProv.gopalController,
                                              ),
                                            ),
                                            AnimatedOpacity(
                                              opacity: videoProv.isPlaying
                                                  ? 0.0
                                                  : 1.0,
                                              duration: const Duration(
                                                milliseconds: 200,
                                              ),
                                              child: const Icon(
                                                Icons.play_circle_fill,
                                                size: 60,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(
                                          height: 200,
                                          color: Colors.black26,
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                ),
                              );
                            },
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
              child: InkWell(
                onTap: () async {
                  final Uri mapUrl = Uri.parse(
                    "https://www.google.com/maps/place/11.125415455541955, 75.84654174930253",
                  );

                  if (!await launchUrl(
                    mapUrl,
                    mode: LaunchMode.externalApplication,
                  )) {
                    throw Exception("Could not launch Google Maps");
                  }
                },
                child: Container(
                  height: 260,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFF000543),
                      width: 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset("assets/map.png", fit: BoxFit.cover),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),

            Column(
              children: [
                Text(
                  "Dr Razack's Homeopathy",
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
                  "OPEN : 9 am–8:45 pm Monday-Saturday",
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

            //////////////////// BOOK APPOINTMENT SECTION /////////////////////////////////
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

                  // BOOKING THROUGH NUMBER
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        bookingProvider.callNumber("9844533685");
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

                  // BOOKING THROUGH WHATSAPP
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        bookingProvider.openWhatsApp(
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
                              "mahsoommuhammed9844@gmail.com",
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
                    const SizedBox(height: 10),
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 2),
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
