const zfltk = @import("zfltk");
const app = zfltk.app;
const text = zfltk.text;
const enums = zfltk.enums;

pub fn styleApp() void {
    app.setScheme(.Oxy);
    app.background(0x1d, 0x1f, 0x23);
    app.background2(0x28, 0x2c, 0x34);
    app.foreground(255, 255, 255);
    app.setColor(enums.Color.Selection, enums.Color.fromHex(0xFFA500));
    app.setFontSize(14);
    app.setMenuLinespacing(8);
}

pub fn styleDisplay(display: *text.TextDisplay) void {
    const entries = [_]text.StyleTableEntry{
        text.StyleTableEntry {
            .color = enums.Color.fromHex(0x58afef),
            .font = enums.Font.Helvetica,
            .size = 16,
        },
        text.StyleTableEntry {
            .color = enums.Color.fromHex(0xe06253),
            .font = enums.Font.Helvetica,
            .size = 16,
        },
    };
    var sbuf = text.TextBuffer.new();
    display.setHighlightData(&sbuf, &entries);
}
