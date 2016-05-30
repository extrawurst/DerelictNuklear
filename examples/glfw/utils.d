module utils;

import derelict.glfw3.glfw3;

auto initGlfw(int width, int height)
{
	//glfwSetErrorCallback(&error_callback);
	if (!glfwInit())
		return null;
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, true);
	auto window = glfwCreateWindow(width, height, "ImGui OpenGL3 example", null, null);
	glfwMakeContextCurrent(window);
	glfwInit();

	return window;
}