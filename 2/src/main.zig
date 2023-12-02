const std = @import("std");

fn part1() !void {
    var file = try std.fs.cwd().openFile("input", .{});
    defer file.close();

    var buffer: [1024]u8 = undefined;
    var sum: i32 = 0;

    while (try file.reader().readUntilDelimiterOrEof(&buffer, '\n')) |line| {
        var game_id_slice = std.mem.splitSequence(u8, line, ":");
        const game_id_first_part = game_id_slice.first();
        var game_id_iter = std.mem.splitSequence(u8, game_id_first_part, " ");
        _ = game_id_iter.first();

        const game_id = try std.fmt.parseInt(i32, game_id_iter.next().?, 10);
        var is_valid: bool = false;

        const game_id_next_part = game_id_slice.next().?;

        var sets_iter = std.mem.splitSequence(u8, game_id_next_part, ";");

        while (sets_iter.next()) |set| {
            var red: i32 = 0;
            var blue: i32 = 0;
            var green: i32 = 0;

            var item_iter = std.mem.splitSequence(u8, set, ",");

            while (item_iter.next()) |item| {
                var value_iter = std.mem.splitSequence(u8, item, " ");
                _ = value_iter.first();
                const value = try std.fmt.parseInt(i32, value_iter.next().?, 10);
                const color = value_iter.next().?;

                switch (color[0]) {
                    'b' => blue += value,
                    'r' => red += value,
                    'g' => green += value,
                    else => unreachable,
                }
            }

            if (blue <= 14 and green <= 13 and red <= 12) {
                std.debug.print("Valid: {} {} {}\n", .{ blue, green, red });
                is_valid = true;
            } else {
                std.debug.print("Invalid: {} {} {}\n", .{ blue, green, red });
                is_valid = false;
                break;
            }
        }

        if (is_valid)
            sum += game_id;
    }

    std.debug.print("{}\n", .{sum});
}

fn part2() !void {
    var file = try std.fs.cwd().openFile("input", .{});
    defer file.close();

    var buffer: [1024]u8 = undefined;
    var sum: i32 = 0;

    while (try file.reader().readUntilDelimiterOrEof(&buffer, '\n')) |line| {
        var fewest_red: i32 = 0;
        var fewest_blue: i32 = 0;
        var fewest_green: i32 = 0;

        var game_id_slice = std.mem.splitSequence(u8, line, ":");
        const game_id_first_part = game_id_slice.first();
        var game_id_iter = std.mem.splitSequence(u8, game_id_first_part, " ");
        _ = game_id_iter.first();

        const game_id = try std.fmt.parseInt(i32, game_id_iter.next().?, 10);
        _ = game_id;

        var is_valid: bool = false;
        _ = is_valid;

        const game_id_next_part = game_id_slice.next().?;
        var sets_iter = std.mem.splitSequence(u8, game_id_next_part, ";");

        while (sets_iter.next()) |set| {
            var item_iter = std.mem.splitSequence(u8, set, ",");

            while (item_iter.next()) |item| {
                var value_iter = std.mem.splitSequence(u8, item, " ");
                _ = value_iter.first();
                const value = try std.fmt.parseInt(i32, value_iter.next().?, 10);
                const color = value_iter.next().?;

                switch (color[0]) {
                    'b' => {
                        if (value > fewest_blue)
                            fewest_blue = value;
                    },
                    'r' => {
                        if (value > fewest_red)
                            fewest_red = value;
                    },
                    'g' => {
                        if (value > fewest_green)
                            fewest_green = value;
                    },
                    else => unreachable,
                }
            }
        }

        sum += (fewest_blue * fewest_red * fewest_green);
    }

    std.debug.print("{}\n", .{sum});
}

pub fn main() !void {
    try part1();
    try part2();
}
