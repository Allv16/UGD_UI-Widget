import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/reservation_form_new.dart';
import 'package:ugd_ui_widget/entity/Dokter.dart';
import 'package:ugd_ui_widget/client/doctor_client.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DoctorList extends StatefulWidget {
  final String poly;
  final String bpjsNumber;
  const DoctorList({Key? key, required this.poly, required this.bpjsNumber})
      : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  Future<List<Dokter>>? _dokterList;
  Future<List<Dokter>>? _fetchData() async {
    final data = await doctorClient.fetchDokterBySpecialization(widget.poly);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.poly} Doctors List',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: FutureBuilder(
              future: _fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                } else {
                  return snapshot.data == null || snapshot.data!.isEmpty
                      ? const Center(child: Text("No Reservation"))
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return _doctorListTile(
                                snapshot.data![index].nama,
                                snapshot.data![index].profileDokter,
                                snapshot.data![index].id.toString());
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                        );
                }
              }),
        )));
  }

  ListTile _doctorListTile(String name, String profile, String id) {
    return ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage("images/doctors/$profile"),
        ),
        title: Text(
          "Dr. $name",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 20.sp,
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ReservationForm(
              idDoctor: id,
              bpjsNumber: widget.bpjsNumber,
              doctor_name: name,
            );
          }));
        });
  }
}
