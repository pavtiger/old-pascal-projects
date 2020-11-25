import pygame
import sys
import time
from math import sqrt
from random import random, randint

GRAPHICS_QUALITY = 'LOW'
DEBUG = False
MODE = 'RNG'

BLACK = (0, 0, 0)
MYBLACK = (33, 38, 44)
PINK = (226, 11, 78)
YELLOW = (249, 190, 38)


class Graph(object):
    def __init__(self):
        pass

    def check(p1, p2, cp):
        if MODE == 'RNG':
            x1 = coord[p1][0]
            y1 = coord[p1][1]
            x2 = coord[p2][0]
            y2 = coord[p2][1]
            x = coord[cp][0]
            y = coord[cp][1]
            r = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))

            if DEBUG == True:
                pygame.draw.circle(screen, (p1*50, p1*50, 0), (x1, y1), int(r), 2)
                pygame.draw.circle(screen, (p2*50, p2*50, 0), (x2, y2), int(r), 2)

            if r*r >= (x-x1)*(x-x1)+(y-y1)*(y-y1) and r*r >= (x-x2)*(x-x2)+(y-y2)*(y-y2):
                if n_points == 2:
                    return True # No point inside
                else:
                    return False # Point inside
            else:
                return True # No point inside
        elif MODE == 'GG':
            x1 = coord[p1][0]
            y1 = coord[p1][1]
            x2 = coord[p2][0]
            y2 = coord[p2][1]
            x = coord[cp][0]
            y = coord[cp][1]
            r = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
            cx = int((x1+x2)/2)
            cy = int((y1+y2)/2)

            if DEBUG == True:
                pygame.draw.circle(screen, (p1*50, p1*50, 0), (cx, cy), int(r/2), 2)

            if r/2 >= sqrt((x-cx)*(x-cx)+(y-cy)*(y-cy)):
                if n_points == 2:
                    return True # No point inside
                else:
                    return False # Point inside
            else:
                return True # No point inside

    def line_draw():
        test = True
        for a in range(n_points):
            for b in range(n_points):
                if a != b: ##
                    test = True
                    for i in range(n_points):
                        if i != a and i != b or n_points == 2:
                            if Graph.check(a, b, i) == False:
                                test = False
                    if test == True:
                        x1 = coord[a][0]
                        y1 = coord[a][1]
                        x2 = coord[b][0]
                        y2 = coord[b][1]

                        pygame.draw.aaline(screen, MYBLACK, [x1, y1], [x2, y2])
                        pygame.display.update()
    

    def circle_output():
        for element in coord:
            Graph.circle((element[0], element[1]), False)



    def circle(pos, effects):
        if GRAPHICS_QUALITY == 'HIGH':
            if effects == True:
                for i in range(12):
                    position = (pos[0]-i*0.4, pos[1]-i*0.4, i, i)
                    pygame.draw.rect(screen, PINK, position)
                    pygame.draw.rect(screen, YELLOW, position, 3)
                    pygame.display.update()
                    time.sleep(0.03)
            else:
                position = (pos[0]-12*0.4, pos[1]-12*0.4, 12, 12)
                pygame.draw.rect(screen, PINK, position)
                pygame.draw.rect(screen, YELLOW, position, 3)
                pygame.display.update()
        elif GRAPHICS_QUALITY == 'LOW':
            pygame.draw.rect(screen, BLACK, (pos[0], pos[1], 4, 4))
            pygame.display.update()

    def input(N):
        for i in pygame.event.get():
            if i.type == pygame.QUIT:
                sys.exit()
        pos = (startX - randint(-200, 200), startX - randint(-200, 200))
        return N

if __name__ == "__main__":
    points = [[0, 0], [0, 0]]
    size = (600, 400)

    pygame.init()
    pygame.display.set_caption('Graph Programm')
    screen = pygame.display.set_mode(size)
    cl = (220, 220, 220)
    screen.fill(cl)
    pygame.display.update()

    global n_points, coord, smallest, startX, startY
    startX, startY, n_points, last_n, smallest = 0, 0, 0, 0, 0
    coord = []

    startX = 500
    startY = 300

    while True:
        n_points = Graph.input(n_points)
        if n_points != last_n:
            Graph.line_draw()
            Graph.circle_output()
            screen.fill(cl)
        last_n = n_points
