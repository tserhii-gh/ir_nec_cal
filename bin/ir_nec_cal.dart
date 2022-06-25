import 'package:ir_nec_cal/ir_nec_cal.dart' as ir_nec_cal;

var hdrMark = 9000;
var hdrSpace = 4500;
var oneMark = 1687;
var zeroMark = 562;
var space = 562;
var repeatTime = 110000;
var spaceTime = 2250;
var command = 59;
var addr = 77;
var rCommand = ~command;
var rAddr = ~addr;
var message = <int>[];

void main() {
  print(
      'addr -> ${addr.toRadixString(16).padLeft(2, '0')}${rAddr.toUnsigned(8).toRadixString(16).padLeft(2, '0')}');
  // print(decodeInt(command));
  // print(decodeInt(~command));
  print(
      'command -> ${command.toRadixString(16).padLeft(2, '0')}${rCommand.toUnsigned(8).toRadixString(16).padLeft(2, '0')}');
  // print(decodeInt(addr));
  // print(decodeInt(~addr));
  message.add(hdrMark);
  message.add(hdrSpace);
  message.addAll(decodeInt(addr));
  message.addAll(decodeInt(~addr));
  message.addAll(decodeInt(command));
  message.addAll(decodeInt(~command));
  message.add(space);

  var messageTime = 0;
  for (int a = 0; a < message.length; ++a) {
    messageTime += message.elementAt(a).toInt();
  }
  // print('RpT = ${repeatTime - messageTime}');
  message.add(repeatTime - messageTime);

  // print(decodeInt(addr));
  // print(decodeInt(~addr));
  // print(decodeInt(command));
  // print(decodeInt(~command));
  print(message);
  generate();
//   final list = <int>[];

//   for (int i = 7; i >= 0; i--){
//     list.add(space);
//     list.add(((command & (1 << i)) == 0)?zero_mark:one_mark);
//   }
//   print(list);

//   for (int i = 0; i < 5; i++) {
//     print('hello ${i + 1}');
//   }
}

List<int> decodeInt(int num, {int bits = 8}) {
  final list = <int>[];
  for (int i = 7; i >= 0; i--) {
    list.add(space);
    list.add(((num & (1 << i)) == 0) ? zeroMark : oneMark);
  }
  return list;
}

List<String> generate() {
  final list = <String>[];
  for (int i = 0; i <= 254; i++) {
    var iConv = ~i;
    list.add(
        "\x1B[31m${i.toRadixString(16).padLeft(2, '0')}\x1B[0m${iConv.toUnsigned(8).toRadixString(16).padLeft(2, '0')}");
  }
  print(list[59]);
  return list;
}
