import re
with open(r'C:\Users\LNWCPU\StudioProjects\motion_kit\lib\games\WanderPlaying.dart', 'r', encoding='utf-8') as f:
    text = f.read()
text = text.replace('\', '').replace('\', '')
text = text.replace('final List<Map<String, dynamic>> detectedHands;', 'final List<DetectedHand> detectedHands;')
text = text.replace('if (hand[\'landmarks\'] != null && (hand[\'landmarks\'] as List).length > 8)', 'if (hand.landmarks.length > 8)')
text = text.replace('var indexTip = hand[\'landmarks\'][8];', 'var indexTip = hand.landmarks[8];')
text = text.replace('double ix = indexTip[\'x\'] * (inputImage.metadata?.size.width ?? 480);', 'double ix = indexTip.x;')
text = text.replace('double iy = indexTip[\'y\'] * (inputImage.metadata?.size.height ?? 640);', 'double iy = indexTip.y;')
text = text.replace('if (_isPaused  _isResumeCountdown)', 'if (_isPaused || _isResumeCountdown)')
with open(r'C:\Users\LNWCPU\StudioProjects\motion_kit\lib\games\WanderPlaying.dart', 'w', encoding='utf-8') as f:
    f.write(text)

