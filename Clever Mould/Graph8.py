import pygame
import sys
import time
from math import sqrt

DEBUG = False
MODE = 'RNG'

BLACK = (0, 0, 0)
MYBLACK = (33, 38, 44)
PINK = (226, 11, 78)
YELLOW = (249, 190, 38)


class Graph(object):
    def init():
        pygame.init()
        pygame.display.set_caption('RNG/GG Programm')

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
                return False # Point inside
            else:
                return True # No point inside
        elif MODE == 'GG':
            print('Hello')

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

    def input(N):
        for i in pygame.event.get():
            if i.type == pygame.QUIT:
                sys.exit()

            elif i.type == pygame.MOUSEBUTTONDOWN:
                pos = pygame.mouse.get_pos()
                if i.button == 1:
                    N += 1
                    coord.append(pos)
                    Graph.circle(pos, True)
                else:
                    smallest = 10000000
                    for i in coord:
                        x1 = i[0]
                        y1 = i[1]
                        x2 = pos[0]
                        y2 = pos[1]

                        number = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
                        if number < smallest:
                            smallest = number
                            x = x1
                            y = x2
                    pygame.draw.circle(screen, (50, 50, 0), (x, y), int(100), 2)
                    pygame.display.update()
                    cr = True
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

    Graph.init()

    global n_points, coord, smallest, cr
    smallest, cr, n_points = 0, 0, 0
    coord = []
    last_n = 0

    while True:
        n_points = Graph.input(n_points)
        if n_points != last_n or cr == True:
            cr = False
            Graph.line_draw()
            Graph.circle_output()
            screen.fill(cl)
        last_n = n_points
