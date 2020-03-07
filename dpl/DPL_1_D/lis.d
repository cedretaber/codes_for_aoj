import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] AS;
    foreach (_; 0..N) AS ~= readln.chomp.to!int;

    int[] lis;
    foreach (a; AS) {
        if (lis.empty || lis[$-1] < a) {
            lis ~= a;
            continue;
        } else if (lis[0] >= a) {
            lis[0] = a;
            continue;
        }

        size_t l, r = lis.length-1;
        while (l+1 < r) {
            auto m = (l+r)/2;
            if (lis[m] >= a) {
                r = m;
            } else {
                l = m;
            }
        }
        lis[r] = a;
    }
    writeln(lis.length);
}