/// Created by RongCheng on 2022/7/27.

import 'package:flutter/material.dart';
import 'package:flutter_image_browser/drag_widgets/drag_gesture_page_route.dart';
import 'package:flutter_image_browser/page/image_browser_page.dart';


class HomeGridPage extends StatelessWidget {
  const HomeGridPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Object> tags = List.generate(9, (index) => "tag_$index").toList();
    List<String> imagePaths = List.generate(9, (index) => "assets/images/p${index+1}.png").toList();

    return Scaffold(
      appBar: AppBar(title: const Text("九宫格"),),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 3,
            childAspectRatio: 1.5
        ),
        itemCount: 9,
        itemBuilder: (_,index){
          return Hero(
            tag: tags[index],
            placeholderBuilder: (ctx,heroSize,child){
              return child;
            },
            child: GestureDetector(
                onTap: (){
                  Navigator.push(context, DragGesturePageRoute(builder: (context) {
                    return ImageBrowserPage(tags: tags,imagePaths: imagePaths,index: index,);
                  },),);
                },
                child: Image.asset(imagePaths[index])
            ),
          );
        },
      ),
    );
  }
}


