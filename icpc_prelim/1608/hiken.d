import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    for (;;) {
        auto n = readln.chomp.to!int;
        if (n == 0) return;

        auto as = readln.split.to!(int[]);
        sort(as);
        auto d = int.max;
        foreach (i; 0..n-1) {
            d = min(d, as[i+1] - as[i]);
        }
        writeln(d);
    }
}