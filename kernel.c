typedef unsigned short u16;

void main() {
    u16* vid_mem = (u16*) 0xb8600;
    // for colors, google "EGA color table"
    *vid_mem = 0x1d00 | 'X'; 
}
