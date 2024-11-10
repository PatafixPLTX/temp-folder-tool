const std = @import("std");
const gzip = std.compress.gzip;

const testString = 
    \\{
    \\    "8e278ebd-5cd3-48f5-b271-074cea825d6c": {
    \\         "abc": 123,
    \\         "def": 456,
    \\         "ghi": 789
    \\    }
    \\}
;


pub fn main() !void {
    std.debug.print("ToEncode: {s}\n", .{testString});
    // var GPA = std.heap.GeneralPurposeAllocator(.{}){};
    // const allocator = GPA.allocator();

    // var buffer = std.ArrayList(u8).init(allocator);
    // defer buffer.deinit();
    var file = try std.fs.cwd().openFile("customRetentions.bin", .{
        .mode = .write_only,
    });

    var FBS = std.io.fixedBufferStream(testString);

    try gzip.compress(FBS.reader(), file.writer(), .{});

    // std.debug.print("Encoded: {s}\n", .{buffer.items});
}
