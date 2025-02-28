import 'package:suitmedia_competency_test/core/usecases/usecase.dart';

class CheckPalindromeUseCase extends UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    if (params == null || params.isEmpty) {
      return false;
    }

    final cleanText = params.toLowerCase().replaceAll(' ', '');
    final reversedText = cleanText.split('').reversed.join('');

    return cleanText == reversedText;
  }
}
