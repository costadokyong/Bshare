// ignore: file_names
class BookData {
  String bookImageUrl;
  String bookTitle;
  int bookPrice;
  String bookDescription;
  String bookMajor;
  String bookOwnerId;

  BookData(
      {required this.bookImageUrl,
      required this.bookTitle,
      required this.bookPrice,
      required this.bookDescription,
      required this.bookMajor,
      required this.bookOwnerId});

  factory BookData.fromRTDB(Map<String, dynamic> data) {
    return BookData(
        bookImageUrl: data['bookImageUrl'] ??
            'https://p.kindpng.com/picc/s/164-1646889_error-png-page-something-went-wrong-png-transparent.png',
        bookTitle: data['bookTitle'] ?? 'Unknown',
        bookPrice: data['bookPrice'] ?? 0,
        bookDescription: data['bookDescription'] ?? 'No description',
        bookMajor: data['bookMajor'] ?? 'Unknow',
        bookOwnerId: data['bookOwnerId'] ?? 'Unknow');
  }
}
