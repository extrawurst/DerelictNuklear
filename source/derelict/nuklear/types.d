/*
 * Copyright (c) 2016 Derelict Developers
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * * Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the distribution.
 *
 * * Neither the names 'Derelict', 'DerelictNuklear', nor the names of its contributors
 *   may be used to endorse or promote products derived from this software
 *   without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
module derelict.nuklear.types;

import derelict.nuklear.consts;

version = NK_INCLUDE_VERTEX_BUFFER_OUTPUT;
version = NK_INCLUDE_STANDARD_IO;
version = NK_INCLUDE_DEFAULT_FONT;
version = NK_INCLUDE_DEFAULT_ALLOCATOR;

align(1):

alias cstring = const(char)*;

alias uint32_t = uint;

alias nk_size = size_t;

alias nk_byte = ubyte;
alias nk_flags = uint;
alias nk_rune = uint32_t;
alias nk_hash = uint32_t;
alias nk_uint = uint32_t;

union nk_handle {
    void *ptr; 
    int id;
}

struct nk_image {
    nk_handle handle;
    ushort w; ushort h;
    ushort[4] region;
}
struct nk_scroll {ushort x, y;};

enum {nk_false, nk_true};
struct nk_color {nk_byte r,g,b,a;};
struct nk_vec2 {float x,y;};
struct nk_vec2i {short x, y;};
struct nk_rect {float x,y,w,h;};
struct nk_recti {short x,y,w,h;};

alias nk_filter = int function(const(nk_text_edit)*, nk_rune unicode);
alias nk_paste_f = void function(nk_handle, nk_text_edit*);
alias nk_copy_f = void function(nk_handle, cstring, int len);

struct nk_allocator {
    nk_handle userdata;
    void* function(nk_handle, void *old, nk_size) alloc;
    void function(nk_handle, void*) free;
}

struct nk_draw_null_texture {
    nk_handle texture;/* texture handle to a texture with a white pixel */
    nk_vec2 uv; /* coordinates to a white pixel in the texture  */
}

struct nk_buffer_marker {
    int active;
    nk_size offset;
};

struct nk_memory {
    void *ptr;
    nk_size size;
}

struct nk_buffer {
    nk_buffer_marker[NK_BUFFER_MAX] marker;
    /* buffer marker to free a buffer to a certain offset */
    nk_allocator pool;
    /* allocator callback for dynamic buffers */
    nk_allocation_type type;
    /* memory management type */
    nk_memory memory;
    /* memory and size of the current memory block */
    float grow_factor;
    /* growing factor for dynamic memory management */
    nk_size allocated;
    /* total amount of memory allocated */
    nk_size needed;
    /* totally consumed memory given that enough memory is present */
    nk_size calls;
    /* number of allocation calls */
    nk_size size;
    /* current size of the buffer */
};

struct nk_str {
    nk_buffer buffer;
    int len; /* in codepoints/runes/glyphs */
};

struct nk_mouse_button {
    int down;
    uint clicked;
    nk_vec2 clicked_pos;
};

struct nk_mouse {
    nk_mouse_button[NK_BUTTON_MAX] buttons;
    nk_vec2 pos;
    nk_vec2 prev;
    nk_vec2 delta;
    float scroll_delta;
    ubyte grab;
    ubyte grabbed;
    ubyte ungrab;
}

struct nk_key {
    int down;
    uint clicked;
}

struct nk_keyboard {
    nk_key[NK_KEY_MAX] keys;
    char[NK_INPUT_MAX] text;
    int text_len;
}

struct nk_input {
    nk_keyboard keyboard;
    nk_mouse mouse;
}

struct nk_clipboard {
    nk_handle userdata;
    nk_paste_f paste;
    nk_copy_f copy;
}

struct nk_text_undo_record {
   int where;
   short insert_length;
   short delete_length;
   short char_storage;
}

struct nk_text_undo_state {
   nk_text_undo_record[NK_TEXTEDIT_UNDOSTATECOUNT] undo_rec;
   nk_rune[NK_TEXTEDIT_UNDOCHARCOUNT] undo_char;
   short undo_point;
   short redo_point;
   short undo_char_point;
   short redo_char_point;
}

struct nk_text_edit {
    nk_clipboard clip;
    nk_str string;
    nk_filter filter;
    nk_vec2 scrollbar;

    int cursor;
    int select_start;
    int select_end;
    ubyte mode;
    ubyte cursor_at_end_of_line;
    ubyte initialized;
    ubyte has_preferred_x;
    ubyte single_line;
    ubyte active;
    ubyte padding1;
    float preferred_x;
    nk_text_undo_state undo;
}

struct nk_context {
/* public: can be accessed freely */
    nk_input input;
    nk_style style;
    nk_buffer memory;
    nk_clipboard clip;
    nk_flags last_widget_state;

/* private:
    should only be accessed if you
    know what you are doing */
    version(NK_INCLUDE_VERTEX_BUFFER_OUTPUT)
    nk_draw_list draw_list;

    version(NK_INCLUDE_COMMAND_USERDATA)
    nk_handle userdata;

    /* text editor objects are quite big because they have a internal
     * undo/redo stack. It therefore does not make sense to have one for
     * each window for temporary use cases, so I only provide *one* instance
     * for all windows. This works because the content is cleared anyway */
    nk_text_edit text_edit;

    /* windows */
    int build;
    void *pool;
    nk_window *begin;
    nk_window *end;
    nk_window *active;
    nk_window *current;
    nk_page_element *freelist;
    uint count;
    uint seq;
}

union nk_style_item_data {
    nk_image image;
    nk_color color;
}

struct nk_style_item {
    nk_style_item_type type;
    nk_style_item_data data;
}

struct nk_style_text {
    nk_color color;
    nk_vec2 padding;
}

struct nk_style_button {
    /* background */
    nk_style_item normal;
    nk_style_item hover;
    nk_style_item active;
    nk_color border_color;

    /* text */
    nk_color text_background;
    nk_color text_normal;
    nk_color text_hover;
    nk_color text_active;
    nk_flags text_alignment;

    /* properties */
    float border;
    float rounding;
    nk_vec2 padding;
    nk_vec2 image_padding;
    nk_vec2 touch_padding;

    /* optional user callbacks */
    nk_handle userdata;
    void function(nk_command_buffer*, nk_handle userdata) draw_begin;
    void function(nk_command_buffer*, nk_handle userdata) draw_end;
};

struct nk_style_toggle {
    /* background */
    nk_style_item normal;
    nk_style_item hover;
    nk_style_item active;

    /* cursor */
    nk_style_item cursor_normal;
    nk_style_item cursor_hover;

    /* text */
    nk_color text_normal;
    nk_color text_hover;
    nk_color text_active;
    nk_color text_background;
    nk_flags text_alignment;

    /* properties */
    nk_vec2 padding;
    nk_vec2 touch_padding;

    /* optional user callbacks */
    nk_handle userdata;
    void function(nk_command_buffer*, nk_handle) draw_begin;
    void function(nk_command_buffer*, nk_handle) draw_end;
}

struct nk_style_selectable {
    /* background (inactive) */
    nk_style_item normal;
    nk_style_item hover;
    nk_style_item pressed;

    /* background (active) */
    nk_style_item normal_active;
    nk_style_item hover_active;
    nk_style_item pressed_active;

    /* text color (inactive) */
    nk_color text_normal;
    nk_color text_hover;
    nk_color text_pressed;

    /* text color (active) */
    nk_color text_normal_active;
    nk_color text_hover_active;
    nk_color text_pressed_active;
    nk_color text_background;
    nk_flags text_alignment;

    /* properties */
    float rounding;
    nk_vec2 padding;
    nk_vec2 touch_padding;
    nk_vec2 image_padding;

    /* optional user callbacks */
    nk_handle userdata;
    void function(nk_command_buffer*, nk_handle) draw_begin;
    void function(nk_command_buffer*, nk_handle) draw_end;
}

struct nk_style_slider {
    /* background */
    nk_style_item normal;
    nk_style_item hover;
    nk_style_item active;
    nk_color border_color;

    /* background bar */
    nk_color bar_normal;
    nk_color bar_hover;
    nk_color bar_active;
    nk_color bar_filled;

    /* cursor */
    nk_style_item cursor_normal;
    nk_style_item cursor_hover;
    nk_style_item cursor_active;

    /* properties */
    float border;
    float rounding;
    float bar_height;
    nk_vec2 padding;
    nk_vec2 spacing;
    nk_vec2 cursor_size;

    /* optional buttons */
    int show_buttons;
    nk_style_button inc_button;
    nk_style_button dec_button;
    nk_symbol_type inc_symbol;
    nk_symbol_type dec_symbol;

    /* optional user callbacks */
    nk_handle userdata;
    void function(nk_command_buffer*, nk_handle) draw_begin;
    void function(nk_command_buffer*, nk_handle) draw_end;
};

struct nk_style_progress {
    /* background */
    nk_style_item normal;
    nk_style_item hover;
    nk_style_item active;

    /* cursor */
    nk_style_item cursor_normal;
    nk_style_item cursor_hover;
    nk_style_item cursor_active;

    /* properties */
    float rounding;
    nk_vec2 padding;

    /* optional user callbacks */
    nk_handle userdata;
    void function(nk_command_buffer*, nk_handle) draw_begin;
    void function(nk_command_buffer*, nk_handle) draw_end;
};

struct nk_style_scrollbar {
    /* background */
    nk_style_item normal;
    nk_style_item hover;
    nk_style_item active;
    nk_color border_color;

    /* cursor */
    nk_style_item cursor_normal;
    nk_style_item cursor_hover;
    nk_style_item cursor_active;

    /* properties */
    float border;
    float rounding;
    nk_vec2 padding;

    /* optional buttons */
    int show_buttons;
    nk_style_button inc_button;
    nk_style_button dec_button;
    nk_symbol_type inc_symbol;
    nk_symbol_type dec_symbol;

    /* optional user callbacks */
    nk_handle userdata;
    void function(nk_command_buffer*, nk_handle) draw_begin;
    void function(nk_command_buffer*, nk_handle) draw_end;
}

struct nk_style_edit {
    /* background */
    nk_style_item normal;
    nk_style_item hover;
    nk_style_item active;
    nk_color border_color;
    nk_style_scrollbar scrollbar;

    /* cursor  */
    nk_color cursor_normal;
    nk_color cursor_hover;
    nk_color cursor_text_normal;
    nk_color cursor_text_hover;

    /* text (unselected) */
    nk_color text_normal;
    nk_color text_hover;
    nk_color text_active;

    /* text (selected) */
    nk_color selected_normal;
    nk_color selected_hover;
    nk_color selected_text_normal;
    nk_color selected_text_hover;

    /* properties */
    float border;
    float rounding;
    float cursor_size;
    nk_vec2 scrollbar_size;
    nk_vec2 padding;
    float row_padding;
}

struct nk_style_property {
    /* background */
    nk_style_item normal;
    nk_style_item hover;
    nk_style_item active;
    nk_color border_color;

    /* text */
    nk_color label_normal;
    nk_color label_hover;
    nk_color label_active;

    /* symbols */
    nk_symbol_type sym_left;
    nk_symbol_type sym_right;

    /* properties */
    float border;
    float rounding;
    nk_vec2 padding;

    nk_style_edit edit;
    nk_style_button inc_button;
    nk_style_button dec_button;

    /* optional user callbacks */
    nk_handle userdata;
    void function(nk_command_buffer*, nk_handle) draw_begin;
    void function(nk_command_buffer*, nk_handle) draw_end;
}

struct nk_style_chart {
    /* colors */
    nk_style_item background;
    nk_color border_color;
    nk_color selected_color;
    nk_color color;

    /* properties */
    float border;
    float rounding;
    nk_vec2 padding;
}

struct nk_style_combo {
    /* background */
    nk_style_item normal;
    nk_style_item hover;
    nk_style_item active;
    nk_color border_color;

    /* label */
    nk_color label_normal;
    nk_color label_hover;
    nk_color label_active;

    /* symbol */
    nk_color symbol_normal;
    nk_color symbol_hover;
    nk_color symbol_active;

    /* button */
    nk_style_button button;
    nk_symbol_type sym_normal;
    nk_symbol_type sym_hover;
    nk_symbol_type sym_active;

    /* properties */
    float border;
    float rounding;
    nk_vec2 content_padding;
    nk_vec2 button_padding;
    nk_vec2 spacing;
}

struct nk_style_tab {
    /* background */
    nk_style_item background;
    nk_color border_color;
    nk_color text;

    /* button */
    nk_style_button tab_button;
    nk_style_button node_button;
    nk_symbol_type sym_minimize;
    nk_symbol_type sym_maximize;

    /* properties */
    float border;
    float rounding;
    nk_vec2 padding;
    nk_vec2 spacing;
}

struct nk_style_window_header {
    /* background */
    nk_style_item normal;
    nk_style_item hover;
    nk_style_item active;

    /* button */
    nk_style_button close_button;
    nk_style_button minimize_button;
    nk_symbol_type close_symbol;
    nk_symbol_type minimize_symbol;
    nk_symbol_type maximize_symbol;

    /* title */
    nk_color label_normal;
    nk_color label_hover;
    nk_color label_active;

    /* properties */
    nk_style_header_align align_; //NOTE: "align" is a reserved keyword in D
    nk_vec2 padding;
    nk_vec2 label_padding;
    nk_vec2 spacing;
}

struct nk_style_window {
    nk_style_window_header header;
    nk_style_item fixed_background;
    nk_color background;

    nk_color border_color;
    nk_color combo_border_color;
    nk_color contextual_border_color;
    nk_color menu_border_color;
    nk_color group_border_color;
    nk_color tooltip_border_color;

    nk_style_item scaler;
    nk_vec2 footer_padding;

    float border;
    float combo_border;
    float contextual_border;
    float menu_border;
    float group_border;
    float tooltip_border;

    float rounding;
    nk_vec2 scaler_size;
    nk_vec2 padding;
    nk_vec2 spacing;
    nk_vec2 scrollbar_size;
    nk_vec2 min_size;
}

struct nk_style {
    nk_user_font font;
    nk_style_text text;
    nk_style_button button;
    nk_style_button contextual_button;
    nk_style_button menu_button;
    nk_style_toggle option;
    nk_style_toggle checkbox;
    nk_style_selectable selectable;
    nk_style_slider slider;
    nk_style_progress progress;
    nk_style_property property;
    nk_style_edit edit;
    nk_style_chart chart;
    nk_style_scrollbar scrollh;
    nk_style_scrollbar scrollv;
    nk_style_tab tab;
    nk_style_combo combo;
    nk_style_window window;
}

struct nk_popup_state {
    nk_window *win;
    nk_window_flags type;
    nk_hash name;
    int active;
    uint combo_count;
    uint con_count, con_old;
    uint active_con;
}

struct nk_edit_state {
    nk_hash name;
    uint seq;
    uint old;
    int active, prev;
    int cursor;
    int sel_start;
    int sel_end;
    nk_scroll scrollbar;
    ubyte mode;
    ubyte single_line;
}

struct nk_property_state {
    int active, prev;
    char[NK_MAX_NUMBER_BUFFER] buffer;
    int length;
    int cursor;
    nk_hash name;
    uint seq;
    uint old;
    int state;
}

struct nk_scaling_state {
    nk_vec2 start_size;
    int active;
}

struct nk_window {
    uint seq;
    nk_hash name;
    nk_flags flags;
    nk_rect bounds;
    nk_scroll scrollbar;
    nk_command_buffer buffer;
    nk_panel *layout;

    /* persistent widget state */
    nk_property_state property;
    nk_popup_state popup;
    nk_edit_state edit;
    nk_scaling_state scaling;

    nk_table *tables;
    ushort table_count;
    ushort table_size;

    /* window list hooks */
    nk_window *next;
    nk_window *prev;
    nk_window *parent;
}

struct nk_baked_font {
    float height;
    /* height of the font  */
    float ascent, descent;
    /* font glyphs ascent and descent  */
    nk_rune glyph_offset;
    /* glyph array offset inside the font glyph baking output array  */
    nk_rune glyph_count;
    /* number of glyphs of this font inside the glyph baking array output */
    const(nk_rune)* ranges;
    /* font codepoint ranges as pairs of (from/to) and 0 as last element */
}

struct nk_font_config {
    void *ttf_blob;
    /* pointer to loaded TTF file memory block.
     * NOTE: not needed for nk_font_atlas_add_from_memory and nk_font_atlas_add_from_file. */
    nk_size ttf_size;
    /* size of the loaded TTF file memory block
     * NOTE: not needed for nk_font_atlas_add_from_memory and nk_font_atlas_add_from_file. */

    ubyte ttf_data_owned_by_atlas;
    /* used inside font atlas: default to: 0*/
    ubyte merge_mode;
    /* merges this font into the last font */
    ubyte pixel_snap;
    /* align very character to pixel boundary (if true set oversample (1,1)) */
    ubyte oversample_v;
    ubyte oversample_h;
    /* rasterize at hight quality for sub-pixel position */
    ubyte[3] padding;

    float size;
    /* baked pixel height of the font */
    nk_font_coord_type coord_type;
    /* texture coordinate format with either pixel or UV coordinates */
    nk_vec2 spacing;
    /* extra pixel spacing between glyphs  */
    const(nk_rune)* range;
    /* list of unicode ranges (2 values per range, zero terminated) */
    nk_baked_font *font;
    /* font to setup in the baking process: NOTE: not needed for font atlas */
    nk_rune fallback_glyph;
    /* fallback glyph to use if a given rune is not found */
}

alias nk_text_width_f = float function(nk_handle, float h, const(char)*, int len);
alias nk_query_font_glyph_f = void function(nk_handle handle, float font_height,
                                    nk_user_font_glyph *glyph,
                                    nk_rune codepoint, nk_rune next_codepoint);

struct nk_user_font {
    nk_handle userdata;
    /* user provided font handle */
    float height;
    /* max height of the font */
    nk_text_width_f width;
    /* font string width in pixel callback */
    version(NK_INCLUDE_VERTEX_BUFFER_OUTPUT) {
    nk_query_font_glyph_f query;
    /* font glyph callback to query drawing info */
    nk_handle texture;
    /* texture handle to the used font atlas or texture */
    }
}

version(NK_INCLUDE_VERTEX_BUFFER_OUTPUT)
struct nk_user_font_glyph {
    nk_vec2[2] uv;
    /* texture coordinates */
    nk_vec2 offset;
    /* offset between top left and glyph */
    float width, height;
    /* size of the glyph  */
    float xadvance;
    /* offset to the next glyph */
}

struct nk_font_glyph {
    nk_rune codepoint;
    float xadvance;
    float x0, y0, x1, y1, w, h;
    float u0, v0, u1, v1;
}

struct nk_font {
    nk_user_font handle;
    nk_baked_font info;
    float scale;
    nk_font_glyph *glyphs;
    const(nk_font_glyph)* fallback;
    nk_rune fallback_codepoint;
    nk_handle texture;
    int config;
}

struct nk_font_atlas {
    void* pixel;
    int tex_width;
    int tex_height;
    nk_allocator alloc;
    nk_recti custom;

    int glyph_count;
    nk_font* default_font;
    nk_font_glyph* glyphs;
    nk_font** fonts;
    nk_font_config* config;
    int font_num;
    int font_cap;
}

immutable NK_VALUE_PAGE_CAPACITY  = (nk_window.sizeof / nk_uint.sizeof / 2);
struct nk_table {
    uint seq;
    nk_hash[NK_VALUE_PAGE_CAPACITY] keys;
    nk_uint[NK_VALUE_PAGE_CAPACITY] values;
    nk_table* next, prev;
}

union nk_page_data {
    nk_table tbl;
    nk_window win;
}

struct nk_page_element {
    nk_page_data data;
    nk_page_element *next;
    nk_page_element *prev;
}

struct nk_page {
    uint size;
    nk_page *next;
    nk_page_element[1] win;
}

struct nk_pool {
    nk_allocator alloc;
    nk_allocation_type type;
    uint page_count;
    nk_page *pages;
    nk_page_element *freelist;
    uint capacity;
    nk_size size;
    nk_size cap;
}

/* command base and header of every command inside the buffer */
struct nk_command {
    nk_command_type type;
    nk_size next;
    version(NK_INCLUDE_COMMAND_USERDATA)
    nk_handle userdata;
};

struct nk_command_scissor {
    nk_command header;
    short x, y;
    ushort w, h;
};

struct nk_command_line {
    nk_command header;
    ushort line_thickness;
    nk_vec2i begin;
    nk_vec2i end;
    nk_color color;
};

struct nk_command_curve {
    nk_command header;
    ushort line_thickness;
    nk_vec2i begin;
    nk_vec2i end;
    nk_vec2i[2] ctrl;
    nk_color color;
};

struct nk_command_rect {
    nk_command header;
    ushort rounding;
    ushort line_thickness;
    short x, y;
    ushort w, h;
    nk_color color;
};

struct nk_command_rect_filled {
    nk_command header;
    ushort rounding;
    short x, y;
    ushort w, h;
    nk_color color;
};

struct nk_command_rect_multi_color {
    nk_command header;
    short x, y;
    ushort w, h;
    nk_color left;
    nk_color top;
    nk_color bottom;
    nk_color right;
};

struct nk_command_triangle {
    nk_command header;
    ushort line_thickness;
    nk_vec2i a;
    nk_vec2i b;
    nk_vec2i c;
    nk_color color;
};

struct nk_command_triangle_filled {
    nk_command header;
    nk_vec2i a;
    nk_vec2i b;
    nk_vec2i c;
    nk_color color;
};

struct nk_command_circle {
    nk_command header;
    short x, y;
    ushort line_thickness;
    ushort w, h;
    nk_color color;
}

struct nk_command_circle_filled {
    nk_command header;
    short x, y;
    ushort w, h;
    nk_color color;
}

struct nk_command_arc {
    nk_command header;
    short cx, cy;
    ushort r;
    ushort line_thickness;
    float[2] a;
    nk_color color;
}

struct nk_command_arc_filled {
    nk_command header;
    short cx, cy;
    ushort r;
    float[2] a;
    nk_color color;
}

struct nk_command_polygon {
    nk_command header;
    nk_color color;
    ushort line_thickness;
    ushort point_count;
    nk_vec2i[1] points;
}

struct nk_command_polygon_filled {
    nk_command header;
    nk_color color;
    ushort point_count;
    nk_vec2i[1] points;
}

struct nk_command_polyline {
    nk_command header;
    nk_color color;
    ushort line_thickness;
    ushort point_count;
    nk_vec2i[1] points;
}

struct nk_command_image {
    nk_command header;
    short x, y;
    ushort w, h;
    nk_image img;
}

struct nk_command_text {
    nk_command header;
    const(nk_user_font)* font;
    nk_color background;
    nk_color foreground;
    short x, y;
    ushort w, h;
    float height;
    int length;
    char[1] string_; //NOTE: string is a keyword in D
}

struct nk_command_buffer {
    nk_buffer *base;
    nk_rect clip;
    int use_clipping;
    nk_handle userdata;
    nk_size begin, end, last;
}


version(NK_INCLUDE_VERTEX_BUFFER_OUTPUT)
{
alias nk_draw_index = ushort;
alias nk_draw_vertex_color = nk_uint;

struct nk_draw_vertex {
    nk_vec2 position;
    nk_vec2 uv;
    nk_draw_vertex_color col;
}

struct nk_draw_command {
    uint elem_count;
    /* number of elements in the current draw batch */
    nk_rect clip_rect;
    /* current screen clipping rectangle */
    nk_handle texture;
    /* current texture to set */
    version(NK_INCLUDE_COMMAND_USERDATA)
    nk_handle userdata;
}

struct nk_draw_list {
    float global_alpha;
    nk_anti_aliasing shape_AA;
    nk_anti_aliasing line_AA;
    nk_draw_null_texture null_; //NOTE: null is a keyword in D
    nk_rect clip_rect;
    nk_buffer *buffer;
    nk_buffer *vertices;
    nk_buffer *elements;
    uint element_count;
    uint vertex_count;
    nk_size cmd_offset;
    uint cmd_count;
    uint path_count;
    uint path_offset;
    nk_vec2[12] circle_vtx;
    version(NK_INCLUDE_COMMAND_USERDATA)
    nk_handle userdata;
}

}//version(NK_INCLUDE_VERTEX_BUFFER_OUTPUT)

struct nk_chart_slot {
    nk_chart_type type;
    nk_color color;
    nk_color highlight;
    float min, max, range;
    int count;
    nk_vec2 last;
    int index;
}

struct nk_chart {
    nk_chart_slot[NK_CHART_MAX_SLOT] slots;
    int slot;
    float x, y, w, h;
}

struct nk_row_layout {
    int type;
    int index;
    float height;
    int columns;
    const(float)* ratio;
    float item_width, item_height;
    float item_offset;
    float filled;
    nk_rect item;
    int tree_depth;
}

struct nk_popup_buffer {
    nk_size begin;
    nk_size parent;
    nk_size last;
    nk_size end;
    int active;
}

struct nk_menu_state {
    float x, y, w, h;
    nk_scroll offset;
}

struct nk_panel {
    nk_flags flags;
    nk_rect bounds;
    nk_scroll *offset;
    float at_x, at_y, max_x;
    float width, height;
    float footer_h;
    float header_h;
    float border;
    nk_rect clip;
    nk_menu_state menu;
    nk_row_layout row;
    nk_chart chart;
    nk_popup_buffer popup_buffer;
    nk_command_buffer *buffer;
    nk_panel *parent;
}
