import 'package:flutter/material.dart';
import 'package:newsproject_finalmobile/Component/drawerslider.dart';
import 'package:newsproject_finalmobile/model/listinfo_news_model.dart';
import 'package:newsproject_finalmobile/pages/login_page.dart';
import 'package:newsproject_finalmobile/repos/Insert_page_repo.dart' as insertRepo;
import 'package:newsproject_finalmobile/repos/Insert_page_repo.dart';

class InsertPage extends StatefulWidget {
  @override
  _InsertPageState createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar,
      body: _buildBody,
      drawer: Drawer(),
    );
  }

  get _buildAppBar {
    return AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyApp2()));
      }),
      title: Text("Insert NEWS"),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
      actions: [
        IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()));
        },),
      ],

    );
  }

  get _buildBody {
    return Container(
      alignment: Alignment.center,
      child: _buildChatTextField,
    );
  }

  get _buildChatTextField {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        Column(
          children: [
            SizedBox(height: 50),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo1.jpg"),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            SizedBox(height: 50),
            _buildTitleField,
            SizedBox(height: 20),
            _buildCaptionField,
            SizedBox(height: 20),
            _buildImageField,
            SizedBox(height: 20),
            _buildDecsField,
            SizedBox(height: 20),
            _buildSendButton,

          ],
        ),
      ],
    );
  }
  var _titleCtrl = TextEditingController();
  var _captionCtrl = TextEditingController();
  var _imageCtrl = TextEditingController();
  var _decsCtrl = TextEditingController();

  get _buildTitleField{
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: _isUpdating
              ? Colors.yellow.withOpacity(0.2)
              : Colors.grey.withOpacity(0.1)),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: _titleCtrl,
        style: TextStyle(color: Colors.black),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText:  "Title ......",
          border: InputBorder.none,
        ),
      ),
    );
  }
  get _buildCaptionField{
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: _isUpdating
              ? Colors.yellow.withOpacity(0.2)
              : Colors.grey.withOpacity(0.1)),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: _captionCtrl,
        style: TextStyle(color: Colors.black),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText:  "Caption ..........",
          border: InputBorder.none,
        ),
      ),
    );
  }
  get _buildImageField{
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: _isUpdating
              ? Colors.yellow.withOpacity(0.2)
              : Colors.grey.withOpacity(0.1)),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: _imageCtrl,
        style: TextStyle(color: Colors.black),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText:  "Url Image .......",
          border: InputBorder.none,
        ),
      ),
    );
  }
  get _buildDecsField{
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: _isUpdating
              ? Colors.yellow.withOpacity(0.2)
              : Colors.grey.withOpacity(0.1)),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: _decsCtrl,
        style: TextStyle(color: Colors.black),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText:  "Long Decs ......",
          border: InputBorder.none,
        ),
      ),
    );
  }
  ListInfo _selectedListInfo = ListInfo();
  bool _isUpdating = false;

  get _buildSendButton{
    return IconButton(icon: Icon(_isUpdating ? Icons.update: Icons.upload_sharp),iconSize: 40, onPressed: (){
      if (_isUpdating){
        _selectedListInfo.title = _titleCtrl.text.trim();
        _selectedListInfo.caption= _captionCtrl.text.trim();
        _selectedListInfo.image = _imageCtrl.text.trim();
        _selectedListInfo.decs= _decsCtrl.text.trim();

        updateListInfo(_selectedListInfo).then((value){
          _titleCtrl.clear();
          _captionCtrl.clear();
          _imageCtrl.clear();
          _decsCtrl.clear();
          setState(() {
            _isUpdating = false;
          });
        });
      }
      else {
        ListInfo listinfo = ListInfo(
          title: _titleCtrl.text.trim(),
          caption: _captionCtrl.text.trim(),
          image: _imageCtrl.text.trim(),
          decs: _decsCtrl.text.trim(),
          date: DateTime.now().toUtc().toString(),
        );

        insertListInfo(listinfo).then((value){
          _titleCtrl.clear();
          _captionCtrl.clear();
          _imageCtrl.clear();
          _decsCtrl.clear();
        });
      }
    });
  }

  // get _buildStreamArticle{
  //   return Container(
  //     child:  StreamBuilder<QuerySnapshot>(
  //         stream: streamAllMessages(),
  //         builder: (context, snapshot){
  //           if (snapshot.hasError){
  //             print("Error: ${snapshot.error}");
  //             return Text("Something went wrong");
  //           }
  //           if (snapshot.hasData){
  //             List<Message> itemList =
  //             getMessageListFromSnapshot(snapshot.data.docs);
  //             return _buildListView(itemList);
  //           }else{
  //             return Center(child: CircularProgressIndicator());
  //           }
  //         }),
  //   );
  // }

  // _buildListView(List<Message> items){
  //   return ListView.builder(
  //       shrinkWrap: true,
  //       reverse: true,
  //       itemCount: items.length,
  //       itemBuilder: (context, index){
  //         return _buildItem(items[index]);
  //       }
  //   );
  // }
  // _buildItem(Message item){
  //   return Container(
  //     margin: EdgeInsets.only(left: 40,right: 10,bottom: 10),
  //     decoration: BoxDecoration(
  //       color: Colors.deepPurple.withOpacity(0.2),
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: InkWell(
  //       onLongPress: (){
  //         _showAlertDialog(item);
  //       },
  //       child: ListTile(
  //         title: Text("${item.text}"),
  //         subtitle: Text("${item.date}"),
  //       ),
  //     ),
  //   );
  // }
  // _showAlertDialog(Message item){
  //   showDialog(
  //       context: context,
  //       builder: (context){
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //           content: Container(
  //             height: 180, alignment: Alignment.center,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 _buildMenu("Reply", icon: Icons.reply, onTap: (){
  //                   Navigator.of(context).pop();
  //                 }),
  //                 _buildMenu("Edit", icon: Icons.edit, onTap: (){
  //                   _textCtrl.text = item.text;
  //                   setState(() {
  //                     _selectedMessage = item;
  //                     _isUpdating = true;
  //                   });
  //                   Navigator.of(context).pop();
  //                 }),
  //                 _buildMenu("Delete", icon: Icons.delete, onTap: (){
  //                   deleteMessage(item).then((value) {
  //                     Navigator.of(context).pop();
  //                   });
  //                 }),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  // _buildMenu(String text, {IconData icon,Function onTap}){
  //   return InkWell(
  //     onTap: onTap,
  //     child: Container(
  //       color: Colors.grey.withOpacity(0.1),
  //       margin: EdgeInsets.only(bottom: 5),
  //       height: 50,
  //       alignment: Alignment.center,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Text(text),
  //           Icon(icon),
  //         ],
  //       ),
  //     ),
  //   );
  // }

}
