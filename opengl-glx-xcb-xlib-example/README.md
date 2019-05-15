# glx example

```
sudo apt-get install freeglut3-dev xorg-dev libglu1-mesa-dev
```


```
gcc -o opengl-example ./main.c  -lGL -lGLU -lglut -lX11 -lxcb -lX11-xcb
./opengl-example
```
