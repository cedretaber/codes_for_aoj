import std.stdio, std.string, std.array, std.algorithm, std.conv, std.typecons, std.numeric, std.math;

void main()
{
    auto n = readln.chomp.to!int;
    auto DP = new long[](n+1);
    DP[0] = 1;
    DP[1] = 1;
    foreach (i; 2..n+1) {
        DP[i] = DP[i-1] + DP[i-2];
    }
    writeln(DP[n]);
}