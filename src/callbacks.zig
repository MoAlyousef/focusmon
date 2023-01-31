const zfltk = @import("zfltk");
const app = zfltk.app;
const enums = zfltk.enums;
const widget = zfltk.widget;
const Widget = widget.Widget;
const dialog = zfltk.dialog;
const text = zfltk.text;

pub fn saveCb(w: Widget, data: ?*anyopaque) void {
    _ = w;
    const dlg = dialog.NativeFileDialog.new(.BrowseSaveFile);
    dlg.setFilter("*.{txt}");
    dlg.show();
    const fname = dlg.filename();
    if (fname != null) {
        const buf = text.TextBuffer.fromVoidPtr(data);
        _ = buf.saveFile(fname) catch unreachable;
    }
}

pub fn quitCb(w: Widget, data: ?*anyopaque) void {
    _ = w;
    const win = widget.Widget.fromVoidPtr(data);
    win.hide();
}

pub fn helpCb(w: Widget, data: ?*anyopaque) void {
    _ = w;
    _ = data;
    dialog.message(300, 200, "FocusMon was built using fltk and zig!\nYou can find the git repo here:\nhttps://github.com/MoAlyousef/focusmon");
}

pub fn winCb(w: Widget) void {
    if (app.event() == enums.Event.Close) {
        w.hide();
    }
}