import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import "../providers/board_provider.dart";
import 'providers/prefer_provider.dart';

final ImagePicker picker = ImagePicker();
// List<XFile?> multiImage = []; // 갤러리에서 여러 장의 사진을 선택해서 저장할 변수
//List<XFile?> showImage = []; // 가져온 사진들을 보여주기 위한 변수
XFile? selectImage;
XFile? showImage;

class WriteNewBoard extends StatefulWidget {
  const WriteNewBoard({super.key});

  @override
  State<WriteNewBoard> createState() => _WriteNewBoardState();
}

class _WriteNewBoardState extends State<WriteNewBoard> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _reviewController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xFFA8ABFF),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 5)
                        ],
                      ),
                      child: IconButton(
                          onPressed: () async {
                            selectImage = await picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            setState(() {
                              //갤러리에서 가지고 온 사진들은 리스트 변수에 저장되므로 addAll()을 사용해서 images와 multiImage 리스트를 합쳐줍니다.
                              //showImage.addAll(multiImage);
                              if (selectImage != null) {
                                // 사진을 선택한 경우에만 출력할 사진 갱신. 아니면 사진을 선택하지 않고 선택창을 닫으면 이미 선택된 사진 사라짐
                                showImage = selectImage;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 30,
                            color: Colors.white,
                          ))),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: showImage == null ? 0 : 1,
                  //보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
                  itemBuilder: (BuildContext context, int index) {
                    // 사진 오른 쪽 위 삭제 버튼을 표시하기 위해 Stack을 사용함
                    return Stack(
                      //alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: 200,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  fit: BoxFit.cover, //사진을 크기를 상자 크기에 맞게 조절
                                  image: FileImage(File(showImage!
                                          .path // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                                      )))),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            //삭제 버튼
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: Icon(Icons.close,
                                  color: Colors.white, size: 15),
                              onPressed: () {
                                //버튼을 누르면 해당 이미지가 삭제됨
                                setState(() {
                                  //showImage.remove(showImage[index]);
                                  showImage = null;
                                });
                              },
                            ))
                      ],
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1)),
                child: TextFormField(
                  controller: _reviewController, // 컨트롤러 할당
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: '리뷰를 입력해주세요'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '리뷰를 입력해주세요';
                    }
                    return null;
                  },
                ),
              ),
              // FutureBuilder(
              //     future: preferProvider.fetchPreferById(1),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         Map<dynamic, dynamic> prefer = snapshot.data!;
              //         return Container(
              //           margin: EdgeInsets.all(10),
              //           decoration: BoxDecoration(
              //               border:
              //                   Border.all(color: Colors.black, width: 0.5)),
              //           child: DropdownButtonFormField(
              //             decoration: const InputDecoration(
              //               border: OutlineInputBorder(),
              //               hintText: '누구의 사진인가요?',
              //             ),
              //             //value: studentResult.additionalPoint,
              //             items: List.generate(2, (i) {
              //               if (i == 0) {
              //                 return DropdownMenuItem(
              //                     value: i, child: const Text('강아지를 선택해주세요'));
              //               }
              //               return DropdownMenuItem(
              //                   value: i, child: Text(prefer['name']));
              //             }),
              //             onChanged: (value) {
              //               setState(() {
              //                 //studentResult.additionalPoint = value!;
              //               });
              //             },
              //             validator: (value) {
              //               if (value == 0) {
              //                 return '강아지를 선택해주세요';
              //               }
              //               return null;
              //             },
              //           ),
              //         );
              //       } else {
              //         return LinearProgressIndicator();
              //       }
              //     }),
              Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('착용 제품 선택'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFA8ABFF)),
                  )),
              Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      boardProvider.createBoard(
                          showImage, 2, 2, 2, _reviewController.text);
                      Navigator.pop(context); // 현재 페이지 닫기
                    },
                    child: Text('업로드'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  )),
            ],
          ),
        ));
  }
}