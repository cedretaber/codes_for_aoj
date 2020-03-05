import std.stdio, std.string, std.array, std.algorithm, std.conv, std.typecons, std.numeric, std.math;

void main()
{
    for (;;) {
        auto wh = readln.split.to!(int[]);
        auto W = wh[0];
        auto H = wh[1];
        if (W == 0 && H == 0) return;

        auto MAP = new char[][](2*H-1, 2*W-1);
        foreach (i; 0..2*H-1) {
            foreach (j, c; readln.chomp) {
                MAP[i][j] = c;
            }
        }

        auto MEMO = new bool[][](2*H-1, 2*W-1);

        auto ss = [[0, 0, 0]];
        MEMO[0][0] = true;
        while (!ss.empty) {
            auto s = ss[0];
            ss = ss[1..$];
            auto x = s[0];
            auto y = s[1];
            auto c = s[2];
            foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
                auto xx = x+d[0];
                auto yy = y+d[1];
                if (xx < 0 || xx >= 2*W-1 || yy < 0 || yy >= 2*H-1 || MAP[yy][xx] == '1') continue;
                xx += d[0];
                yy += d[1];
                if (MEMO[yy][xx]) continue;
                MEMO[yy][xx] = true;
                if (xx == 2*W-2 && yy == 2*H-2) {
                    writeln(c+2);
                    goto ok;
                }
                ss ~= [xx, yy, c+1];
            }
        }
        writeln(0);
        ok:
    }
}