const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const first = if (args.len > 1) args[1] else "420";
    const parsed = (std.fmt.parseUnsigned(u64, first, 10) catch 420) + 1;
    _ = parsed;
}
