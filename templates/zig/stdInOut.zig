const std = @import("std");

pub fn main() !void {
    var input: [1024]u8 = undefined;
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    _ = try stdin.readUntilDelimiter(&input, '\n');

    try stdout.print("The user entered: {s}\n", .{input});
}
