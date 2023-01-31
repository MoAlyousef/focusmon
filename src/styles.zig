const zfltk = @import("zfltk");
const app = zfltk.app;
const text = zfltk.text;
const enums = zfltk.enums;

pub fn style_app() void {
    app.setScheme(.Oxy);
    app.background(0x1d, 0x1f, 0x23);
    app.background2(0x28, 0x2c, 0x34);
    app.foreground(0x7f, 0xa5, 0xb4);
    app.setColor(15, enums.Color.fromHex(0x2c313c));
    app.setFontSize(14);
    app.setMenuLinespacing(8);
}

pub fn style_display(display: *text.TextDisplay) void {
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