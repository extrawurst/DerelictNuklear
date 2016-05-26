module app;

import derelict.nuklear.nuklear;

int main()
{
    DerelictNuklear.load();

    ubyte[] memory = new ubyte[1024 * 1024];

    /* init gui state */
    nk_context ctx;
    nk_init_fixed(&ctx, memory.ptr, memory.length, null);

    enum {EASY, HARD}
    int op = EASY;
    float value = 0.6f;
    int i =  20;

    nk_panel layout;
    nk_begin(&ctx, &layout, "Show", nk_rect(50, 50, 220, 220),
        NK_WINDOW_BORDER|NK_WINDOW_MOVABLE|NK_WINDOW_CLOSABLE);
    /+
    {
        /* fixed widget pixel width */
        nk_layout_row_static(&ctx, 30, 80, 1);
        if (nk_button_text(&ctx, "button", NK_BUTTON_DEFAULT)) {
            /* event handling */
        }

        /* fixed widget window ratio width */
        nk_layout_row_dynamic(&ctx, 30, 2);
        if (nk_option(&ctx, "easy", op == EASY)) op = EASY;
        if (nk_option(&ctx, "hard", op == HARD)) op = HARD;

        /* custom widget pixel width */
        nk_layout_row_begin(&ctx, NK_STATIC, 30, 2);
        {
            nk_layout_row_push(&ctx, 50);
            nk_label(&ctx, "Volume:", NK_TEXT_LEFT);
            nk_layout_row_push(&ctx, 110);
            nk_slider_float(&ctx, 0, &value, 1.0f, 0.1f);
        }
        nk_layout_row_end(&ctx);
    }
    +/
    nk_end(&ctx);

    DerelictNuklear.unload();

    return 0;
}
