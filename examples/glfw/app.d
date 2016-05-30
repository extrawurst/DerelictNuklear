module app;

import derelict.opengl3.gl3;
import derelict.glfw3.glfw3;

import derelict.nuklear.nuklear;

import utils;

immutable WINOW_WIDTH = 800;
immutable WINOW_HEIGHT = 600;

nk_context ctx;
nk_font_atlas atlas;

void initNuklear()
{
    int w, h;

    nk_font_config cfg = nk_font_config_(0.0f);
    cfg.oversample_h = 3; cfg.oversample_v = 2;

    nk_font_atlas_init_default(&atlas);
    nk_font_atlas_begin(&atlas);
    nk_font* font = nk_font_atlas_add_from_file(&atlas, "../../nuklear/extra_font/Roboto-Regular.ttf", 14.0f, &cfg);
    auto image = nk_font_atlas_bake(&atlas, &w, &h, NK_FONT_ATLAS_RGBA32);
    nk_font_atlas_end(&atlas, nk_handle_id(0), null);

    assert(font);

    nk_init_default(&ctx, &font.handle);
}

void doNuklear()
{
    nk_panel layout;
    nk_begin(&ctx, &layout, "Show", nk_rect(50, 50, 220, 220),
        NK_WINDOW_BORDER|NK_WINDOW_MOVABLE|NK_WINDOW_CLOSABLE);
    
    nk_button_label(&ctx, "Push me", NK_BUTTON_DEFAULT);
    
    nk_end(&ctx);
}

int main()
{
    DerelictGL3.load();
    DerelictGLFW3.load();
    DerelictNuklear.load();

    auto window = initGlfw(WINOW_WIDTH,WINOW_HEIGHT);

    DerelictGL3.reload();

    initNuklear();

    while (!glfwWindowShouldClose(window))
    {
        glfwPollEvents();

        doNuklear();

        // Rendering
        glViewport(0, 0, WINOW_WIDTH, WINOW_HEIGHT);
        //glClearColor(0, clear_color[1], clear_color[2], 0);
        glClear(GL_COLOR_BUFFER_BIT);
        //igRender();
        glfwSwapBuffers(window);
    }

    nk_free(&ctx);

    glfwTerminate();

    DerelictNuklear.unload();
    DerelictGLFW3.unload();
    DerelictGL3.unload();

    return 0;
}
