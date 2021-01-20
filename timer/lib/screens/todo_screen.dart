import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timer/models/database.dart';
import 'package:timer/models/date_format.dart';
import 'package:timer/models/todo_model.dart';

// ignore: must_be_immutable
class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 

  var db = DatabaseHelper();

  List<TodoItem> todoItems = [];

  String userSelected;
  @override
  void initState() {
    _readTodoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.teal),
            title: Text(
              "المهام",
              style: TextStyle(color: Colors.teal),
            ),
          ),
          body: todoItems.length == 0
              ? buildTextListEmpty()
              : ListView.builder(
                  itemCount: todoItems.length,
                  itemBuilder: (context, index) => Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                                                    _handleDelete(todoItems[index].id, index);

                
              },
            ),
                            
                            SizedBox(width: 10),
                            Text(
                              todoItems[index].itemName,
                              overflow: TextOverflow.clip,
                              maxLines: 3,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: Text(
                            "${todoItems[index].date}",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              buildAlert(
                context,
                " اضافة مهمة",
                () async {
                  if (_formKey.currentState.validate()) {
                    _handleSubmit(textEditingController.text);
                    textEditingController.clear();

                    Navigator.pop(context);
                  }
                },
                "اضافة",
              ).show();
            },
            backgroundColor: Colors.teal,
            child: Icon(
              FontAwesomeIcons.plusCircle,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Alert buildAlert(
      BuildContext context, String title, Function function, String text) {
    return Alert(
        context: context,
        title: title,
        style: AlertStyle(
          titleStyle: TextStyle(
            color: Colors.teal,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: textEditingController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[900],
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    hintText: 'اسم المهمة',
                  ),
                  validator: (value) => value.length <= 1
                      ? "لا تكن بخيلا،حرفا واحدا لايكفي"
                      : null,
                ),
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            color: Colors.teal,
            onPressed: function,
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]);
  }

  Center buildTextListEmpty() {
    return Center(
      child: Text(
        "لم تضف أي أنشطة أو مشروعات حتى الآن",
        style: GoogleFonts.changa(
          color: Colors.teal,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  _readTodoList() async {
    List item = await db.getAllItems();
    item.forEach((item) {
      // todoItem = TodoItem.fromMap(item);
      // print(todoItem.itemName);
      setState(() {
        todoItems.add(TodoItem.map(item));
      });
    });
  }

  _handleSubmit(String text) async {
    TodoItem item = TodoItem(
      text,
      formatted,
    );
    int savedItemId = await db.saveItem(item);
    TodoItem saveItem = await db.getTodoItem(savedItemId);

    setState(() {
      todoItems.insert(0, saveItem);
    });
  }

  // void _handleUpdate(int index, TodoItem updateItem) {
  //   setState(() {
  //     todoItems.removeWhere((element) {
  //       todoItems[index].itemName == updateItem.itemName;
  //     });
  //   });
  // }

  void _handleDelete(int id, int index) async {
    await db.deleteItem(id);
    setState(() {
      todoItems.removeAt(index);
    });
  }
}



// PopupMenuButton(
//                                 color: Colors.grey[200],
//                                 onSelected: (select) {
//                                   if (select == 'edit') {
//                                     buildAlert(
//                                       context,
//                                       " تعديل المهمة",
//                                       () async {
//                                         TodoItem updateItem = TodoItem.fromMap(
//                                           {
//                                             'itemName':
//                                                 textEditingController.text,
//                                             'dateCreated': formatted,
//                                             'id': todoItems[index].id,
//                                           },
//                                         );
//                                         _handleUpdate(index, updateItem);
//                                         await db.updateItem(updateItem);
//                                         setState(
//                                           () {
//                                             _readTodoList();
//                                           },
//                                         );
//                                         textEditingController.clear();

//                                         Navigator.pop(context);
//                                       },
//                                       "تعديل",
//                                     ).show();
//                                   } else if (select == 'delete') {
//                                     _handleDelete(todoItems[index].id, index);
//                                   }
//                                 },
//                                 icon: Icon(
//                                   Icons.more_vert,
//                                 ),
//                                 itemBuilder: (BuildContext context) {
//                                   return [
//                                     PopupMenuItem(
//                                       value: "edit",
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                         children: [
//                                           Text(
//                                             "تعديل",
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           Icon(
//                                             FontAwesomeIcons.pen,
//                                             color: Colors.black,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     PopupMenuItem(
//                                       value: "delete",
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                         children: [
//                                           Text(
//                                             "حذف",
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           Icon(
//                                             FontAwesomeIcons.trash,
//                                             color: Colors.black,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ];
//                                 },
//                               ),