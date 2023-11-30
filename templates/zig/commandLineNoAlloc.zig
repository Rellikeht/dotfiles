const std = @import("std");

pub fn main() !void {
    // amount:
    // std.os.argv.len

    for(std.os.argv) |arg| {
        std.debug.print("{s}\n", .{arg});
    }
}
