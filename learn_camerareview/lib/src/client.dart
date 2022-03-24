import 'package:grpc/grpc.dart';
import 'gen/file_server.pbgrpc.dart';
import 'common.dart';

class Client {
  late FileServiceClient stub;

  Future<void> handlerUpload(filecrt, filename) async {
    final channel = ClientChannel(
      '0.0.0.0',
      port: 50051,
      options: ChannelOptions(
        credentials: ChannelCredentials.secure(
          //certificates: File(filecrt).readAsBytesSync(),
          certificates: filecrt,
          authority: 'nhatga',
        ),
        codecRegistry:
            CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
      ),
    );

    stub = FileServiceClient(channel,
        options: CallOptions(timeout: const Duration(seconds: 30)));

    await upload(filename);
  }

  Future<void> upload(filename) async {
    var chunksGenerator = get_file_chunks(filename);
    await stub.upload(chunksGenerator);
  }
}

// Future<void> main(List<String> args) async {
//   await Client().handlerUpload(
//       'D:\\Working\\demo_flutter_grpc\\app_demo\\assets\\credentials\\client-cert-v2.crt',
//       'C:\\Users\\namha\\Desktop\\739912.jpg');
// }
