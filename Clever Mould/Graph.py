import pygame
import sys


class RNG(object):
    def init():
        pygame.init()
        pygame.display.set_caption('RNG Programm')

    def input():
        while True:
            for i in pygame.event.get():
                if i.type == pygame.QUIT:
                    sys.exit()

                elif i.type == pygame.MOUSEBUTTONDOWN:
                    pos = pygame.mouse.get_pos()
                    pygame.draw.rect(screen, (226, 11, 78), (pos[0], pos[1], 10, 10))
                    pygame.draw.rect(screen, (249, 190, 38), (pos[0], pos[1], 10, 10), 3)
                    pygame.display.update()
                    if len(points) > 2:
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
    cl = (255, 255, 255) 
    screen.fill(cl) 
    pygame.display.update()

    RNG.init()
    RNG.input()
