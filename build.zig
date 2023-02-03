const std = @import("std");
const Sdk = @import("zfltk/sdk.zig");
const Builder = std.build.Builder;

pub fn build(b: *Builder) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();
    const sdk = Sdk.init(b);
    const exe = b.addExecutable("focusmon", "src/main.zig");
    exe.addPackagePath("zfltk", "zfltk/src/zfltk.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    try sdk.link("zfltk", exe);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
