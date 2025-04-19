from enum import Enum


class Movimiento(Enum):
    LEFT = 1
    RIGHT = 2


class Maquina:
    def __init__(self, cintaInit, stateInit, qA, qF, reglas):
        self.cinta = list(cintaInit)
        self.state = stateInit
        self.qA = qA
        self.qF = qF
        self.reglas = reglas
        self.head = 0


# Funcion (estado_actual, simbolo_leido) => (estado_al_pasar, simbolo_escrito left_o_right)
    def turing(self): 
        while (self.state != self.qA and self.state != self.qF):
            if self.head < len(self.cinta):
                current_simbol = self.cinta[self.head]
            else: 
                current_simbol = '_'

            if (self.state, current_simbol) in self.reglas:
                new_state, new_symbol, new_dir = self.reglas[(self.state, current_simbol)]
                self.cinta[self.head] = new_symbol
                self.state = new_state

                if (new_dir == 'RIGHT'):
                    self.head += 1
                    if self.head == len(self.cinta):
                        self.cinta.append('_')
                else:

                    self.head = max(0, self.head - 1)

            else:
                print("No matcheo con ninguna regla, la maquina se detiene.")
                self.state = self.qF
                break

        if self.state == self.qA:
            print("  La cadena es valida.")
        else:
            print("La cadena es invalida.")

        print("Cinta final:", "".join(self.cinta))
        print("Estado final:", self.state)


## EJEMPLOS PERRO
lista = ["H","O","L","A"]
stateInit = 'q0'
stateAccept = 'q_accept'
stateReject = 'q_reject'



reglas = {('q0','H'):('q1', 'C', 'RIGHT'), 
         ('q1','O'):('q2', 'H', 'RIGHT'), 
         ('q2','L'):('q3', 'A', 'RIGHT'),
         ('q3','A'):('q_accept', 'U', 'RIGHT')
        }

maquina = Maquina(lista, stateInit, stateAccept, stateReject, reglas)
maquina.turing()



## EStas reglas son para que se copie la cadena de un lado, con la del otro, en caso de tener "_______"
reglas = {
    ('q0', '0'): ('q1', 'X', 'RIGHT'),
    ('q0', '1'): ('q2', 'X', 'RIGHT'),
    ('q0', '#'): ('q_accept', '#', 'RIGHT'),

    ('q1', '0'): ('q1', '0', 'RIGHT'),
    ('q1', '1'): ('q1', '1', 'RIGHT'),
    ('q1', '#'): ('q1', '#', 'RIGHT'),
    ('q1', '_'): ('q4', '0', 'LEFT'),


    ('q2', '0'): ('q2', '0', 'RIGHT'),
    ('q2', '1'): ('q2', '1', 'RIGHT'),
    ('q2', '#'): ('q2', '#', 'RIGHT'),
    ('q2', '_'): ('q5', '1', 'LEFT'),

    ('q4', '0'): ('q4', '0', 'LEFT'),
    ('q4', '1'): ('q4', '1', 'LEFT'),
    ('q4', '#'): ('q4', '#', 'LEFT'),
    ('q4', 'X'): ('q0', '0', 'RIGHT'),

    ('q5', '1'): ('q5', '1', 'LEFT'),
    ('q5', '0'): ('q5', '0', 'LEFT'),
    ('q5', '#'): ('q5', '#', 'LEFT'),
    ('q5', 'X'): ('q0', '1', 'RIGHT'),
}


lista = list("1111000#_____")
state_init = 'q0'
state_accept = 'q_accept'
state_reject = 'q_reject'

maquina = Maquina(lista, state_init, state_accept, state_reject, reglas)
maquina.turing()
