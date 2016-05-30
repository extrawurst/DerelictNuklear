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
module derelict.nuklear.consts;

version = NK_INCLUDE_VERTEX_BUFFER_OUTPUT;
version = NK_INCLUDE_STANDARD_IO;
version = NK_INCLUDE_DEFAULT_FONT;
version = NK_INCLUDE_DEFAULT_ALLOCATOR;

immutable NK_TEXTEDIT_UNDOSTATECOUNT = 99;
immutable NK_TEXTEDIT_UNDOCHARCOUNT = 999;

immutable NK_INPUT_MAX = 16;

immutable NK_MAX_NUMBER_BUFFER = 64;

immutable NK_CHART_MAX_SLOT = 4;

int NK_FLAG(T)(T x) { return 1 << (x); }

enum {
	nk_false, 
	nk_true
}

alias nk_allocation_type = int;
enum {
    NK_BUFFER_FIXED,
    NK_BUFFER_DYNAMIC
}

alias nk_buffer_allocation_type = int;
enum {
    NK_BUFFER_FRONT,
    NK_BUFFER_BACK,
    NK_BUFFER_MAX
}

alias nk_symbol_type = int;
enum {
    NK_SYMBOL_NONE,
    NK_SYMBOL_X,
    NK_SYMBOL_UNDERSCORE,
    NK_SYMBOL_CIRCLE,
    NK_SYMBOL_CIRCLE_FILLED,
    NK_SYMBOL_RECT,
    NK_SYMBOL_RECT_FILLED,
    NK_SYMBOL_TRIANGLE_UP,
    NK_SYMBOL_TRIANGLE_DOWN,
    NK_SYMBOL_TRIANGLE_LEFT,
    NK_SYMBOL_TRIANGLE_RIGHT,
    NK_SYMBOL_PLUS,
    NK_SYMBOL_MINUS,
    NK_SYMBOL_MAX
}

alias nk_keys = int;
enum {
    NK_KEY_NONE,
    NK_KEY_SHIFT,
    NK_KEY_CTRL,
    NK_KEY_DEL,
    NK_KEY_ENTER,
    NK_KEY_TAB,
    NK_KEY_BACKSPACE,
    NK_KEY_COPY,
    NK_KEY_CUT,
    NK_KEY_PASTE,
    NK_KEY_UP,
    NK_KEY_DOWN,
    NK_KEY_LEFT,
    NK_KEY_RIGHT,
    NK_KEY_TEXT_INSERT_MODE,
    NK_KEY_TEXT_REPLACE_MODE,
    NK_KEY_TEXT_RESET_MODE,
    NK_KEY_TEXT_LINE_START,
    NK_KEY_TEXT_LINE_END,
    NK_KEY_TEXT_START,
    NK_KEY_TEXT_END,
    NK_KEY_TEXT_UNDO,
    NK_KEY_TEXT_REDO,
    NK_KEY_TEXT_WORD_LEFT,
    NK_KEY_TEXT_WORD_RIGHT,
    NK_KEY_MAX
}

alias nk_buttons = int;
enum {
    NK_BUTTON_LEFT,
    NK_BUTTON_MIDDLE,
    NK_BUTTON_RIGHT,
    NK_BUTTON_MAX
}

alias nk_style_colors = int;
enum {
    NK_COLOR_TEXT,
    NK_COLOR_WINDOW,
    NK_COLOR_HEADER,
    NK_COLOR_BORDER,
    NK_COLOR_BUTTON,
    NK_COLOR_BUTTON_HOVER,
    NK_COLOR_BUTTON_ACTIVE,
    NK_COLOR_TOGGLE,
    NK_COLOR_TOGGLE_HOVER,
    NK_COLOR_TOGGLE_CURSOR,
    NK_COLOR_SELECT,
    NK_COLOR_SELECT_ACTIVE,
    NK_COLOR_SLIDER,
    NK_COLOR_SLIDER_CURSOR,
    NK_COLOR_SLIDER_CURSOR_HOVER,
    NK_COLOR_SLIDER_CURSOR_ACTIVE,
    NK_COLOR_PROPERTY,
    NK_COLOR_EDIT,
    NK_COLOR_EDIT_CURSOR,
    NK_COLOR_COMBO,
    NK_COLOR_CHART,
    NK_COLOR_CHART_COLOR,
    NK_COLOR_CHART_COLOR_HIGHLIGHT,
    NK_COLOR_SCROLLBAR,
    NK_COLOR_SCROLLBAR_CURSOR,
    NK_COLOR_SCROLLBAR_CURSOR_HOVER,
    NK_COLOR_SCROLLBAR_CURSOR_ACTIVE,
    NK_COLOR_TAB_HEADER,
    NK_COLOR_COUNT
}

alias nk_widget_layout_states = int;
enum {
    NK_WIDGET_INVALID, /* The widget cannot be seen and is completely out of view */
    NK_WIDGET_VALID, /* The widget is completely inside the window and can be updated and drawn */
    NK_WIDGET_ROM /* The widget is partially visible and cannot be updated */
}

alias nk_widget_states = int;
enum {
    NK_WIDGET_STATE_MODIFIED    = NK_FLAG(1),
    NK_WIDGET_STATE_INACTIVE    = NK_FLAG(2), /* widget is neither active nor hovered */
    NK_WIDGET_STATE_ENTERED     = NK_FLAG(3), /* widget has been hovered on the current frame */
    NK_WIDGET_STATE_HOVER       = NK_FLAG(4), /* widget is being hovered */
    NK_WIDGET_STATE_ACTIVED     = NK_FLAG(5),/* widget is currently activated */
    NK_WIDGET_STATE_LEFT        = NK_FLAG(6), /* widget is from this frame on not hovered anymore */
    NK_WIDGET_STATE_HOVERED     = NK_WIDGET_STATE_HOVER|NK_WIDGET_STATE_MODIFIED, /* widget is being hovered */
    NK_WIDGET_STATE_ACTIVE      = NK_WIDGET_STATE_ACTIVED|NK_WIDGET_STATE_MODIFIED /* widget is currently activated */
}

alias nk_text_align = int;
enum {
    NK_TEXT_ALIGN_LEFT        = 0x01,
    NK_TEXT_ALIGN_CENTERED    = 0x02,
    NK_TEXT_ALIGN_RIGHT       = 0x04,
    NK_TEXT_ALIGN_TOP         = 0x08,
    NK_TEXT_ALIGN_MIDDLE      = 0x10,
    NK_TEXT_ALIGN_BOTTOM      = 0x20
}

alias nk_text_alignment = int;
enum {
    NK_TEXT_LEFT        = NK_TEXT_ALIGN_MIDDLE|NK_TEXT_ALIGN_LEFT,
    NK_TEXT_CENTERED    = NK_TEXT_ALIGN_MIDDLE|NK_TEXT_ALIGN_CENTERED,
    NK_TEXT_RIGHT       = NK_TEXT_ALIGN_MIDDLE|NK_TEXT_ALIGN_RIGHT
}

alias nk_edit_flags = int;
enum {
    NK_EDIT_DEFAULT                 = 0,
    NK_EDIT_READ_ONLY               = NK_FLAG(0),
    NK_EDIT_AUTO_SELECT             = NK_FLAG(1),
    NK_EDIT_SIG_ENTER               = NK_FLAG(2),
    NK_EDIT_ALLOW_TAB               = NK_FLAG(3),
    NK_EDIT_NO_CURSOR               = NK_FLAG(4),
    NK_EDIT_SELECTABLE              = NK_FLAG(5),
    NK_EDIT_CLIPBOARD               = NK_FLAG(6),
    NK_EDIT_CTRL_ENTER_NEWLINE      = NK_FLAG(7),
    NK_EDIT_NO_HORIZONTAL_SCROLL    = NK_FLAG(8),
    NK_EDIT_ALWAYS_INSERT_MODE      = NK_FLAG(9),
    NK_EDIT_MULTILINE               = NK_FLAG(11)
}

alias nk_edit_types = int;
enum {
    NK_EDIT_SIMPLE  = NK_EDIT_ALWAYS_INSERT_MODE,
    NK_EDIT_FIELD   = NK_EDIT_SIMPLE|NK_EDIT_SELECTABLE,
    NK_EDIT_BOX     = NK_EDIT_ALWAYS_INSERT_MODE| NK_EDIT_SELECTABLE|
                        NK_EDIT_MULTILINE|NK_EDIT_ALLOW_TAB,
    NK_EDIT_EDITOR  = NK_EDIT_SELECTABLE|NK_EDIT_MULTILINE|NK_EDIT_ALLOW_TAB|
                        NK_EDIT_CLIPBOARD

}

alias nk_edit_events = int;
enum {
    NK_EDIT_ACTIVE      = NK_FLAG(0), /* edit widget is currently being modified */
    NK_EDIT_INACTIVE    = NK_FLAG(1), /* edit widget is not active and is not being modified */
    NK_EDIT_ACTIVATED   = NK_FLAG(2), /* edit widget went from state inactive to state active */
    NK_EDIT_DEACTIVATED = NK_FLAG(3), /* edit widget went from state active to state inactive */
    NK_EDIT_COMMITED    = NK_FLAG(4) /* edit widget has received an enter and lost focus */
}

alias nk_panel_flags = int;
enum {
    NK_WINDOW_BORDER        = NK_FLAG(0), /* Draws a border around the window to visually separate the window * from the background */
    NK_WINDOW_BORDER_HEADER = NK_FLAG(1), /* Draws a border between window header and body */
    NK_WINDOW_MOVABLE       = NK_FLAG(2), /* The movable flag indicates that a window can be moved by user input or * by dragging the window header */
    NK_WINDOW_SCALABLE      = NK_FLAG(3), /* The scalable flag indicates that a window can be scaled by user input * by dragging a scaler icon at the button of the window */
    NK_WINDOW_CLOSABLE      = NK_FLAG(4), /* adds a closable icon into the header */
    NK_WINDOW_MINIMIZABLE   = NK_FLAG(5), /* adds a minimize icon into the header */
    NK_WINDOW_DYNAMIC       = NK_FLAG(6), /* special window type growing up in height while being filled to a * certain maximum height */
    NK_WINDOW_NO_SCROLLBAR  = NK_FLAG(7), /* Removes the scrollbar from the window */
    NK_WINDOW_TITLE         = NK_FLAG(8) /* Forces a header at the top at the window showing the title */
}

alias nk_font_atlas_format = int;
enum {
    NK_FONT_ATLAS_ALPHA8,
    NK_FONT_ATLAS_RGBA32
}

alias nk_font_coord_type = int;
enum {
    NK_COORD_UV,
    /* texture coordinates inside font glyphs are clamped between 0-1 */
    NK_COORD_PIXEL
    /* texture coordinates inside font glyphs are in absolute pixel */
}

alias nk_style_item_type = int;
enum {
    NK_STYLE_ITEM_COLOR,
    NK_STYLE_ITEM_IMAGE
}

alias nk_style_header_align = int;
enum {
    NK_HEADER_LEFT,
    NK_HEADER_RIGHT
}

alias nk_window_flags = int;
enum {
    NK_WINDOW_PRIVATE       = NK_FLAG(9),
    /* dummy flag which mark the beginning of the private window flag part */
    NK_WINDOW_ROM           = NK_FLAG(10),
    /* sets the window into a read only mode and does not allow input changes */
    NK_WINDOW_HIDDEN        = NK_FLAG(11),
    /* Hides the window and stops any window interaction and drawing can be set
     * by user input or by closing the window */
    NK_WINDOW_MINIMIZED     = NK_FLAG(12),
    /* marks the window as minimized */
    NK_WINDOW_SUB           = NK_FLAG(13),
    /* Marks the window as subwindow of another window*/
    NK_WINDOW_GROUP         = NK_FLAG(14),
    /* Marks the window as window widget group */
    NK_WINDOW_POPUP         = NK_FLAG(15),
    /* Marks the window as a popup window */
    NK_WINDOW_NONBLOCK      = NK_FLAG(16),
    /* Marks the window as a nonblock popup window */
    NK_WINDOW_CONTEXTUAL    = NK_FLAG(17),
    /* Marks the window as a combo box or menu */
    NK_WINDOW_COMBO         = NK_FLAG(18),
    /* Marks the window as a combo box */
    NK_WINDOW_MENU          = NK_FLAG(19),
    /* Marks the window as a menu */
    NK_WINDOW_TOOLTIP       = NK_FLAG(20),
    /* Marks the window as a menu */
    NK_WINDOW_REMOVE_ROM    = NK_FLAG(21)
    /* Removes the read only mode at the end of the window */
}

alias nk_heading = int;
enum {
	NK_UP, NK_RIGHT, NK_DOWN, NK_LEFT
}

alias nk_command_clipping = int;
enum {
    NK_CLIPPING_OFF = nk_false,
    NK_CLIPPING_ON = nk_true
}

alias nk_command_type = int;
enum {
    NK_COMMAND_NOP,
    NK_COMMAND_SCISSOR,
    NK_COMMAND_LINE,
    NK_COMMAND_CURVE,
    NK_COMMAND_RECT,
    NK_COMMAND_RECT_FILLED,
    NK_COMMAND_RECT_MULTI_COLOR,
    NK_COMMAND_CIRCLE,
    NK_COMMAND_CIRCLE_FILLED,
    NK_COMMAND_ARC,
    NK_COMMAND_ARC_FILLED,
    NK_COMMAND_TRIANGLE,
    NK_COMMAND_TRIANGLE_FILLED,
    NK_COMMAND_POLYGON,
    NK_COMMAND_POLYGON_FILLED,
    NK_COMMAND_POLYLINE,
    NK_COMMAND_TEXT,
    NK_COMMAND_IMAGE
}

alias nk_draw_list_stroke = int;
enum {
    NK_STROKE_OPEN = nk_false,
    /* build up path has no connection back to the beginning */
    NK_STROKE_CLOSED = nk_true
    /* build up path has a connection back to the beginning */
}

alias nk_button_behavior = int;
enum {NK_BUTTON_DEFAULT,NK_BUTTON_REPEATER}
alias nk_modify = int;
enum {NK_FIXED=nk_false,NK_MODIFIABLE=nk_true}
alias nk_orientation = int;
enum {NK_VERTICAL,NK_HORIZONTAL}
alias nk_collapse_states = int;
enum {NK_MINIMIZED=nk_false,NK_MAXIMIZED = nk_true}
alias nk_show_states = int;
enum {NK_HIDDEN=nk_false,NK_SHOWN=nk_true}
alias nk_chart_type = int;
enum {NK_CHART_LINES,NK_CHART_COLUMN,NK_CHART_MAX}
alias nk_chart_event = int;
enum {NK_CHART_HOVERING=0x01, NK_CHART_CLICKED=0x02}
alias nk_color_format = int;
enum {NK_RGB, NK_RGBA}
alias nk_popup_type = int;
enum {NK_POPUP_STATIC,NK_POPUP_DYNAMIC}
alias nk_layout_format = int;
enum {NK_DYNAMIC,NK_STATIC}
alias nk_tree_type = int;
enum {NK_TREE_NODE,NK_TREE_TAB}
alias nk_anti_aliasing = int;
enum {NK_ANTI_ALIASING_OFF,NK_ANTI_ALIASING_ON}