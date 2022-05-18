import 'dart:io';

class BookData {
  File bookImageUrl;
  String bookTitle;
  int bookPrice;
  String bookDescription;

  BookData(
      this.bookImageUrl, this.bookTitle, this.bookPrice, this.bookDescription);
}
