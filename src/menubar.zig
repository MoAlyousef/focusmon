const cbs = @import("callbacks.zig");
const zfltk = @import("zfltk");
const menu = zfltk.menu;
const text = zfltk.text;
const window = zfltk.window;
const enums = zfltk.enums;

pub fn addMenuItems(m: *menu.MenuBar, buf: *text.TextBuffer, win: *window.Window) void {
    m.*.setTextSize(15);
    m.addEx(
        "&File/Save...\t",
        enums.Shortcut.Ctrl | 's',
        .menu_divider,
        cbs.saveCb,
        buf,
    );
    m.addEx(
        "&File/Quit...\t",
        enums.Shortcut.Ctrl | 'q',
        .normal,
        cbs.quitCb,
        win,
    );
    m.addEx(
        "&Help/About...\t",
        enums.Shortcut.Ctrl | 'q',
        .normal,
        cbs.helpCb,
        null,
    );
}