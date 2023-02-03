const cbs = @import("callbacks.zig");
const zfltk = @import("zfltk");
const menu = zfltk.menu;
const text = zfltk.text;
const window = zfltk.window;
const enums = zfltk.enums;

pub fn addMenuItems(m: *menu.MenuBar, buf: *text.TextBuffer, win: *window.Window) void {
    m.*.asMenu().setTextSize(15);
    m.asMenu().addEx(
        "&File/Save...\t",
        enums.Shortcut.Ctrl | 's',
        .MenuDivider,
        cbs.saveCb,
        buf.toVoidPtr(),
    );
    m.asMenu().addEx(
        "&File/Quit...\t",
        enums.Shortcut.Ctrl | 'q',
        .Normal,
        cbs.quitCb,
        win.toVoidPtr(),
    );
    m.asMenu().addEx(
        "&Help/About...\t",
        enums.Shortcut.Ctrl | 'q',
        .Normal,
        cbs.helpCb,
        null,
    );
}