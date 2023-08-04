const zfltk = @import("zfltk");
const app = zfltk.app;
const enums = zfltk.enums;
const Widget = zfltk.widget.Widget;
const menu = zfltk.menu;
const dialog = zfltk.dialog;
const text = zfltk.text;
const window = zfltk.window;
const std = @import("std");

pub fn saveCb(w: *menu.MenuBar, data: ?*anyopaque) void {
    _ = w;
    var dlg = try dialog.FileDialog(.save_file).init(.{
        .save_as_confirm = true,
        .new_folder = true,
    });
    dlg.setType(.save_file);
    dlg.setFilter("*.{txt}");
    dlg.show();
    const fname = dlg.filename();
    if (!std.mem.eql(u8, fname, "")) {
        var buf: *text.TextBuffer = @ptrCast(data.?);
        buf.saveFile(fname) catch unreachable;
    }
}

pub fn quitCb(w: *menu.MenuBar, data: ?*anyopaque) void {
    _ = w;
    const win = Widget.fromRaw(data.?);
    win.hide();
}

pub fn helpCb(w: *menu.MenuBar, data: ?*anyopaque) void {
    _ = w;
    _ = data;
    dialog.message(300, 200, "FocusMon was built using fltk and zig!\nYou can find the git repo here:\nhttps://github.com/MoAlyousef/focusmon");
}

pub fn winCb(w: *window.Window) void {
    if (app.event() == enums.Event.close) {
        w.hide();
    }
}