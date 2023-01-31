const std = @import("std");
const text = @import("zfltk").text;
const c = @cImport({
    @cInclude("windows.h");
    @cInclude("time.h");
});

pub fn thread_func(data: ?*anyopaque) !void {
    if (data) |d| {
        const disp = @ptrCast(*text.TextDisplay, @alignCast(std.meta.alignment(*text.TextDisplay), d));
        const tbuf = disp.buffer();
        const sbuf = disp.styleBuffer();
        var last: [1024]u8 = undefined;
        while (true) {
            const hwnd = c.GetForegroundWindow();
            if (hwnd) |wnd| {
                var pid: c.DWORD = 0;
                _ = c.GetWindowThreadProcessId(wnd, &pid);
                const handle = c.OpenProcess(0x1000, 0, pid);
                if (handle) |h| {
                    var buffSize: c.DWORD = 1024;
                    var buffer: [1024]u8 = undefined;
                    if (c.QueryFullProcessImageNameA(h, 0, &buffer, &buffSize) != 0) {
                        if (!std.mem.eql(u8, last[0..buffSize], buffer[0..buffSize])) {
                            std.mem.copy(u8, &last, buffer[0..buffSize]);
                            var buf: [1024]u8 = undefined;
                            const t = c.time(null);
                            const lt = c.localtime(&t);
                            _ = c.strftime(&buf, 1024, "%H:%M:%S: ", lt);
                            tbuf.append(&buf);
                            sbuf.append("A" ** 10);
                            const temp = try std.fmt.bufPrintZ(buf[0..], "{s} (pid: {})", .{last[0..buffSize], pid});
                            tbuf.append(temp);
                            var i: usize = 1;
                            while (i <= temp.len) : (i += 1) {
                                sbuf.append("B");
                            }
                            tbuf.append("\n");
                            sbuf.append("A");
                        }
                    }
                }
            }
            std.time.sleep(30000000);
        } 
    } else {
        return;
    }
}