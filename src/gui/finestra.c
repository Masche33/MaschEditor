#include <X11/Xlib.h>
#include <stdio.h>

int main() {
    Display *display;
    Window window;
    XEvent event;

    display = XOpenDisplay(NULL);
    if (display == NULL) {
        printf("Unable to open X display\n");
        return 1;
    }

    window = XCreateSimpleWindow(display, DefaultRootWindow(display), 10, 10, 400, 400, 1, BlackPixel(display, 0), WhitePixel(display, 0));
    XMapWindow(display, window);
    XStoreName(display, window, "Finestra 400x400");

    while (1) {
        XNextEvent(display, &event);
        if (event.type == ClientMessage) {
            break;
        }
    }

    XDestroyWindow(display, window);
    XCloseDisplay(display);
    return 0;
}

