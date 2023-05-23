import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_clone/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = Future<Either<Failure, void>>;