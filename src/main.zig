const std = @import("std");
const zfltk = @import("zfltk");
const app = zfltk.app;
const widget = zfltk.widget;
const Widget = widget.Widget;
const window = zfltk.window;
const enums = zfltk.enums;
const text = zfltk.text;
const group = zfltk.group;
const menu = zfltk.menu;
const dialog = zfltk.dialog;

const menubar = @import("menubar.zig");
const cbs = @import("callbacks.zig");
const worker = @import("worker.zig");
const styles = @import("styles.zig");

pub fn main() !void {
    try app.init();
    styles.style_app();
    var buf = text.TextBuffer.new();
    var win = window.Window.new(100, 100, 800, 600, "FocusMon");
    const flex = group.Flex.new(2, 2, 796, 596, null);
    flex.setPad(5);
    flex.setMargin(2);
    var mb = menu.MenuBar.new(0,0,0,0, null);
    flex.fixed(&mb.asWidget(), 25);
    mb.asWidget().setBox(.FlatBox);
    menubar.add_menu_items(&mb, &buf, &win);
    var display = text.TextDisplay.new(0, 0, 0, 0, null);
    display.setBuffer(&buf);
    styles.style_display(&display);
    flex.end();
    win.asGroup().end();
    win.asGroup().resizable(&win.asWidget());
    win.asWidget().show();
    win.asWidget().setCallback(cbs.winCb);

    const thread = std.Thread.spawn(.{}, worker.thread_func, .{&display}) catch {
        return;
    };
    thread.detach();

    try app.run();
}
