import 'package:equatable/equatable.dart';

class RefreshRequest extends Equatable{
  const RefreshRequest({
    required this.refreshToken
  });

  final String refreshToken;

  Map<String, dynamic> toJson()
  {
    return {
      'refreshToken': refreshToken,
    };
  }

  @override
  List<Object?> get props => [refreshToken];
}