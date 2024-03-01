const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;
const math = std.math;

const numt = u64;
const List = std.ArrayList(numt);

pub fn main() !void {
    var input: [1024]u8 = undefined;
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var gp = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = gp.deinit();
    const allocator = gp.allocator();
    var nums = List.init(allocator);
    defer nums.deinit();

    var line = try stdin.readUntilDelimiterOrEof(&input, '\n');
    var split = mem.splitScalar(u8, line orelse "", ':');
    _ = split.next();
    var nsplit = mem.splitScalar(u8, split.next() orelse "", ' ');

    while (nsplit.next()) |elem| {
        if (elem.len == 0 or elem[0] == ' ') continue;
        try nums.append(try fmt.parseInt(numt, elem, 10));
    }

    line = try stdin.readUntilDelimiterOrEof(&input, '\n');
    split = mem.splitScalar(u8, line orelse "", ':');
    _ = split.next();
    nsplit = mem.splitScalar(u8, split.next() orelse "", ' ');

    var prod: numt = 1;
    var i: usize = 0;

    while (nsplit.next()) |elem| {
        if (elem.len == 0 or elem[0] == ' ') continue;
        var tmp = try fmt.parseInt(numt, elem, 10);
        prod *= tmp + nums.items[i];
        i += 1;
    }

    try stdout.print("{}\n", .{prod});
}
