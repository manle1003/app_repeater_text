// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse(
      data: json['data'],
      messages: json['messages'] as List<dynamic>,
      status: json['status'] as bool,
    );

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'messages': instance.messages,
      'status': instance.status,
    };
