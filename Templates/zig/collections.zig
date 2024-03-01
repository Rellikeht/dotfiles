const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;

const numt = i32;
const List = std.ArrayList(numt);
const Set = std.AutoHashMap(numt, void);

pub fn main() !void {
    var input: [1024]u8 = undefined;
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var gp = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = gp.deinit();
    const allocator = gp.allocator();

    var set = Set.init(allocator);
    defer set.deinit();
    var list = List.init(allocator);
    defer list.deinit();

    var sum: numt = 0;

    while (try stdin.readUntilDelimiterOrEof(&input, '\n')) |line| {
        var split = mem.splitScalar(u8, line, '|');

        list.clearRetainingCapacity();
        set.clearRetainingCapacity();

        var nsplit = mem.splitScalar(u8, split.next() orelse "", ' ');
        while (nsplit.next()) |elem| {
            if (elem.len == 0) continue;
            // try stdout.print("\"{s}\"\n", .{elem});
            try set.put(try fmt.parseInt(numt, elem, 10), {});
        }

        nsplit = mem.splitScalar(u8, split.next() orelse "", ' ');
        while (nsplit.next()) |elem| {
            if (elem.len == 0) continue;
            try list.append(try fmt.parseInt(numt, elem, 10));
        }

        var keys = set.keyIterator();
        while (keys.next()) |e| {
            try stdout.print("{} ", .{e.*});
        }
        for (list.items) |e| {
            if (set.contains(e)) sum += 1;
        }
    }

    try stdout.print("{}\n", .{sum});
}
