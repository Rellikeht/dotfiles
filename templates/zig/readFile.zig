const std = @import("std");

pub fn main() !void {
  var buf: [1024]u8 = undefined;

  // Also valid
  // var file = try std.fs.openFileAbsolute("./file", .{});
  var file = try std.fs.cwd().openFile("file", .{});
  defer file.close();

//  var buf_reader = std.io.bufferedReader(file.reader());
//  // This has to be separate, because some very long error
//  // that probably wants to tell something about constness
//  var in_stream = buf_reader.reader();

  // Probably more elegant solution
  var in_stream = b: {
    var buf_reader = std.io.bufferedReader(file.reader());
    break :b buf_reader.reader();
  };

  while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
    // This s needs to be inside {} because of
    // some types probably
    std.debug.print("{s}\n", .{line});
  }

}
