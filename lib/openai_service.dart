import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:buddyai/secrets.dart';

class OpenAIService {
  final List<Map<String, String>> messages = [];
  Future<String> isArtPromoptAPI(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIkey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content":
                  "Does this message want to generate an AI picture, image, art or something similar? $prompt .Simply answer with yes or no",
            }
          ],
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        String content =
            jsonDecode(response.body)['choices'][0]['message']['content'];
        content = content.trim();
        switch (content) {
          case 'yes':
          case 'Yes':
          case 'yes.':
          case 'Yes.':
            final response = await dallEAPI(prompt);
            return response;
          default:
            final response = await ChatGPTAPI(prompt);
            return response;
        }
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> ChatGPTAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIkey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      if (response.statusCode == 200) {
        String content =
            jsonDecode(response.body)['choices'][0]['message']['content'];
        content = content.trim();
        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIkey',
        },
        body: jsonEncode({
          'prompt': prompt,
          'n': 1,
        }),
      );

      if (response.statusCode == 200) {
        String imageUrl = jsonDecode(response.body)['data'][0]['url'];
        imageUrl = imageUrl.trim();
        messages.add({
          'role': 'assistant',
          'content': imageUrl,
        });
        return imageUrl;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}
