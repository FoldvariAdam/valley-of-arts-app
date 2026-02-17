import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/models/models.dart';

part 'valley_api_client.g.dart';

@RestApi(baseUrl: "https://backend.muveszetekvolgye.hu/api/v1")
abstract class ValleyApiClient {
  factory ValleyApiClient(Dio dio, {String baseUrl}) = _ValleyApiClient;

  @GET("/dates")
  Future<ScheduleResponse> getAvailableDates();

  @GET("/programs")
  Future<PaginatedProgramsResponse> getPrograms({
    @Query("program_category_id[]") List<int>? categoryIds,
    @Query("date") String? date,
    @Query("location_id") int? locationId,
    @Query("time") String? time,
    @Query("only_pinned") bool? onlyPinned,
    @Query("page") int? page,
    @Query("per_page") int? perPage,
  });

  @GET("/locations")
  Future<List<LocationResponse>> getLocations();

  @GET("/map")
  Future<MapResponse> getMap();
}
