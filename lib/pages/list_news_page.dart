import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsproject_finalmobile/model/listinfo_news_model.dart';
import 'package:newsproject_finalmobile/pages/insert_news_page.dart';
import 'package:newsproject_finalmobile/pages/login_page.dart';
import 'package:newsproject_finalmobile/pages/update_news_page.dart';
import 'package:newsproject_finalmobile/repos/Login_page_repo.dart' as LoginRepo;
import 'package:newsproject_finalmobile/repos/Insert_page_repo.dart';

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: InkWell(
        onTap:(){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: _buildBody,
      ),
    );
  }

  get _buildAppBar{
    return AppBar(
      title: Text("Messenger"),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
      actions: [
        IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
          LoginRepo.signOut().then((value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage())));

        },),
        IconButton(icon: Icon(Icons.add_box), onPressed: (){
          LoginRepo.signOut().then((value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => InsertPage())));

        },),
      ],
    );
  }
  get _buildBody{
    return Container(
      alignment: Alignment.center,
      child: _buildStreamArticle,
    );
  }


  var _titleCtrl = TextEditingController();
  var _captionCtrl = TextEditingController();
  var _imageCtrl = TextEditingController();
  var _decsCtrl = TextEditingController();

  ListInfo _selectedListInfo = ListInfo();
  bool _isUpdating = false;


  get _buildStreamArticle{
    return Container(
      child:  StreamBuilder<QuerySnapshot>(
          stream: streamAllListInfo(),
          builder: (context, snapshot){
            if (snapshot.hasError){
              print("Error: ${snapshot.error}");
              return Text("Something went wrong");
            }
            if (snapshot.hasData){
              List<ListInfo> itemList =
              getListInfoListFromSnapshot(snapshot.data.docs);
              return _buildListView(itemList);
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  _buildListView(List<ListInfo> items){
    return ListView.builder(
        shrinkWrap: true,
        reverse: true,
        itemCount: items.length,
        itemBuilder: (context, index){
          return _buildItem(items[index]);
        }
    );
  }

  _buildItem(ListInfo item){
    return Container(
      child: InkWell(
        onLongPress: (){
          _showAlertDialog(item);
        },
        child: _buildCard(item),
        ),
    );
  }

  _buildCard(ListInfo item){
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Text("${item.title}"),
          ),
            Container(
              height: 400,
              width: 400,
              padding: EdgeInsets.all(5),
              child: "${item.image}" != null
                  ? _buildArticleImage(item)
                  : Text("${item.caption}"),
            ),
        ],
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
                  _buildMenu("Reply", icon: Icons.reply, onTap: (){
                    Navigator.of(context).pop();
                  }),
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
                      Navigator.of(context).pop();
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

  Container _buildArticleImage(ListInfo item) {
    return Container(
      height: 400,
      width: 400,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.black12,
          image: DecorationImage(
            image: NetworkImage("${item.image}"),
            fit: BoxFit.cover,
          ),
          border: Border.all(width: 5, color: Colors.black12),
        ),
      ),
    );
  }

  }

