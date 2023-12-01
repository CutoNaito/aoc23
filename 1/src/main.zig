const std = @import("std");

fn part1() !void {
    var file = try std.fs.cwd().openFile("input", .{});
    defer file.close();

    var buffer: [1024]u8 = undefined;
    const allocator = std.heap.page_allocator;
    var sum: i32 = 0;

    while (try file.reader().readUntilDelimiterOrEof(&buffer, '\n')) |line| {
        var digit = std.ArrayList(u8).init(allocator);
        defer digit.deinit();
        var result_digit: [2]u8 = undefined;

        for (line) |c| {
            if (std.ascii.isDigit(c))
                try digit.append(c);
        }

        result_digit = [_]u8{ digit.items[0], digit.getLast() };
        sum += try std.fmt.parseInt(i32, &result_digit, 10);
    }

    std.debug.print("{}\n", .{sum});
}

fn part2() !void {
    var file = try std.fs.cwd().openFile("input", .{});
    defer file.close();

    var buffer: [1024]u8 = undefined;
    const allocator = std.heap.page_allocator;
    var sum: i32 = 0;

    var numbers = std.StringHashMap(u8).init(allocator);
    defer numbers.deinit();

    try numbers.put("one", '1');
    try numbers.put("two", '2');
    try numbers.put("three", '3');
    try numbers.put("four", '4');
    try numbers.put("five", '5');
    try numbers.put("six", '6');
    try numbers.put("seven", '7');
    try numbers.put("eight", '8');
    try numbers.put("nine", '9');

    while (try file.reader().readUntilDelimiterOrEof(&buffer, '\n')) |line| {
        var digit = std.ArrayList(u8).init(allocator);
        var result_digit: [2]u8 = undefined;

        var i: usize = 0;
        while (i < line.len) {
            if (std.ascii.isDigit(line[i]))
                try digit.append(line[i]);

            var j: usize = i + 1;
            while (j <= line.len) {
                if (numbers.contains(line[i..j])) {
                    try digit.append(numbers.get(line[i..j]).?);
                    i = j - 2;
                    break;
                } else {
                    j += 1;
                }
            }

            i += 1;
        }

        result_digit = [_]u8{ digit.items[0], digit.getLast() };

        sum += try std.fmt.parseInt(i32, &result_digit, 10);
    }

    std.debug.print("{}\n", .{sum});
}

pub fn main() !void {
    try part1();
    try part2();
}
