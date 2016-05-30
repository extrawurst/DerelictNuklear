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
module derelict.nuklear.nuklear;

version = NK_INCLUDE_VERTEX_BUFFER_OUTPUT;
version = NK_INCLUDE_STANDARD_IO;
version = NK_INCLUDE_DEFAULT_FONT;
version = NK_INCLUDE_DEFAULT_ALLOCATOR;

public
{
    import derelict.nuklear.types;
    import derelict.nuklear.funcs;
    import derelict.nuklear.consts;
}

private
{
    import derelict.util.loader;
    import derelict.util.system;

    static if(Derelict_OS_Windows)
        enum libNames = "libnuklear.dll";    
    else static if (Derelict_OS_Mac)
        enum libNames = "libnuklear.dylib";
    else static if (Derelict_OS_Linux)
        enum libNames = "libnuklear.so";
    else
        static assert(0, "Need to implement nuklear libNames for this operating system.");
}

class DerelictNuklearLoader : SharedLibLoader
{

    protected
    {
        override void loadSymbols()
        {          
            version(NK_INCLUDE_DEFAULT_ALLOCATOR)
            bindFunc(cast(void**)&nk_init_default, "nk_init_default");
            bindFunc(cast(void**)&nk_init_fixed, "nk_init_fixed");
            bindFunc(cast(void**)&nk_init_custom, "nk_init_custom");
            bindFunc(cast(void**)&nk_init, "nk_init");
            bindFunc(cast(void**)&nk_clear, "nk_clear");
            bindFunc(cast(void**)&nk_free, "nk_free");
            version(NK_INCLUDE_COMMAND_USERDATA)
            bindFunc(cast(void**)&nk_set_user_data, "nk_set_user_data");

            bindFunc(cast(void**)&nk_begin, "nk_begin");
            bindFunc(cast(void**)&nk_end, "nk_end");

            bindFunc(cast(void**)&nk_handle_id, "nk_handle_id");

            bindFunc(cast(void**)&nk_button_text, "nk_button_text");
            bindFunc(cast(void**)&nk_button_label, "nk_button_label");
            bindFunc(cast(void**)&nk_button_color, "nk_button_color");
            bindFunc(cast(void**)&nk_button_symbol, "nk_button_symbol");
            bindFunc(cast(void**)&nk_button_image, "nk_button_image");
            bindFunc(cast(void**)&nk_button_symbol_label, "nk_button_symbol_label");
            bindFunc(cast(void**)&nk_button_symbol_text, "nk_button_symbol_text");
            bindFunc(cast(void**)&nk_button_image_label, "nk_button_image_label");
            bindFunc(cast(void**)&nk_button_image_text, "nk_button_image_text");

            version(NK_INCLUDE_DEFAULT_ALLOCATOR)
            bindFunc(cast(void**)&nk_font_atlas_init_default, "nk_font_atlas_init_default");
            bindFunc(cast(void**)&nk_font_atlas_init, "nk_font_atlas_init");
            bindFunc(cast(void**)&nk_font_atlas_begin, "nk_font_atlas_begin");
            bindFunc(cast(void**)&nk_font_config_, "nk_font_config");
            bindFunc(cast(void**)&nk_font_atlas_add, "nk_font_atlas_add");
            version(NK_INCLUDE_DEFAULT_FONT)
            bindFunc(cast(void**)&nk_font_atlas_add_default, "nk_font_atlas_add_default");
            bindFunc(cast(void**)&nk_font_atlas_add_from_memory, "nk_font_atlas_add_from_memory");
            version(NK_INCLUDE_STANDARD_IO)
            bindFunc(cast(void**)&nk_font_atlas_add_from_file, "nk_font_atlas_add_from_file");
            bindFunc(cast(void**)&nk_font_atlas_add_compressed, "nk_font_atlas_add_compressed");
            bindFunc(cast(void**)&nk_font_atlas_add_compressed_base85, "nk_font_atlas_add_compressed_base85");
            bindFunc(cast(void**)&nk_font_atlas_bake, "nk_font_atlas_bake");
            bindFunc(cast(void**)&nk_font_atlas_end, "nk_font_atlas_end");
            bindFunc(cast(void**)&nk_font_atlas_clear, "nk_font_atlas_clear");
        }
    }

    public
    {
        this()
        {
            super(libNames);
        }
    }
}

__gshared DerelictNuklearLoader DerelictNuklear;

shared static this()
{
    DerelictNuklear = new DerelictNuklearLoader();
}
