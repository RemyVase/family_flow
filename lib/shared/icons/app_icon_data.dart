/// In-house SVG icon set of the design direction (stroke 1.7–2.1px).
///
/// Ported from the design handoff (`HIcon` / `OB` objects). Icons are
/// monochrome and tinted at render time by [AppIcon].
library;

enum AppIconData {
  bell(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 9a6 6 0 1112 0c0 4.5 1.6 5.6 2 6H4c.4-.4 2-1.5 2-6"/><path d="M10.2 20a2 2 0 003.6 0"/></svg>',
  ),

  /// The points glyph: a filled hexagonal token — never a star.
  token(
    '<svg viewBox="0 0 24 24"><path d="M12 2.4 20 7v10l-8 4.6L4 17V7Z" fill="#000"/></svg>',
  ),
  check(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12.5l4.5 4.5L19 7"/></svg>',
  ),
  clock(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="8.4"/><path d="M12 7.6V12l2.8 1.8"/></svg>',
  ),
  repeat(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><path d="M4 9a5 5 0 015-5h6M4 9l2.5-2.5M4 9l2.5 2.5"/><path d="M20 15a5 5 0 01-5 5H9m11-5l-2.5 2.5M20 15l-2.5-2.5"/></svg>',
  ),
  sun(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>',
  ),
  cloud(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><path d="M7 18a4 4 0 01-.5-7.97A5.5 5.5 0 0117.5 11 3.5 3.5 0 0117 18z"/></svg>',
  ),
  moon(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><path d="M20 14.5A7.5 7.5 0 019.5 4a7.5 7.5 0 1010.5 10.5z"/></svg>',
  ),
  home(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><path d="M3.5 11L12 4l8.5 7"/><path d="M5.5 9.5V20h13V9.5"/></svg>',
  ),
  calendar(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><rect x="3.5" y="5" width="17" height="15" rx="3.5"/><path d="M3.5 9.5h17M8 3v3.5M16 3v3.5"/></svg>',
  ),
  chart(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><path d="M5 20V10M12 20V4M19 20v-7"/></svg>',
  ),
  plus(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.4" stroke-linecap="round"><path d="M12 5v14M5 12h14"/></svg>',
  ),
  gift(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="9" width="16" height="11" rx="2"/><path d="M4 13h16M12 9v11"/><path d="M12 9C9.5 9 8 5 12 5s2.5 4 0 4z"/></svg>',
  ),
  chevronLeft(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"><path d="M15 5l-7 7 7 7"/></svg>',
  ),
  chevronRight(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"><path d="M9 5l7 7-7 7"/></svg>',
  ),
  arrowUp(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.6" stroke-linecap="round" stroke-linejoin="round"><path d="M12 19V6M6 11l6-6 6 6"/></svg>',
  ),
  arrowRight(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14M13 6l6 6-6 6"/></svg>',
  ),
  pencil(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><path d="M16.5 4.5l3 3L8 19l-4 1 1-4z"/><path d="M14.5 6.5l3 3"/></svg>',
  ),
  sparkle(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l1.8 5.2L19 10l-5.2 1.8L12 17l-1.8-5.2L5 10l5.2-1.8z"/><path d="M18.5 15.5l.7 2 2 .7-2 .7-.7 2-.7-2-2-.7 2-.7z"/></svg>',
  ),
  camera(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><path d="M3.5 8.5h3L8 6.2h8l1.5 2.3h3v11h-17z"/><circle cx="12" cy="13.5" r="3.4"/></svg>',
  ),
  minus(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.6" stroke-linecap="round"><path d="M5 12h14"/></svg>',
  ),
  help(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="8.5"/><path d="M9.5 9.5a2.5 2.5 0 013.8-2c1.3.8 1 2.4-.3 3-.7.3-1 .8-1 1.6"/><circle cx="12" cy="16.5" r="1" fill="#000" stroke="none"/></svg>',
  ),
  share(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><path d="M12 15V4M8.5 7.5L12 4l3.5 3.5"/><path d="M6 12v7a1 1 0 001 1h10a1 1 0 001-1v-7"/></svg>',
  ),
  copy(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><rect x="8" y="8" width="12" height="12" rx="3"/><path d="M16 8V6a2 2 0 00-2-2H6a2 2 0 00-2 2v8a2 2 0 002 2h2"/></svg>',
  ),
  logout(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><path d="M15 5H6a1 1 0 00-1 1v12a1 1 0 001 1h9"/><path d="M18 12H10m8 0l-3-3m3 3l-3 3"/></svg>',
  ),
  user(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="3.6"/><path d="M5 19.5a7 7 0 0114 0"/></svg>',
  ),
  users(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="8" r="3.2"/><path d="M3.5 19a5.5 5.5 0 0111 0"/><path d="M16 5.2a3.2 3.2 0 010 5.6M20.5 19a5.5 5.5 0 00-4-5.3"/></svg>',
  ),
  key(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><circle cx="8" cy="8" r="4.5"/><path d="M11 11l8 8M16 16l2-2M19 19l2-2"/></svg>',
  ),
  heart(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20s-7-4.6-7-9.5A3.8 3.8 0 0112 7a3.8 3.8 0 017 3.5c0 4.9-7 9.5-7 9.5z"/></svg>',
  ),
  trash(
    '<svg viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2.1" stroke-linecap="round" stroke-linejoin="round"><path d="M4 7h16M10 7V5a1 1 0 011-1h2a1 1 0 011 1v2M6 7l1 13a1 1 0 001 1h8a1 1 0 001-1l1-13"/></svg>',
  );

  const AppIconData(this.svg);

  /// Raw SVG markup, drawn in black and tinted by the icon widget.
  final String svg;
}
