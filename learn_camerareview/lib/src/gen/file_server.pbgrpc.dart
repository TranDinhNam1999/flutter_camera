///
//  Generated code. Do not modify.
//  source: file_server.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'file_server.pb.dart' as $0;
export 'file_server.pb.dart';

class FileServiceClient extends $grpc.Client {
  static final _$upload = $grpc.ClientMethod<$0.Chunk, $0.Reply>(
      '/FileService/upload',
      ($0.Chunk value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Reply.fromBuffer(value));
  static final _$download = $grpc.ClientMethod<$0.Request, $0.Chunk>(
      '/FileService/download',
      ($0.Request value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Chunk.fromBuffer(value));

  FileServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Reply> upload($async.Stream<$0.Chunk> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$upload, request, options: options).single;
  }

  $grpc.ResponseStream<$0.Chunk> download($0.Request request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$download, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class FileServiceBase extends $grpc.Service {
  $core.String get $name => 'FileService';

  FileServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Chunk, $0.Reply>(
        'upload',
        upload,
        true,
        false,
        ($core.List<$core.int> value) => $0.Chunk.fromBuffer(value),
        ($0.Reply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Request, $0.Chunk>(
        'download',
        download_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Request.fromBuffer(value),
        ($0.Chunk value) => value.writeToBuffer()));
  }

  $async.Stream<$0.Chunk> download_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Request> request) async* {
    yield* download(call, await request);
  }

  $async.Future<$0.Reply> upload(
      $grpc.ServiceCall call, $async.Stream<$0.Chunk> request);
  $async.Stream<$0.Chunk> download($grpc.ServiceCall call, $0.Request request);
}
