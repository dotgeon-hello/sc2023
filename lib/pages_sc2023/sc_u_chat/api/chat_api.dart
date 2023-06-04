import '/pages_sc2023/sc_u_chat/models/chat_message.dart';
/*import '/pages_sc2023/sc_u_chat/secrets.dart';*/
import 'package:dart_openai/openai.dart';

class ChatApi {
  static String chatType = "chat";
  static String chatModel = "gpt-3.5-turbo";

  ChatApi(String openAiApiKey, String? openAiChatType, String? openAiChatModel) {
    OpenAI.apiKey = openAiApiKey;

    chatType = openAiChatType ?? chatType;
    chatModel = openAiChatModel ?? chatModel;
  }

  Future<String> completeChat(List<ChatMessage> chatDataInput, List<String>lectureDataInput) async {
    final _model = chatModel;

    final chatData = chatDataInput
          .map((e) => OpenAIChatCompletionChoiceMessageModel(
                role: (e.isUserMessage) ? OpenAIChatMessageRole.user : OpenAIChatMessageRole.assistant,
                content: e.content,
              ))
          .toList();

    final lectureData = lectureDataInput
          .map((e) => OpenAIChatCompletionChoiceMessageModel(
                role: OpenAIChatMessageRole.system,
                content: e,
              ))
          .toList();

    final configPromptData = [
      OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.system,
        content: 'You are a chatbot assisting a student with their studies. The student is asking you questions about a lecture they just watched. Except this message, all the system messages include the lecture transcript. Your answer should be relevant to the question asked and the lecture content.'
      ),
    ];
    final messages = [...configPromptData, ...lectureData, ...chatData];

    if (chatType == "chat") {
      final chatCompletion = await OpenAI.instance.chat.create(
        model: _model,
        messages: messages,
      );
      return chatCompletion.choices.first.message.content;
    }
    else if (chatType == "completion") {
      // chat completion based on text-davinci-003
      String prompt = "Provide the best response to the following chat message as the Assistant. Your response should be relevant to the question asked and the lecture content.\n\n";
      // merge message to prompt
      for (var i = 0; i < messages.length; i++) {
        // check the role first
        if (messages[i].role == OpenAIChatMessageRole.system) {
          prompt += "System: " + messages[i].content + "\n";
        } else if (messages[i].role == OpenAIChatMessageRole.user) {
          prompt += "User: " + messages[i].content + "\n";
        } else {
          prompt += "Assistant: " + messages[i].content + "\n";
        }
      }
      final textCompletion = await OpenAI.instance.completion.create(
        model: _model,
        prompt: prompt,
        temperature: 0.5,
        n: 1,
        echo: false,
      );
      return textCompletion.choices.first.text;
    }
    else {
      return "Invalid chat type";
    }
  }
}
