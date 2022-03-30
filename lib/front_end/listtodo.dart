import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart' as color;

class ListToDo extends StatelessWidget {
  final List<dynamic> allToDoList;
  const ListToDo({
    Key? key,
    required this.allToDoList,
  }) : super(key: key);

  final bool checkedTodo = true;

  List<Widget> allToDo() {
    List<Widget> data = [];
    for (var i = 0; i < 5; i++) {
      data.add(
        Container(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 2,
                  ),
                  Checkbox(
                    value: checkedTodo,
                    activeColor: color.AppColor.Font_sub.withOpacity(0.5),
                    checkColor: Colors.white,
                    onChanged: (value) {},
                  ),
                  Icon(
                    IconData(0xe158, fontFamily: 'MaterialIcons'),
                    color: color.AppColor.Gradient1,
                    size: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Differential Equation",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "work",
                          style: TextStyle(fontSize: 10, height: 0.7),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                  //height: 20,
                  thickness: 1,
                  color: color.AppColor.NameWidget),
            ],
          ),
        ),
      );
    }
    return data;
  }

  /* final List dummyList = List.generate(1000, (index) {
    return {
      "id": index,
      "title": "This is the title $index",
      "subtitle": "This is the subtitle $index"
    };
  }); */

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.AppColor.WidgetBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20), //border corner radius
      ),
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  "List to do",
                  style: TextStyle(
                    color: color.AppColor.NameWidget,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 3.0),
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: color.AppColor.box_class,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 5,
                              color: Colors.grey.withOpacity(0.8))
                        ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              IconData(
                                0xe047,
                                fontFamily: 'MaterialIcons',
                              ),
                              size: 24,
                              color: color.AppColor.NameWidget,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Add work",
                                      style: TextStyle(
                                          color: color.AppColor.NameWidget),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Divider(
                            //height: 20,
                            thickness: 1,
                            color: color.AppColor.NameWidget),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 2,
                              ),
                              Icon(
                                IconData(0xe158, fontFamily: 'MaterialIcons'),
                                color: color.AppColor.Gradient1,
                                size: 20,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Differential Equation",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "work",
                                      style:
                                          TextStyle(fontSize: 10, height: 0.7),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Divider(
                            //height: 20,
                            thickness: 1,
                            color: color.AppColor.NameWidget),

                        Column(children: allToDo()),
                        Row(
                          children: [
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              IconData(0xe098, fontFamily: 'MaterialIcons'),
                              color: color.AppColor.Gradient1,
                              size: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Done",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),

                        Divider(
                            //height: 20,
                            thickness: 1,
                            color: color.AppColor.NameWidget),

                        //? This is add to do button
                        /* ListTile(
                          onTap: () {
                            print("to do pressed!");
                          },
                          leading: Icon(
                            IconData(
                              0xe047,
                              fontFamily: 'MaterialIcons',
                            ),
                          ),
                          title: Text("Add to do"),
                        ),
                        Divider(
                            //height: 20,
                            thickness: 1,
                            color: color.AppColor.NameWidget),
                         */ //? Under this line is all to do that in saved file.
                        //Row(children: allToDo(context)),
                        /* ListView.builder(
                          itemCount: dummyList.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 6,
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(dummyList[index]["id"].toString()),
                                backgroundColor: Colors.purple,
                              ),
                              title: Text(dummyList[index]["title"]),
                              subtitle: Text(dummyList[index]["subtitle"]),
                              trailing: Icon(Icons.add_a_photo),
                            ),
                          ),
                        ), */
                        //? done title.
                        /*  ListTile(
                          onTap: () {
                            print("to do pressed!");
                          },
                          leading: Icon(
                            IconData(0xe098, fontFamily: 'MaterialIcons'),
                          ),
                          title: Text("Done"),
                        ),
                        Divider(
                            //height: 20,
                            thickness: 1,
                            color: color.AppColor.NameWidget),
 */
                        //? Under here is all done work.
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
