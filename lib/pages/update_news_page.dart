import 'package:flutter/material.dart';
import 'package:newsproject_finalmobile/model/listinfo_news_model.dart';
import 'package:newsproject_finalmobile/pages/login_page.dart';
import 'package:newsproject_finalmobile/repos/Insert_page_repo.dart' as insertRepo;
import 'package:newsproject_finalmobile/repos/Insert_page_repo.dart';

class UpdatePage extends StatefulWidget {
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  get _buildAppBar {
    return AppBar(
      title: Text("update NEWS"),
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
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          _buildTitleField,
          SizedBox(height: 10),
          _buildImageField,
          SizedBox(height: 10),
          _buildBodyField,
          SizedBox(height: 10),
          _buildSendButton,

        ],
      ),
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
          hintText:  "Say something ..... ",
          border: InputBorder.none,
        ),
      ),
    );
  }
  get _buildBodyField{
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
          hintText:  "Say something ..... ",
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
          hintText:  "Say something ..... ",
          border: InputBorder.none,
        ),
      ),
    );
  }
  ListInfo _selectedListInfo = ListInfo();
  bool _isUpdating = true;

  get _buildSendButton{
    return IconButton(icon: Icon(_isUpdating ? Icons.update: Icons.send), onPressed: (){
      if (_isUpdating){
        _selectedListInfo.title = _titleCtrl.text.trim();
        _selectedListInfo.caption = _captionCtrl.text.trim();
        _selectedListInfo.image = _imageCtrl.text.trim();
        _selectedListInfo.decs = _decsCtrl.text.trim();

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
//
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
