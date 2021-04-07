import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsproject_finalmobile/Component/CardBox.dart';
import 'package:newsproject_finalmobile/Component/ListScroll.dart';
import 'package:newsproject_finalmobile/Component/buttonsearch.dart';
import 'package:newsproject_finalmobile/model/listinfo_news_model.dart';
import 'package:newsproject_finalmobile/pages/detail_page.dart';
import 'package:newsproject_finalmobile/repos/Insert_page_repo.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

var scaffolKey = GlobalKey<ScaffoldState>();

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolKey,
      //appBar: _buildAppBar,
      body: _buildBody,
      drawer: Drawer(),
    );
  }
  get _buildAppBar {
    return AppBar(

      // key: scaffolKey,
        backgroundColor: Colors.white,
        elevation: 0.4,
        leading: IconButton(
          onPressed: () {
            scaffolKey.currentState.openDrawer();
          },
          icon: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // color: Colors.grey,
            ),
            child: Icon(
              CupertinoIcons.text_alignleft,
              color: Colors.black,
            ),
          ),
        ),
        title: new Text(
          "News",
          style: TextStyle(color: Colors.red, fontSize: 26),
        ),
        automaticallyImplyLeading: false);
  }
  get _buildBody {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Buttonsearch(
              hint: "Search here",
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 15),
                child: Row(
                  children: [
                    ListScroll(
                      title: "Today",
                      bgcolor: Color(0xFF192946),
                      tcolor: Colors.white,
                    ),
                    ListScroll(
                      title: "Fresh News",
                    ),
                    ListScroll(
                      title: "Hot News",
                    ),
                    ListScroll(
                      title: "International News ",
                    ),
                    ListScroll(
                      title: "Fresh News",
                    ),
                    ListScroll(
                      title: "Hot News",
                    ),
                    ListScroll(
                      title: "International News ",
                    )
                  ],
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.only(bottom: 50),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: _buildStreamArticle,
            ),
          ],
        ),
      ),
    );
  }
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
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 200),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index){
            return _buildItem(items[index]);
          }
      ),
    );
  }
  _buildItem(ListInfo item) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      user: item,
                    ),
                  ),
                );
              },
              child: CardBox(
                title: item.title,
                subtitle: item.caption,
                image: Image(
                  image: NetworkImage("${item.image}"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
