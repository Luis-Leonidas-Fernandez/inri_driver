

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inri_driver/blocs/base/base_bloc.dart';
import 'package:inri_driver/blocs/user/auth_bloc.dart';
import 'package:inri_driver/models/base.dart';
import 'package:inri_driver/service/base_service.dart';

import 'package:inri_driver/widgets/alert_screen.dart';



class BasePage extends StatefulWidget {


  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState(); 

}

class _BasePageState extends State<BasePage> {



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) { 

           final isactiveBase = state.usuario?.base?[0] ?? [];


           return isactiveBase is String
           ?  MapZonas(size: size) 
           :  Container(width: size.width, height: size.height, color: Colors.green); 
          }
          )
      ),
    );
  }
}

class MapZonas extends StatefulWidget {
 
  final Size size;
  const MapZonas({Key? key, required this.size}) : super(key: key);

  @override
  State<MapZonas> createState() => _MapZonasState();
}

class _MapZonasState extends State<MapZonas> {
  
   @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(


        children: [

          SelectArea(size: widget.size),

          const ButtonGoHome()

          


        ] 
      ),
    );
  }
}

class TittleAddZona extends StatelessWidget {
  
  final Size size;
  const TittleAddZona({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
          color: Colors.transparent,
          width: size.width * 0.9,
          height: size.height * 0.1,
          child: Text(
            'Elige una Base donde deseas trabajar',
            style:  GoogleFonts.satisfy(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 2, 31, 192),
              letterSpacing: .7
               ),
          ),
      ),
    );
  }
}

class SelectArea extends StatelessWidget {

  final Size size;
  const SelectArea({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return  ListView(
      children: [
        
        const SizedBox(height: 15),

        TittleAddZona(size: size),
        
        Stack(
          children: [

          Container(
          color: Colors.transparent,
          width: double.infinity,
          height:  size.height *0.58,
          child: Image.asset('assets/map.webp',
          fit: BoxFit.fill,
          ),        
         ),

          const Positioned(
            top: 100,
            left: 68,
            child: DroopButton()),

          const Positioned(
            top: 100,
            left: 275,
            child: DroopButtonB()),

          const Positioned(
            top: 270,
            left: 76,
            child: DroopButtonC()),

          const Positioned(
            top: 272,
            left: 278,
            child: DroopButtonD()),
          ]
        ),
      
      Container(width: size.width, height: 15, color: Colors.transparent,),
    
      Stack(
        children: [
             Container(
          color: Colors.transparent,
          width: double.infinity,
          height:  size.height *0.48,
          child: Image.asset('assets/fontana.webp',
          fit: BoxFit.fill,
          )
         ),

         const Positioned(
            top: 220,
            left: 200,
            child: DroopButtonF() ),
        ] 
      ),

       Container(width: size.width, height: 15, color: Colors.transparent,),

       Stack(
        children: [
             Container(
          color: Colors.transparent,
          width: double.infinity,
          height:  size.height *0.48,
          child: Image.asset('assets/barranqueras.webp',
          fit: BoxFit.fill,
          )
         ),

         const Positioned(
            top: 190,
            left: 160,
            child: DroopButtonG() ),
        ] 
      ),


       

        Container(width: size.width, height: 50, color: Colors.transparent,),   
      ] 
    );
  }
}

class ButtonGoHome extends StatelessWidget {

 

  const ButtonGoHome({Key? key, }) : super(key: key);
  


  @override
  Widget build(BuildContext context) {
    
    final basebloc = BlocProvider.of<BaseBloc>(context);
    late BaseService baseService = BaseService();
    

    return Positioned(
       bottom: 25,
       right: 25,
       left: 25,
      child: BlocBuilder<BaseBloc, BaseState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () async{
          
              
              final base = basebloc.state.baseSelected ?? {} as BaseModel;
              
              final registerOk = await baseService.addDriverToBase(base);             
                      
             


              if(registerOk == true && context.mounted){              

               Navigator.pushReplacementNamed(context, 'loading');

              }else if(registerOk == false && context.mounted){

               mostrarAlerta(context, 'Base no Activa', 'elije otra desde el menu de opciones' );

               }
              

            },

            style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
            const Color.fromARGB(255, 122, 140, 241)
             ),
             backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 11, 38, 192))
            ),
            child: const Text(
              'SIGUIENTE',
               style: TextStyle(
               color: Colors.white,
               fontSize: 18 
                ),)
            );
        }
      ),
    );
  }
}

class DroopButton extends StatefulWidget {

  const DroopButton({Key? key}) : super(key: key);

  @override
  State<DroopButton> createState() => _DroopButtonState();
}

class _DroopButtonState extends State<DroopButton> {

  String dropdownValue = '1';
  String a = 'A';

  BaseModel? baseSelected;
  BaseBloc? baseBloc;

  @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {

    final baseBloc = BlocProvider.of<BaseBloc>(context);

    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        return Container(
               width: 65,
               height: 45,
               decoration: BoxDecoration(
               color: const Color.fromARGB(255, 159, 173, 252),
               borderRadius: BorderRadius.circular(10)
             ),
              child: Center(
                    child: DropdownButton<String>(
                    value: dropdownValue,             
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                    onChanged: (String? newValue) async {                
            
                    dropdownValue = newValue!;                
                              
           
                    final value = {"zona": a, "base": dropdownValue}; 
                    final data = BaseModel.fromJson(value);
         
                    debugPrint("value: $value");
                    debugPrint("data: $data");
         
           
                    baseBloc.add(AddBaseEvent(data));
                    Future.delayed(const Duration(seconds: 10));                  
           
         
         
          },
          items: const [
           DropdownMenuItem(
             value: '1',
             child: Text('1') 
             ),
             DropdownMenuItem(
             value: '2',
             child: Text('2') 
             ),
             DropdownMenuItem(
             value: '3',
             child: Text('3') 
             ),
             DropdownMenuItem(
             value: '4',
             child: Text('4') 
             )
          ],
             ),
           ),
         );
      }
    );
    
    
    
  }
}

class DroopButtonB extends StatefulWidget {

  const DroopButtonB({Key? key}) : super(key: key);

  @override
  State<DroopButtonB> createState() => _DroopButtonBState();
}

class _DroopButtonBState extends State<DroopButtonB> {

  String dropdownValue = '1';
  String b = 'B';

  BaseModel? baseSelected;
  BaseBloc? baseBloc;

  @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final baseBloc = BlocProvider.of<BaseBloc>(context);

    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        return Container(
               width: 65,
               height: 45,
               decoration: BoxDecoration(
               color: const Color.fromARGB(255, 159, 173, 252),
               borderRadius: BorderRadius.circular(10)
             ),
              child: Center(
                    child: DropdownButton<String>(
                    value: dropdownValue,             
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                    onChanged: (String? newValue) async {                
            
                    dropdownValue = newValue!;                
                              
           
                    final value = {"zona": b, "base": dropdownValue}; 
                    final data = BaseModel.fromJson(value);
         
                    debugPrint("value: $value");
                    debugPrint("data: $data");
         
           
                    baseBloc.add(AddBaseEvent(data));
                    Future.delayed(const Duration(seconds: 10));                  
           
         
         
          },
          items: const [
           DropdownMenuItem(
             value: '1',
             child: Text('1') 
             ),
             DropdownMenuItem(
             value: '2',
             child: Text('2') 
             ),
             DropdownMenuItem(
             value: '3',
             child: Text('3') 
             ),
             DropdownMenuItem(
             value: '4',
             child: Text('4') 
             )
          ],
             ),
           ),
         );
      }
    );
    
    
    
  }
}

class DroopButtonC extends StatefulWidget {

  const DroopButtonC({Key? key}) : super(key: key);

  @override
  State<DroopButtonC> createState() => _DroopButtonCState();
}

class _DroopButtonCState extends State<DroopButtonC> {



  String dropdownValue = '1';
  String c = 'C';

  BaseModel? baseSelected;
  BaseBloc? baseBloc;

  @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final baseBloc = BlocProvider.of<BaseBloc>(context);

    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        return Container(
               width: 65,
               height: 45,
               decoration: BoxDecoration(
               color: const Color.fromARGB(255, 159, 173, 252),
               borderRadius: BorderRadius.circular(10)
             ),
              child: Center(
                    child: DropdownButton<String>(
                    value: dropdownValue,             
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                    onChanged: (String? newValue) async {                
            
                    dropdownValue = newValue!;                
                              
           
                    final value = {"zona": c, "base": dropdownValue}; 
                    final data = BaseModel.fromJson(value);
         
                    debugPrint("value: $value");
                    debugPrint("data: $data");
         
           
                    baseBloc.add(AddBaseEvent(data));
                    Future.delayed(const Duration(seconds: 10));                  
           
         
         
          },
          items: const [
           DropdownMenuItem(
             value: '1',
             child: Text('1') 
             ),
             DropdownMenuItem(
             value: '2',
             child: Text('2') 
             ),
             DropdownMenuItem(
             value: '3',
             child: Text('3') 
             ),
             DropdownMenuItem(
             value: '4',
             child: Text('4') 
             )
          ],
             ),
           ),
         );
      }
    );
    
    
    
  }
}

class DroopButtonD extends StatefulWidget {

  const DroopButtonD({Key? key}) : super(key: key);

  @override
  State<DroopButtonD> createState() => _DroopButtonDState();
}

class _DroopButtonDState extends State<DroopButtonD> {

  String dropdownValue = '1';
  String d = 'D';

  BaseModel? baseSelected;
  BaseBloc? baseBloc;

  @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final baseBloc = BlocProvider.of<BaseBloc>(context);

    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        return Container(
               width: 65,
               height: 45,
               decoration: BoxDecoration(
               color: const Color.fromARGB(255, 159, 173, 252),
               borderRadius: BorderRadius.circular(10)
             ),
              child: Center(
                    child: DropdownButton<String>(
                    value: dropdownValue,             
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                    onChanged: (String? newValue) async {                
            
                    dropdownValue = newValue!;                
                              
           
                    final value = {"zona": d, "base": dropdownValue}; 
                    final data = BaseModel.fromJson(value);
         
                    debugPrint("value: $value");
                    debugPrint("data: $data");
         
           
                    baseBloc.add(AddBaseEvent(data));
                    Future.delayed(const Duration(seconds: 10));                  
           
         
         
          },
          items: const [
           DropdownMenuItem(
             value: '1',
             child: Text('1') 
             ),
             DropdownMenuItem(
             value: '2',
             child: Text('2') 
             ),
             DropdownMenuItem(
             value: '3',
             child: Text('3') 
             ),
             DropdownMenuItem(
             value: '4',
             child: Text('4') 
             )
          ],
             ),
           ),
         );
      }
    );
    
    
    
  }
}

class DroopButtonF extends StatefulWidget {

  const DroopButtonF({Key? key}) : super(key: key);

  @override
  State<DroopButtonF> createState() => _DroopButtonFState();
}

class _DroopButtonFState extends State<DroopButtonF> {

  String dropdownValue = '1';
  String f = 'F';

  BaseModel? baseSelected;
  BaseBloc? baseBloc;

  @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final baseBloc = BlocProvider.of<BaseBloc>(context);

    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        return Container(
               width: 65,
               height: 45,
               decoration: BoxDecoration(
               color: const Color.fromARGB(255, 159, 173, 252),
               borderRadius: BorderRadius.circular(10)
             ),
              child: Center(
                    child: DropdownButton<String>(
                    value: dropdownValue,             
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                    onChanged: (String? newValue) async {                
            
                    dropdownValue = newValue!;                
                              
           
                    final value = {"zona": f, "base": dropdownValue}; 
                    final data = BaseModel.fromJson(value);
         
                    debugPrint("value: $value");
                    debugPrint("data: $data");
         
           
                    baseBloc.add(AddBaseEvent(data));
                    Future.delayed(const Duration(seconds: 10));                  
           
         
         
          },
          items: const [
           DropdownMenuItem(
             value: '1',
             child: Text('1') 
             ),
             DropdownMenuItem(
             value: '2',
             child: Text('2') 
             ),
             DropdownMenuItem(
             value: '3',
             child: Text('3') 
             ),
             DropdownMenuItem(
             value: '4',
             child: Text('4') 
             )
          ],
             ),
           ),
         );
      }
    );
    
    
    
  }
}


class DroopButtonG extends StatefulWidget {

  const DroopButtonG({Key? key}) : super(key: key);

  @override
  State<DroopButtonG> createState() => _DroopButtonGState();
}

class _DroopButtonGState extends State<DroopButtonG> {

  String dropdownValue = '1';
  String g = 'G';

  BaseModel? baseSelected;
  BaseBloc? baseBloc;

  @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final baseBloc = BlocProvider.of<BaseBloc>(context);

    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        return Container(
               width: 65,
               height: 45,
               decoration: BoxDecoration(
               color: const Color.fromARGB(255, 159, 173, 252),
               borderRadius: BorderRadius.circular(10)
             ),
              child: Center(
                    child: DropdownButton<String>(
                    value: dropdownValue,             
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                    onChanged: (String? newValue) async {                
            
                    dropdownValue = newValue!;                
                              
           
                    final value = {"zona": g, "base": dropdownValue}; 
                    final data = BaseModel.fromJson(value);
         
                    debugPrint("value: $value");
                    debugPrint("data: $data");
         
           
                    baseBloc.add(AddBaseEvent(data));
                    Future.delayed(const Duration(seconds: 10));                  
           
         
         
          },
          items: const [
           DropdownMenuItem(
             value: '1',
             child: Text('1') 
             ),
             DropdownMenuItem(
             value: '2',
             child: Text('2') 
             ),
             DropdownMenuItem(
             value: '3',
             child: Text('3') 
             ),
             DropdownMenuItem(
             value: '4',
             child: Text('4') 
             )
          ],
             ),
           ),
         );
      }
    );
    
    
    
  }
}