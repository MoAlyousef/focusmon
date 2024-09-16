const std = @import("std");
const Sdk = @import("zfltk");
const Build = std.Build;

pub fn build(b: *Build) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardOptimizeOption(.{});
    const exe = b.addExecutable(.{
        .name = "focusmon",
        .root_source_file = b.path("src/main.zig"),
        .optimize = mode,
        .target = target,
    });

    const sdk = try Sdk.init(b);
    const zfltk_module = sdk.getZfltkModule(b);
    exe.root_module.addImport("zfltk", zfltk_module);
    try sdk.link(exe);

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}