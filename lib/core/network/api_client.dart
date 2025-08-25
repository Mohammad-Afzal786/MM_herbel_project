import 'package:dio/dio.dart';
import 'package:mmherbel/modules/auth/data/models/login_request.dart';
import 'package:mmherbel/modules/auth/data/models/login_response.dart';
import 'package:retrofit/retrofit.dart';


part 'api_client.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:3000/api/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/login")
   @Extra({"requiresToken": false})
  Future<LoginResponse> login(@Body() LoginRequest request);
}
