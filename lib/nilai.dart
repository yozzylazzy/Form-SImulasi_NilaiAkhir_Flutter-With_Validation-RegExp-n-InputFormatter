import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NilaiAkhir extends StatefulWidget {
  const NilaiAkhir({Key? key}) : super(key: key);

  @override
  State<NilaiAkhir> createState() => _NilaiAkhirState();
}

class _NilaiAkhirState extends State<NilaiAkhir> {
  double _tugas = 50;
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  TextEditingController tugas = TextEditingController();
  TextEditingController uts = TextEditingController();
  TextEditingController uas = TextEditingController();
  TextEditingController na = TextEditingController();
  TextEditingController index = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulasi Hitung Nilai Akhir'),
        toolbarHeight: 70,
        backgroundColor: Colors.blue,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(icon: Icon(Icons.menu),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
        ],
      ),
      drawer: Drawer(
        width: 300,
        backgroundColor: Colors.black45,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                //image: Image.asset('images/git.png'),
                color: Colors.blue,

              ),
              child: Text(''),
            ),
            ListTile(
              leading: Icon(Icons.home,color: Colors.white),
              title: const Text('Home',
                  style: TextStyle(
                      color: Colors.white
                  )),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: const Text('User',
                  style: TextStyle(
                      color: Colors.white
                  )),
              onTap: (){
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _keyform,
                  child:  Column(
                    children: [
                      Center(
                        child: Text("SIMULASI NILAI AKHIR", textAlign: TextAlign.center,),
                      ),
                      separatorBox(0, 20),
                      textField("Tugas", tugas, Icon((Icons.task))),
                      separatorBox(0, 20),
                      textField("UTS", uts, Icon((Icons.task))),
                      separatorBox(0, 20),
                      textField("UAS", uas, Icon((Icons.task))),
                      separatorBox(0, 40),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(child:  submitButton(),),
                          separatorBox(100, 0),
                          Flexible(child: resetButton(),),
                        ],
                      ),

                      separatorBox(0, 40),
                      Row(
                        children: [
                          Flexible(child:  outputField("Nilai Akhir", na),),
                          separatorBox(10, 0),
                          Flexible(child:  outputField("Index Nilai Akhir", index),),
                        ],
                      ),
                    ],
                  ),
                )
            ),
          ),
      ),
    );
  }

  Widget textField(String a, TextEditingController controller, Icon icon){
    String atribut = a;
    TextEditingController control= controller;
    Icon iconicon = icon;
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)')),
      ],
        keyboardType: TextInputType.number,
        controller: control,
        validator: (value){
          bool nilaiValidator = RegExp(r'[a-zA-Z,-]').hasMatch(value.toString());

          if(value == null || value.isEmpty || value.toString() == "."){
            return 'Mohon Isikan Nilai ${a}';
          } else if (nilaiValidator || double.parse(value)>100){
            return 'Isi Nilai ${a} Belum Benar';
          }
          return null;
        },
      decoration: InputDecoration(
        labelText: atribut,
        labelStyle: TextStyle(
          color: Colors.deepPurple,
        ),
        prefixIcon: iconicon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  Widget separatorBox(double? width, double height){
    return SizedBox(
      width: width,
      height: height,
    );
  }
  Widget outputField(String a, TextEditingController controller){
    String atribut = a;
    TextEditingController control= controller;
    return TextFormField(
      controller: control,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.deepPurpleAccent,
        labelText: atribut,
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        prefixIcon: Icon(Icons.abc, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  Widget submitButton(){
    return ElevatedButton(
      onPressed: (){
        if(_keyform.currentState!.validate()){
            double a, b, c;
            String idx;
            a = double.parse(tugas.text);
            b = double.parse(uts.text);
            c = double.parse(uas.text);

            double hasil = (0.2 * a) + (0.3 * b) + (0.5*c);
            if(hasil>=80){
              idx= "A";
            } else if (hasil >=77){
              idx = "A-";
            } else if (hasil>=73){
              idx="B+";
            }else if(hasil>=70){
              idx="B";
            }else if (hasil>=67){
              idx = "B-";
            } else if(hasil>=63){
              idx = "C+";
            } else if (hasil>= 60){
              idx = "C";
            }else {
              idx = "Tidak Lulus";
            }
            print(hasil);
            final updateNA = hasil.toString();
              na.value = na.value.copyWith(
                text:  updateNA,
                selection: TextSelection.collapsed(offset: updateNA.length),
              );
              index.value = index.value.copyWith(
                text: idx,
                selection: TextSelection.collapsed(offset: idx.length),
              );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Data Nilai Belum Lengkap....."))
          );
        }
      },
      child: Text(
          'Submit'
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.lightBlue,
        fixedSize: Size(150.0, 50.0),
        shadowColor: Colors.deepPurple,
      ),
    );
  }
  Widget resetButton(){
    return ElevatedButton(
      onPressed: (){
        //memanggil method validate dari keyform dengan currentState (bisa banyak currentCOntext, dll)
        tugas.clear();
        uts.clear();
        uas.clear();
        na.clear();
        index.clear();
      },
      child: Text(
          'Reset'
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.grey,
        fixedSize: Size(150.0, 50.0),
        shadowColor: Colors.lightBlueAccent,
      ),
    );
  }
}
