# Accessibility [S12][S29a][S29b]

Accessibility is part of the definition of done.

- **Screen readers** (VoiceOver/TalkBack): every interactive element has a label. Decorative images are hidden from them. Group related elements. Focus order is logical.
- **Touch targets**: at least 44×44pt (iOS) and 48×48dp (Android), even if the visual element is smaller.
- **Dynamic type / font scale**: layouts survive 200% and larger. No fixed-height text containers. Allow wrapping.
- **Contrast**: at least 4.5:1 for body text, 3:1 for large text and UI components. Check dark mode too.
- **Don't rely on color alone**: pair color with an icon or text for errors and status.
- **Motion**: respect Reduce Motion. No auto-playing essential animations.
- **Custom controls**: expose role, state and value (toggle on/off, slider value).
- **Test**: navigate the key flow with only VoiceOver/TalkBack and at max font size. Use Accessibility Inspector and Accessibility Scanner.
