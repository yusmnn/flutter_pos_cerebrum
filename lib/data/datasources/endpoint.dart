class Endpoint {
  static const baseUrl = 'https://api.bmkg.go.id/publik/';
  static const prakiraanCuaca = '$baseUrl/prakiraan-cuaca?';
  static const wilayah = '${prakiraanCuaca}adm4=';
  static const bandung = '32.04.05.2001';
}

// https://api.bmkg.go.id/publik/prakiraan-cuaca?adm4=32.04.05.2001 // bandung
