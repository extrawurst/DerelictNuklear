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
module derelict.nuklear.funcs;

version = NK_INCLUDE_VERTEX_BUFFER_OUTPUT;
version = NK_INCLUDE_STANDARD_IO;
version = NK_INCLUDE_DEFAULT_FONT;
version = NK_INCLUDE_DEFAULT_ALLOCATOR;

private
{
    import derelict.util.system;
    import derelict.nuklear.types;
    import derelict.nuklear.consts;
}

extern(C) nothrow
{
    version(NK_INCLUDE_DEFAULT_ALLOCATOR)
    alias da_nk_init_default = int function(nk_context*, const(nk_user_font)*);
    alias da_nk_init_fixed = int function(nk_context*, void* memory, nk_size size, const nk_user_font*);
    alias da_nk_init_custom = int function(nk_context*, nk_buffer *cmds, nk_buffer *pool, const(nk_user_font)*);
    alias da_nk_init = int function(nk_context*, nk_allocator*, const(nk_user_font)*);
    alias da_nk_clear = void function(nk_context*);
    alias da_nk_free = void function(nk_context*);
    version(NK_INCLUDE_COMMAND_USERDATA)
    alias da_nk_set_user_data = void function(nk_context*, nk_handle handle);

    alias da_nk_begin = int function(nk_context*, nk_panel*, cstring title, nk_rect bounds, nk_flags flags);
    alias da_nk_end = void function(nk_context*);

    alias da_nk_handle_id = nk_handle function(int);

    version(NK_INCLUDE_DEFAULT_ALLOCATOR)
    alias da_nk_font_atlas_init_default = void function(nk_font_atlas*);
    alias da_nk_font_atlas_init = void function(nk_font_atlas*, nk_allocator*);
    alias da_nk_font_atlas_begin = void function(nk_font_atlas*);
    alias da_nk_font_config = nk_font_config function(float pixel_height); //NOTE: nk_font_config is also a type
    alias da_nk_font_atlas_add = nk_font* function(nk_font_atlas*, const(nk_font_config)*);
    version(NK_INCLUDE_DEFAULT_FONT)
    alias da_nk_font_atlas_add_default = nk_font function(nk_font_atlas*, float height, const(nk_font_config)*);
    alias da_nk_font_atlas_add_from_memory = nk_font function(nk_font_atlas *atlas, void *memory, nk_size size, float height, const nk_font_config *config);
    version(NK_INCLUDE_STANDARD_IO)
    alias da_nk_font_atlas_add_from_file = nk_font* function(nk_font_atlas *atlas, const(char)* file_path, float height, const(nk_font_config)*);
    alias da_nk_font_atlas_add_compressed = nk_font* function(nk_font_atlas*, void *memory, nk_size size, float height, const(nk_font_config)*);
    alias da_nk_font_atlas_add_compressed_base85 = nk_font* function(nk_font_atlas*, const(char)* data, float height, const(nk_font_config)* config);
    alias da_nk_font_atlas_bake = const(void)* function(nk_font_atlas*, int *width, int *height, nk_font_atlas_format);
    alias da_nk_font_atlas_end = void function(nk_font_atlas*, nk_handle tex, nk_draw_null_texture*);
    alias da_nk_font_atlas_clear = void function(nk_font_atlas*);

}

__gshared
{
    version(NK_INCLUDE_DEFAULT_ALLOCATOR)
    da_nk_init_default nk_init_default;
    da_nk_init_fixed nk_init_fixed;
    da_nk_init_custom nk_init_custom;
    da_nk_init nk_init;
    da_nk_clear nk_clear;
    da_nk_free nk_free;
    version(NK_INCLUDE_COMMAND_USERDATA)
    da_nk_set_user_data nk_set_user_data;
    
    da_nk_begin nk_begin;
    da_nk_end nk_end;

    da_nk_handle_id nk_handle_id;

    version(NK_INCLUDE_DEFAULT_ALLOCATOR)
    da_nk_font_atlas_init_default nk_font_atlas_init_default;
    da_nk_font_atlas_init nk_font_atlas_init;
    da_nk_font_atlas_begin nk_font_atlas_begin;
    da_nk_font_config nk_font_config_;
    da_nk_font_atlas_add nk_font_atlas_add;
    version(NK_INCLUDE_DEFAULT_FONT)
    da_nk_font_atlas_add_default nk_font_atlas_add_default;
    da_nk_font_atlas_add_from_memory nk_font_atlas_add_from_memory;
    version(NK_INCLUDE_STANDARD_IO)
    da_nk_font_atlas_add_from_file nk_font_atlas_add_from_file;
    da_nk_font_atlas_add_compressed nk_font_atlas_add_compressed;
    da_nk_font_atlas_add_compressed_base85 nk_font_atlas_add_compressed_base85;
    da_nk_font_atlas_bake nk_font_atlas_bake;
    da_nk_font_atlas_end nk_font_atlas_end;
    da_nk_font_atlas_clear nk_font_atlas_clear;
}
