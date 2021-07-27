import 'dart:io';
import 'dart:typed_data';

void main() async {
  // connect to the socket server
  final socket = await Socket.connect('localhost', 4567);
  print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

  // listen for responses from the server
  socket.listen(
    // handle data from the server
    (Uint8List data) {
      final serverResponse = String.fromCharCodes(data);
      print('Server: $serverResponse');
    },

    // handle errors
    onError: (error) {
      print(error);
      socket.destroy();
    },

    // handle server ending connection
    onDone: () {
      print('Server left.');
      socket.destroy();
    },
  );

  // send some messages to the server
  await sendMessage(socket, 'Knock, knock.');
  await sendMessage(socket, 'Request 1');
  await sendMessage(socket, 'Request 2');
  await sendMessage(socket, 'Request 3');
  await sendMessage(socket, 'Request 4');
  await sendMessage(socket, 'Request 5');
  await sendMessage(socket, 'Request 6');
  await sendMessage(socket, 'Request 7');
  socket.destroy();
}

Future<void> sendMessage(Socket socket, String message) async {
  print('Client: $message');
  socket.write(message);
  await Future.delayed(Duration(seconds: 2));
}
