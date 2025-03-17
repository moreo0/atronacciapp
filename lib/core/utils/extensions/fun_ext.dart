String getSourceImage(String nameImage,
    {String path = 'assets/png/', String ext = 'png'}) {
  return '$path$nameImage.$ext';
}

String getSourceLogo(String nameImage,
    {String path = 'assets/icons/', String ext = 'png'}) {
  return '$path$nameImage.$ext';
}
