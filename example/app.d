module app;

import derelict.nuklear.nuklear;

static assert(nk_context.sizeof == 13120);

int main()
{
    DerelictNuklear.load();

    nk_font_atlas atlas;
    int w, h;

    nk_font_config cfg = nk_font_config_(0.0f);
    cfg.oversample_h = 3; cfg.oversample_v = 2;
    nk_font_atlas_init_default(&atlas);
    nk_font_atlas_begin(&atlas);
    nk_font* font = nk_font_atlas_add_from_file(&atlas, "../nuklear/extra_font/Roboto-Regular.ttf", 14.0f, &cfg);
    auto image = nk_font_atlas_bake(&atlas, &w, &h, NK_FONT_ATLAS_RGBA32);
    nk_font_atlas_end(&atlas, nk_handle_id(0), null);

    assert(font);

    /* init gui state */
    nk_context ctx;
    nk_init_default(&ctx, &font.handle);

    nk_panel layout;
    nk_begin(&ctx, &layout, "Show", nk_rect(50, 50, 220, 220),
        NK_WINDOW_BORDER|NK_WINDOW_MOVABLE|NK_WINDOW_CLOSABLE);
    
    nk_end(&ctx);

    nk_free(&ctx);

    DerelictNuklear.unload();

    return 0;
}
