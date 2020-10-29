import 'Model.dart';
import 'package:dio/dio.dart';
import 'Database.dart';

class MakeCall {
  List<Tag> listItems = [];
  List<Tag> filteredItems = [];

  Future<List<Tag>> getCall(String search) async {
    if (search != null && search.length != 0) {
      print(search);
      // searching based on meta and desc
      filteredItems = listItems
          .where((element) =>
              element.description
                  .toLowerCase()
                  .trim()
                  .contains(search.toLowerCase().trim()) ||
              element.meta
                  .toLowerCase()
                  .trim()
                  .contains(search.toLowerCase().trim()))
          .toList();
      print(listItems);
      return filteredItems;
    } else {
      if (listItems != null && listItems.length != 0) {
        return listItems;
      } else {
        Dio dio = new Dio();
        Response<String> response =
            await dio.get("https://sigmatenant.com/mobile/tags");
        String body = response.data.toString();
        Welcome welcome = welcomeFromJson(body);

        listItems = welcome.tags;

        DBProvider.db.insertAllTags(listItems);
        return listItems;
      }
    }
  }
}
