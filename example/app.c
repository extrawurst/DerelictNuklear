#define NK_INCLUDE_FIXED_TYPES
#define NK_INCLUDE_DEFAULT_ALLOCATOR
#define NK_INCLUDE_DEFAULT_FONT
#define NK_INCLUDE_STANDARD_IO
#define NK_INCLUDE_FONT_BAKING
#define NK_INCLUDE_VERTEX_BUFFER_OUTPUT

#define NK_IMPLEMENTATION
#include "../nuklear/nuklear.h"

void main()
{
    struct nk_font_atlas atlas;
    int w, h;

    struct nk_font_config cfg = nk_font_config(0.0f);
    cfg.oversample_h = 3; cfg.oversample_v = 2;
    /* Loading one font with different heights is only required if you want higher
     * quality text otherwise you can just set the font height directly
     * e.g.: ctx->style.font.height = 20. */
    nk_font_atlas_init_default(&atlas);
    nk_font_atlas_begin(&atlas);
    struct nk_font* font = nk_font_atlas_add_from_file(&atlas, "../nuklear/extra_font/Roboto-Regular.ttf", 14.0f, &cfg);
    const void* image = nk_font_atlas_bake(&atlas, &w, &h, NK_FONT_ATLAS_RGBA32);
    //device_upload_atlas(&device, image, w, h);
    nk_font_atlas_end(&atlas, nk_handle_id(0), 0);

    /* init gui state */
    struct nk_context ctx;
    nk_init_default(&ctx, &font->handle);

    enum {EASY, HARD};
    int op = EASY;
    float value = 0.6f;
    int i =  20;

    struct nk_panel layout;
    nk_begin(&ctx, &layout, "Show", nk_rect(50, 50, 220, 220),
        NK_WINDOW_BORDER|NK_WINDOW_MOVABLE|NK_WINDOW_CLOSABLE);
    
    nk_end(&ctx);
}
