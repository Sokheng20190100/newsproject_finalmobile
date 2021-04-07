import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsproject_finalmobile/Component/delete_page.dart';
import 'package:newsproject_finalmobile/Component/drawerslider.dart';
import 'package:newsproject_finalmobile/model/listinfo_news_model.dart';
import 'package:newsproject_finalmobile/pages/news_page.dart';
import 'package:newsproject_finalmobile/pages/update_news_page.dart';
import 'package:newsproject_finalmobile/repos/Insert_page_repo.dart';

class DetailPage extends StatefulWidget {
  final ListInfo user;

  const DetailPage({Key key, this.user}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}


class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar,
      body: _buildBody,
    );
  }
  var _titleCtrl = TextEditingController();
  var _captionCtrl = TextEditingController();
  var _imageCtrl = TextEditingController();
  var _decsCtrl = TextEditingController();

  ListInfo _selectedListInfo = ListInfo();
  bool _isUpdating = false;

  get _buildAppBar {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              _showAlertDialog(widget.user);
            },
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black,
            ))
      ],
    );
  }

  get _buildBody {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 450,
                  // margin: EdgeInsets.fromLTRB(1, 0, 1, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(
                          "${widget.user.image}",
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.brown,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            _showAlertDialog(widget.user);
                          },
                          icon: Icon(
                            Icons.more_horiz,
                            color: Colors.brown,
                          )),

                    ],

                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${widget.user.title}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 45,
                      fontFamily: 'RaleWayLight',
                      color: Color(0xFF082796),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.user.date}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xffC4C4C4)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // child: InkWell(
                    //   onTap: () {
                    //     print("object");
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       children: [
                    //         Text(
                    //           "widget.user.other1",
                    //           style: TextStyle(color: Colors.red),
                    //         ),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           "comments",
                    //           style: TextStyle(fontFamily: 'RaleWayBold'),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(

              children: [
                SizedBox(width: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Color(0xFF082796),
                      ),
                    ),
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.facebookF,
                        color: Color(0xFF082796),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Color(0xFF082796),
                      ),
                    ),
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.envelope,
                        color: Color(0xFF082796),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Color(0xFF082796),
                      ),
                    ),
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.twitter,
                        color: Color(0xFF082796),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF082796)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.share,
                        color: Color(0xFF082796),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 50),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Detail",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'RaleWayLight',
                        color: Color(0xFF082796),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "${widget.user.decs}",
                      textAlign: TextAlign.justify,
                      style:
                      TextStyle(fontSize: 18, fontFamily: 'RaleWayeLight'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  _showAlertDialog(ListInfo item){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Container(
              height: 180, alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMenu("Edit", icon: Icons.edit, onTap: (){
                    _titleCtrl.text = item.title;
                    _captionCtrl.text = item.caption;
                    _imageCtrl.text = item.image;
                    _decsCtrl.text = item.decs;

                    setState(() {
                      _selectedListInfo = item;
                      _isUpdating = false;
                    });
                    updateListInfo(_selectedListInfo).then((value) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => UpdatePage()));
                    });

                  }),
                  _buildMenu("Delete", icon: Icons.delete, onTap: (){
                    deleteListInfo(item).then((value) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DeletePage(),
                        ),
                      );
                    });
                  }),
                ],
              ),
            ),
          );
        });
  }
  _buildMenu(String text, {IconData icon,Function onTap}){
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.grey.withOpacity(0.1),
        margin: EdgeInsets.only(bottom: 5),
        height: 50,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}
