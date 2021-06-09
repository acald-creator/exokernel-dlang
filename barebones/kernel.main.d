module kernel.main;
import core.bitop;
import core.volatile;

extern (C) void main(uint magic, uint addr)
{
    int ypos = 0;
    int xpos = 0;
    const uint COLUMNS = 80;
    const uint LINES = 25;

    ubyte* vidmem = cast(ubyte*) 0xFFFF_8000_000B_8000;

    for (int i = 0; i < COLUMNS * LINES * 2; i++)
    {
        volatileStore(vidmem + i, 0);

        volatileStore(vidmem + (xpos + ypos * COLUMNS) * 2, 'D' & 0xFF);
        volatileStore(vidmem + (xpos + ypos * COLUMNS) * 2 + 1, 0x07);

        for (;;)
        {

        }
    }
}
