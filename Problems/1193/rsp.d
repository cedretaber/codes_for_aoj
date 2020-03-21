import std.stdio, std.string, std.array, std.algorithm, std.conv, std.typecons, std.numeric, std.math;

void main()
{
    for (;;) {
        auto H = readln.chomp.to!int;
        if (H == 0) return;

        int[][] MAP;
        MAP.length = H;
        foreach (i; 0..H) MAP[i] = readln.split.to!(int[]);

        auto changed = true;
        int r;
        while (changed) {
            foreach (i; 0..H) {
                foreach_reverse (l; 3..6) {
                    foreach (x; 0..6-l) {
                        foreach (j; x+1..x+l) if (MAP[i][x] != MAP[i][j]) goto ng;
                        r += MAP[i][x] * l;
                        foreach (j; x..x+l) MAP[i][j] = 0;
                        goto ok;
                        ng:
                    }
                }
                ok:
            }
            changed = false;
            foreach_reverse (i; 0..H) {
                foreach (j; 0..5) {
                    if (MAP[i][j] == 0) {
                        foreach_reverse (k; 0..i) if (MAP[k][j] > 0) {
                            changed = true;
                            MAP[i][j] = MAP[k][j];
                            MAP[k][j] = 0;
                            break;
                        }
                    }
                }
            }
        }
        writeln(r);
    }
}