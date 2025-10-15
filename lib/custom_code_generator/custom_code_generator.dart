import 'dart:convert';
import 'dart:io';
import 'package:build/build.dart';
import 'package:languagetool/A.dart';



// flutter pub run build_runner clean
// flutter pub run build_runner build
//excel转数组： https://tableconvert.com/zh-cn/excel-to-json#google_vignette


// 自定义代码生成器
class CustomCodeGenerator extends Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
        'A.dart': ['.dart'], // 输入文件是 .dart，输出文件是 .generated.dart
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final assetId = buildStep.inputId; // 获取当前文件的 AssetId
    final filePath = assetId.path;

    // 从源文件读取并处理字符串内容
    // final content = await _processFileContent(filePath);

    List<String> languageStrs = [
      '简体中文',
      'English',
      '繁体中文',
      '西班牙语（Español）',
      '葡萄牙语（Português）',
      '法语（Français）',
      '越南语（Tiếng Việt）',
      '意大利语（Italiano）',
      '俄语（Русский）',
      '德语（Deutsch）',
      '泰语（ภาษาไทย）',
      '印度尼西亚语（Bahasa Indonesia）',
      '马来语（Bahasa Melayu）',
    ];

    List<String> languageFileNames = [
      'zh_CN',
      'en',
      'zh_TW',
      'Spanish',
      'Portug',
      'France',
      'Vietnam',
      'Italy',
      'Russian',
      'Deutsch',
      'Thai',
      'Indonesian',
      'Melayu',
    ];

    for (int i = 0; i < languageStrs.length; i++) {
      final languageStr = languageStrs[i];
      Map<String, dynamic> languageMap = {};

      for (var i = 0; i < originalList.length; i++) {
        String keyStr = originalList[i]['简体中文'] ?? "";
        languageMap[keyStr] = originalList[i][languageStr] ?? "";
      }

      // 确定生成文件的路径（将文件扩展名改为 _generated.dart）
      final outputFilePath =
          'lib/generated/${languageFileNames[i]}.dart';
      final outputFile = File(outputFilePath);
      // 将处理后的字符串写入到新的文件中
      await outputFile.writeAsString('Map<String, dynamic>' +
          languageFileNames[i] +
          '=' +
          jsonEncode(languageMap) +
          ';');
    }
  }

  // 处理文件内容，可以根据需要进行任何自定义处理
  Future<String> _processFileContent(String filePath) async {
    final file = File(filePath);
    final content = await file.readAsString();

    // 简单的处理：将文件内容转换为大写
    // 你可以根据实际需求修改这里的处理逻辑
    final processedContent = content.toUpperCase(); // 例如转为大写

    return processedContent;
  }
}

// builder factory
Builder customCodeBuilder(BuilderOptions options) => CustomCodeGenerator();
