const std = @import("std");

pub fn main() !void {
    // Allocator, yay
    var gp = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = gp.deinit();
    const allocator = gp.allocator();

    var file = try std.fs.cwd().openFile("file", .{});
    defer file.close();

    const maxSize = 65536;
    var reader = file.reader();

    while (try reader.readUntilDelimiterOrEofAlloc(allocator, '\n', maxSize)) |line| {
        defer allocator.free(line);
        std.debug.print("{s}\n", .{line});
    }
}
