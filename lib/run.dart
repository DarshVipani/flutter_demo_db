import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_15/database.dart';
import 'package:lab_15/getbyid.dart';

class Run extends StatefulWidget {
  const Run({super.key});

  @override
  State<Run> createState() => _RunState();
}

class _RunState extends State<Run> {
  MyDatabase db = MyDatabase();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("********** call");
    // detail();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          appBar: AppBar(
            title: Text('Info'),

          ),

          body: FutureBuilder(
              future: db.selectAllState(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                  {
                    return Center(child: CircularProgressIndicator(),);
                  }
                else if(snapshot.hasData)
                  {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                        itemBuilder:(context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Getbyid(name: snapshot.data![index]['name']),));
                              },
                              title: Text(snapshot.data![index]['name']),
                              leading: Text(snapshot.data![index]['id'].toString()),

                              trailing: Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    //DELETE
                                    IconButton(
                                        onPressed: () async {
                                      await db.deleteState(snapshot.data![index]['id']);
                                      setState(() {});
                                    }, icon: Icon(Icons.delete)),

                                    //EDIT
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                TextEditingController name = TextEditingController();
                                                name.text = snapshot.data![index]['name'];

                                                return AlertDialog(
                                                  title: Text('Edit'),
                                                  content: TextField(
                                                    controller: name,
                                                  ),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          await db.updateState({'name':name.text,'id':snapshot.data![index]['id']});
                                                          Navigator.of(context).pop();
                                                    }, child: Text('Edit'))
                                                  ],
                                                );
                                              },
                                          ).then((value) => setState(() {})

                                          );
                                    }, icon: Icon(Icons.edit))
                                  ],
                                ),
                              ),

                            );
                        } ,
                    );
                  }
                return Text('No Data Found');
              },
          ),

          //ADD
          floatingActionButton: FloatingActionButton(
              onPressed:() {
                showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController name = TextEditingController();
                      return AlertDialog(
                        title: Text('Add'),
                        content: TextField(
                          controller: name,
                        ),

                        actions: [
                          ElevatedButton(
                              onPressed: () async {
                                await db.insertState({'name':name.text});
                                Navigator.of(context).pop();
                          }, child: Text('Add')
                          )

                        ],
                      );
                    },
                ).then((value) {
                  setState(() {});
                },);
              },
          child: Icon(Icons.add),),
        )
    );
  }
}
