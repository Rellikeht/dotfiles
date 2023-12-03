const std = @import("std");

pub fn main() !void {
    var input: [1024]u8 = undefined;
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    while (try stdin.readUntilDelimiterOrEof(&input, '\n')) |line| {
        try stdout.print("line: {s}\n", .{line});
    }

    //  _ = try stdin.readUntilDelimiter(&input, '\n');
    try stdout.print("The user entered: \"{s}\"\n", .{input});
}
