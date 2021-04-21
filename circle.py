#!/usr/bin/python
import turtle
import sys
from math import pi


def draw_circle(size: int) -> None:
    # make it a little bit prettier by setting a color and hiding the turtle
    turtle.color('green')
    turtle.speed(0)
    turtle.hideturtle()

    # center the circle by offsetting the y-position based on the radius
    turtle.penup()
    turtle.goto(turtle.xcor(), turtle.ycor() + size)
    turtle.pendown()

    # calculation of the step_size is based on the explanation in this
    # stackoverflow post: https://stackoverflow.com/a/64649012
    circle_circumference = 2 * pi * radius
    step_size = circle_circumference / 360.0

    # draw a filled circle
    turtle.begin_fill()
    for i in range(360):
        turtle.forward(step_size)
        turtle.right(1.0)

    turtle.end_fill()
    turtle.done()
    # turtle.mainloop()


if __name__ == "__main__":
    if len(sys.argv) > 1:
        radius = int(sys.argv[1])
        draw_circle(radius)
    else:
        print("No radius was given! Please provide it as a parameter!")
