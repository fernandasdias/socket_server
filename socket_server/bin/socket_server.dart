import 'dart:io';
import 'dart:typed_data';

import 'fake.dart';

void main() async {
  // bind the socket server to an address and port
  final port = int.parse(Platform.environment['PORT'] ?? '4567');
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, port);

  // listen for clent connections to the server
  server.listen((client) {
    handleConnection(client);
  });
}

void handleConnection(Socket client) {
  print('Connection from'
      ' ${client.remoteAddress.address}:${client.remotePort}');

  client.listen(
    (Uint8List data) async {
      await Future.delayed(Duration(seconds: 1));
      // final message = String.fromCharCodes(data);

      client.write(fakeResponse);
      // await client.close();
    },

    // handle errors
    onError: (error) {
      print(error);
      client.close();
    },

    // handle the client closing the connection
    onDone: () {
      print('Client left');
      client.close();
    },
  );
}
