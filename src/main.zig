const std = @import("std");
const zfltk = @import("zfltk");
const app = zfltk.app;
const Widget = zfltk.widget.Widget;
const window = zfltk.window;
const enums = zfltk.enums;
const text = zfltk.text;
const Flex = zfltk.group.Flex;
const menu = zfltk.menu;
const dialog = zfltk.dialog;

const menubar = @import("menubar.zig");
const cbs = @import("callbacks.zig");
const worker = @import("worker.zig");
const styles = @import("styles.zig");

pub fn main() !void {
    try app.init();
    styles.styleApp();
    const buf = try text.TextBuffer.init();
    var win = try window.Window.init(.{.x=100, .y=100, .w = 800, .h = 600, .label = "FocusMon"});
    var flex = try Flex.init(.{.x = 2, .y = 2, .w = 796, .h = 596, .spacing = 5});
    flex.setMargin(2);
    var mb = try menu.MenuBar.init(.{});
    flex.fixed(mb, 25);
    mb.setBox(.flat);
    menubar.addMenuItems(mb, buf, win);
    var display = try text.TextDisplay.init(.{});
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
