import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:season3_team1_mainproject/view/community.dart';

import 'board_update.dart';

class BoardDetail extends StatefulWidget {
  const BoardDetail({super.key});

  @override
  State<BoardDetail> createState() => _BoardDetailState();
}

class _BoardDetailState extends State<BoardDetail> {
  late TextEditingController commentController;

  @override
  void initState() {
    super.initState();
    commentController = TextEditingController();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var board = Get.arguments ?? "_";
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Container(
                height: 50,
                width: 400,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: const Center(
                  child: Text(
                    '커뮤니티',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 300,
                  ),
                  Text(board.date),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    board.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 1.0,
                  ),
                  Text(
                    board.content,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  Divider(
                    thickness: 1.0,
                  ),
                  SizedBox(width: 10,height: 10,),
                  Text('댓글', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text(
                      'comment',
                    // board.comment,
                    style: TextStyle(fontSize: 15, ),
                  ),
                      SizedBox(
                    height: 5,),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/user.png',
                        ),
                        radius: 20,
                      ),
                      SizedBox(width: 10), // 간격 추가
                      Expanded(
                        // TextField를 확장하여 빈 공간을 모두 사용
                        child: TextField(
                          controller: commentController,
                          decoration: const InputDecoration(
                            hintText: '댓글을 입력해 주세요',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(340, 5, 0, 120),
                    child: ElevatedButton(
                          onPressed: () {
                            FirebaseFirestore.instance.collection('community').add({
                  'title': commentController.text,
                });
                          },
                            style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),),), //버튼 모양 각지게),
                          child: Text('입력'),
                        ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 140,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      //게시글 수정 기능
                      board.ref.update(
                          {'title': board.title, 'content': board.content});
                      Get.to(const BoardUpdate(), arguments: board);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // 아이콘과 텍스트를 중앙 정렬
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                          child: Icon(
                            Icons.edit_outlined,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                          child: Text('수정'),
                        ),
                      ],
                    ),
                    label: SizedBox.shrink(),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.defaultDialog(
                          title: '삭제',
                          middleText: '게시글을 삭제하시겠습니까?',
                          barrierDismissible: false,
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'EXIT',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      board.ref.delete();
                                      Get.off(const Community());
                                    },
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.red),
                                    child: Text(
                                      'DELETE',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    )),
                              ],
                            )
                          ]);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // 아이콘과 텍스트를 중앙 정렬
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                          child: Icon(
                            Icons.delete,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                          child: Text('삭제'),
                        ),
                      ],
                    ),
                    label: SizedBox.shrink(),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.to(Community());
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // 아이콘과 텍스트를 중앙 정렬
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                          child: Icon(
                            Icons.menu,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                          child: Text('목록'),
                        ),
                      ],
                    ),
                    label:
                        SizedBox.shrink(), // 라벨을 감추기 위해 SizedBox.shrink()를 사용합니다.
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
