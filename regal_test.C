#ifdef __EMSCRIPTEN__
#include <GL/Regal.h> 
#include <emscripten.h>
#include <emscripten/html5.h>
#endif



#include <GL/gl.h>
#include <stdio.h>

int main() {
    emscripten_set_canvas_element_size("#canvas", 599, 599);
    EmscriptenWebGLContextAttributes attr;
    emscripten_webgl_init_context_attributes(&attr);
    attr.alpha = attr.depth = attr.stencil = attr.antialias = 
    attr.preserveDrawingBuffer = attr.failIfMajorPerformanceCaveat = 0;
    attr.enableExtensionsByDefault = 1;
    attr.premultipliedAlpha = 0;
    attr.majorVersion = 1;
    attr.minorVersion = 0;
    EMSCRIPTEN_WEBGL_CONTEXT_HANDLE ctx = emscripten_webgl_create_context("#canvas", &attr);
    emscripten_webgl_make_context_current(ctx);
    RegalMakeCurrent((RegalSystemContext)1);

    glClearColor(0,0,42,1);

    glBegin(GL_TRIANGLES);
    glVertex2f(-0.5f,-0.5f);
    glVertex2f(0.0f,0.5f);
    glVertex2f(0.5f, -0.5f);
    glEnd();
    printf("hmm\n");
}