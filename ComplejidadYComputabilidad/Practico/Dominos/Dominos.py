

class Dominos:
    def __init__(self, listDominos, solution):
        self.listDominos = list(listDominos)
        self.solution = list(solution)
        

    def DominosDecidible(self):
        parteArriba = ""
        parteAbajo = ""
        for currentDomino in self.solution:
            if currentDomino in self.listDominos:
                a, b = currentDomino
                parteArriba = parteArriba + a
                parteAbajo = parteAbajo + b
            else:
                return False

        if parteArriba == parteAbajo:
            return True
        else:
            return False


listDominos = [("ab", "abab"), ("b", "a"), ("aba", "b"), ("aa", "a")]
solution = [("ab", "abab"), ("ab", "abab"), ("aba", "b"), ("b", "a"), ("b", "a"),("aa", "a"),("aa", "a")]

dominos_instance = Dominos(listDominos, solution)

print(dominos_instance.DominosDecidible())