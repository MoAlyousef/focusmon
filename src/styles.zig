const zfltk = @import("zfltk");
const app = zfltk.app;
const text = zfltk.text;
const enums = zfltk.enums;

pub fn styleApp() void {
    app.setScheme(.oxy);
    app.setBackground(enums.Color.fromRgb(0x1d, 0x1f, 0x23));
    app.setBackground2(enums.Color.fromRgb(0x28, 0x2c, 0x34));
    app.setForeground(enums.Color.fromRgb(255, 255, 255));
    app.setColorAny(15, enums.Color.fromHex(0xFFA500));
    app.setFontSize(14);
    app.setMenuLinespacing(8);
}

pub fn styleDisplay(display: *text.TextDisplay) void {
    const entries = [_]text.StyleTableEntry{
        text.StyleTableEntry {
            .color = enums.Color.fromHex(0x58afef),
            .font = .helvetica,
            .size = 16,
        },
        text.StyleTableEntry {
            .color = enums.Color.fromHex(0xe06253),
            .font = .helvetica,
            .size = 16,
        },
    };
    const sbuf = try text.TextBuffer.init();
    display.setHighlightData(sbuf, &entries);
}
