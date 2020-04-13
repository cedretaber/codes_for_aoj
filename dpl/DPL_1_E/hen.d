import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto s1 = readln.chomp;
    auto s2 = readln.chomp;
    writeln(levenshteinDistance(s1, s2));
}