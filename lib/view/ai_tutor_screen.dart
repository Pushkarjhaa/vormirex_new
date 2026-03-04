import 'package:flutter/material.dart';
import 'package:vormirex_new/utils/app_colour.dart';


class AITutorScreen extends StatefulWidget {
  const AITutorScreen({super.key});

  @override
  State<AITutorScreen> createState() => _AITutorScreenState();
}

class _AITutorScreenState extends State<AITutorScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  final List<_ChatMessage> _messages = [
    _ChatMessage(
        isAI: true,
        text:
            "Hi! I'm your AI tutor. I'm here to help you learn anything - from homework help to mastering new skills. What would you like to explore today?"),
    _ChatMessage(isAI: false, text: "Can you help me understand my homework?"),
    _ChatMessage(
        isAI: true,
        text:
            "I'd be happy to help with your homework! Please share the problem or topic you're working on, and I'll break it down step by step for you."),
  ];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(isAI: false, text: text));
    });
    _messageController.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Header
          Container(
            margin: const EdgeInsets.all(16),
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(children: [
              Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0D3330),
                ),
                child: Icon(Icons.smart_toy_outlined,
                    color: AppColors.accentCyan, size: 24),
              ),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('AI Tutor',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
                Row(children: [
                  Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle)),
                  const SizedBox(width: 5),
                  const Text('online',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  Text(' · Ready to help',
                      style:
                          TextStyle(color: Colors.white38, fontSize: 12)),
                ]),
              ]),
            ]),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _messages.length,
              itemBuilder: (_, i) =>
                  _ChatBubble(message: _messages[i]),
            ),
          ),

          // Quick prompts
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _QuickPrompt(label: '✦  Explain my homework'),
                _QuickPrompt(label: '<>  Teach me Python'),
                _QuickPrompt(label: '📖  Create a quiz'),
                _QuickPrompt(label: '🧠  Study tips'),
              ],
            ),
          ),

          // Input bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(children: [
              const Icon(Icons.attach_file,
                  color: Colors.white38, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: 'Ask me anything...',
                      hintStyle: TextStyle(
                          color: Colors.white30, fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.mic_outlined,
                  color: Colors.white38, size: 22),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _sendMessage,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.accentCyan,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.send_rounded,
                      color: Colors.black, size: 20),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final bool isAI;
  final String text;
  const _ChatMessage({required this.isAI, required this.text});
}

class _ChatBubble extends StatelessWidget {
  final _ChatMessage message;
  const _ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isAI
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          if (message.isAI) ...[
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0D3330)),
              child: Icon(Icons.smart_toy_outlined,
                  color: AppColors.accentCyan, size: 18),
            ),
            const SizedBox(width: 10),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: message.isAI
                    ? const Color(0xFF0D3330)
                    : AppColors.cardBg,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(message.isAI ? 4 : 16),
                  topRight: Radius.circular(message.isAI ? 16 : 4),
                  bottomLeft: const Radius.circular(16),
                  bottomRight: const Radius.circular(16),
                ),
                border: message.isAI
                    ? Border.all(
                        color: AppColors.accentCyan.withOpacity(0.3))
                    : null,
              ),
              child: Text(
                message.text,
                style: const TextStyle(
                    color: Colors.white, fontSize: 14, height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickPrompt extends StatelessWidget {
  final String label;
  const _QuickPrompt({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white60, fontSize: 12)),
    );
  }
}
