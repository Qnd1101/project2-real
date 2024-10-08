import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_hotel/api/hotel_api.dart';
import 'package:flutter_application_hotel/api/travel_api.dart';
import 'package:flutter_application_hotel/hotel_layout/hotel_ReservationCompleteDetail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_hotel/travel_layout/TravelInfo.dart';
import 'package:provider/provider.dart';

class ReservationComplete extends StatefulWidget {
  const ReservationComplete({super.key});

  @override
  _ReservationCompleteState createState() => _ReservationCompleteState();
}

class _ReservationCompleteState extends State<ReservationComplete> {
  List<Map<String, dynamic>> _userData = [];
  String? hotelID;

  bool isLoading = true;
  bool hasData = false;

  @override
  void initState() {
    super.initState();
    final userData = Provider.of<UserData>(context, listen: false);
    hotelID = userData.hotelID.toString();
    _fetchUserDataFromApi();
  }

  Future<void> _fetchUserDataFromApi() async {
    try {
      var response = await http.post(Uri.parse(HotelApi.resvSelect), body: {
        'travel_reservation_status': "2",
        'hotel_reservation_status': "2",
        'hotel_id': hotelID!,
      });

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['success'] == true) {
          List<dynamic>? userDataList = responseBody['resv_list'];

          setState(() {
            _userData = userDataList!.map((userData) {
              return {
                'reservation_id': userData['reservation_id'].toString(),
                'inquirer_name': userData['inquirer_name'],
                'check_out_date': userData['check_out_date'],
                "travel_reservation_status":
                    userData['travel_reservation_status'],
                "agency_id": userData['agency_id'],
                "room_count": userData['room_count'].toString(),
                "night_count": userData['night_count'].toString(),
                "hotel_id": userData['hotel_id'].toString(),
                "hotel_price": userData['hotel_price'].toString(),
                "guest_count": userData['guest_count'].toString(),
                "inquirer_tel": userData['inquirer_tel'],
                "check_in_date": userData['check_in_date'],
                "hotel_name": userData['hotel_name'],
              };
            }).toList();
            isLoading = false;
            hasData = _userData.isNotEmpty;
          });
        } else {
          throw "Failed to fetch user data";
        }
      } else {
        throw "Failed to load user data: ${response.statusCode}";
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  void viewDetail(Map<String, dynamic> userData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservationCompleteDetail(ReserverInfo: userData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '예약완료 리스트',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 2,
        shadowColor: Colors.black,
        backgroundColor: Colors.teal[200],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasData
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        '※ 예약내용을 보려면 "예약완료 됨"을 누르세요.',
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _userData.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> user = _userData[index];

                            return Card(
                              child: ListTile(
                                title: Text(
                                  user['inquirer_name'].toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Text(
                                  user['hotel_name'].toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        viewDetail(user);
                                      },
                                      child: const Text(
                                        '예약완료 됨',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Text(
                    '리스트가 비어있습니다.',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      color: Colors.red,
                      fontSize: 22,
                    ),
                  ),
                ),
    );
  }
}
