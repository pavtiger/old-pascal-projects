import pygame
import sys
import time

GRAPHICS_QUALITY = 'LOW'
BLACK = (0, 0, 0)
PINK = (226, 11, 78)
YELLOW = (249, 190, 38)


class RNG(object):
    def init():
        pygame.init()
        pygame.display.set_caption('RNG Programm')

    def input():
        global n_points
        n_points = 0
        while True:
            for i in pygame.event.get():
                if i.type == pygame.QUIT:
                    sys.exit()

                elif i.type == pygame.MOUSEBUTTONDOWN:
                    pos = pygame.mouse.get_pos()
                    n_points += 1
                    if GRAPHICS_QUALITY == 'HIGH':
                        for i in range(12): 
                            position = (pos[0]-i*0.4, pos[1]-i*0.4, i, i)
                            pygame.draw.rect(screen, PINK, position)
                            pygame.draw.rect(screen, YELLOW, position, 3)
                            pygame.display.update()
                            time.sleep(0.04)
                            
                    elif GRAPHICS_QUALITY == 'LOW':
                        pygame.draw.rect(screen, BLACK, (pos[0], pos[1], 4, 4))
                        pygame.display.update()

                    if n_points > 2:
                        add = []
                        for i in range(len(points)):
                            points[i].append(0)
                            add.append(0)
                        add.append(0)
                        points.append(add)
                    print('Ready')

if __name__ == "__main__":
    points = [[0, 0], [0, 0]]
    size = (600, 400)

    pygame.init()
    pygame.display.set_caption('RNG Programm')
    screen = pygame.display.set_mode(size)
    cl = (220, 220, 220)
    screen.fill(cl)
    pygame.display.update()

    RNG.init()
    RNG.input()
