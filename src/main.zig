const std = @import("std");
const zfltk = @import("zfltk");
const app = zfltk.app;
const widget = zfltk.widget;
const Widget = widget.Widget;
const window = zfltk.window;
const enums = zfltk.enums;
const text = zfltk.text;
const Group = zfltk.Group;
const menu = zfltk.menu;
const dialog = zfltk.dialog;

const menubar = @import("menubar.zig");
const cbs = @import("callbacks.zig");
const worker = @import("worker.zig");
const styles = @import("styles.zig");

pub fn main() !void {
    try app.init();
    styles.styleApp();
    var buf = try text.TextBuffer.init();
    var win = try window.Window.init(.{.x=100, .y=100, .w = 800, .h = 600, .label = "FocusMon"});
    var flex = try Group(.flex).init(.{.x = 2, .y = 2, .w = 796, .h = 596, .spacing = 5});
    flex.setMargin(2);
    var mb = try menu.Menu(.menu_bar).init(.{});
    flex.fixed(mb, 25);
    mb.setBox(.flat);
    menubar.addMenuItems(mb, buf, win);
    var display = try text.TextDisplay(.normal).init(.{});
    display.setBuffer(buf);
    styles.styleDisplay(display);
    flex.end();
    win.end();
    win.resizable(win);
    win.show();
    win.setCallback(cbs.winCb);

    const thread = std.Thread.spawn(.{}, worker.threadFunc, .{display.raw()}) catch {
        return;
    };
    thread.detach();

    try app.run();
}
