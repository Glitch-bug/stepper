import 'package:flutter/material.dart';
import 'package:stepper/step_provider.dart';
import 'package:provider/provider.dart';

class Next extends StatelessWidget {
  const Next({super.key});

  @override 
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: (_) => StepperState(), 
      child: Scaffold(
        appBar: AppBar(title: Text("Test Page"),),
        body: MagicStepper( 
          steps: [
            Mstep(
              title:const Text("Step 1 title"), 
              self:0,
              icon: Icons.favorite, 
              length: 3,
              // ignore: avoid_print
              onPressed: (){
                print("Here");
                },
              content: Container(
                alignment: Alignment.centerLeft,
                child: const Text('Content for Step 1',)),
            ),
            Mstep(
              title:const Text("Step 2 title"), 
              self:1, 
              length:3,
              content: Container(
                alignment: Alignment.centerLeft,
                child: const Text('Content for Step 2',)),
            ),
            Mstep(
              title:const Text("Step 3 title"), 
              self:2, 
              length: 3,
              content: Container(
                alignment: Alignment.centerLeft,
                child: const Text('Content for Step 3',)),
            )

             ],
          ),       
        floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
        tooltip: 'Next',
        child: const Icon(Icons.add),
      )),
    );
  }
}


class MagicStepper extends StatelessWidget {
  List <Mstep> steps;

  MagicStepper({super.key, required this.steps});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: 
        List<Widget>.generate(steps.length, (index){
          return steps[index];
        })
      ,),
    );
  }
}

class Mstep extends StatelessWidget {
  Widget title;
  Widget content;
  int self;
  int length;
  IconData? icon;
  VoidCallback? onPressed;
  Mstep({super.key, required this.title, required this.content, required this.self, required this.length, this.onPressed, this.icon});
  
  @override
  Widget build(BuildContext context){
    return Column(children: [
        Row(
          children: [
            // (icon == null)?
            Container(
              alignment: Alignment.center,
              width: 30,
              height: 30, 
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: (self < context.watch<StepperState>().current)?context.watch<StepperState>().dcolors[0]: (self == context.watch<StepperState>().current)?context.watch<StepperState>().dcolors[1]:context.watch<StepperState>().dcolors[2],          
                boxShadow: [
                  BoxShadow(
                    color:(self == context.watch<StepperState>().current)?context.watch<StepperState>().dcolors[1]:Color(0xff),
                    blurRadius: 10,
                  )
                ]
              ),
              child: 
              (icon == null)? 
              Text(
                "${self+1}",
                style: TextStyle(color:Colors.white)
              ):Icon(icon, color: Colors.white,),
            ),
            Padding(
              padding: const EdgeInsets.all(12.5),
              child: title,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15,5,0,5),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.grey))),
                child: Column(
                  children: [
                    Visibility(
                      visible: self<(length -1),
                      child: Container(
                        padding: EdgeInsets.only(left:25),
                        child: Column(
                          children: [
                            Visibility(
                              visible: self == context.watch<StepperState>().current,
                              child: Column(
                                children: [
                                  content,
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: (){
                                          if (onPressed != null){
                                            onPressed!();
                                            context.read<StepperState>().change(self+1);
                                          }else {
                                            context.read<StepperState>().change(self+1);
                                          }
                                        }, 
                                        child: Text("CONTINUE")
                                      ), 
                                      TextButton(
                                        onPressed: (){
                                          if (self != 0)
                                          context.read<StepperState>().change(self-1);
                                        }, 
                                        child: Text("CANCEL")
                                      )],),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:25.0),
                child: Visibility(
                  visible: self == length - 1,
                  child: Visibility(
                      visible: self == context.watch<StepperState>().current,
                      child: Column(
                        children: [
                          content,
                          Row(children: [ElevatedButton(onPressed: (){
                            if (onPressed != null){
                              onPressed!();
                            }
                          }, child: Text("CONTINUE")), 
                          TextButton(
                            onPressed: (){
                              if (self != 0)
                                context.read<StepperState>().change(self-1);
                            }, 
                            child: Text("CANCEL")
                          )],
                        ),
                        ],
                      ),
                    ),
                ),
              )
            ],
          ),
        ),
      ],);
    }
  }