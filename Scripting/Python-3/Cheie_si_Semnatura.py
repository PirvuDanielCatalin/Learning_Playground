import sys
from datetime import datetime

ARCANE_MAP = {
    1: "Magician",
    2: "Marea Preoteasa",
    3: "Imparateasa",
    4: "Imparatul",
    5: "Hierofantul",
    6: "Indragostitii",
    7: "Carul",
    8: "Justitia",
    9: "Eremitul",
    10: "Roata Norocului",
    11: "Forța",
    12: "Spanzuratul",
    13: "Moartea",
    14: "Temperanta",
    15: "Diavolul",
    16: "Turnul",
    17: "Steaua",
    18: "Luna",
    19: "Soarele",
    20: "Judecata",
    21: "Lumea",
    22: "Nebunul"
}

HEBREW_LETTER_VALUES = {
    'A': 1, 'I': 1, 'Y': 1, 'Q': 1, 'J': 1,
    'B': 2, 'C': 2, 'K': 2, 'R': 2,
    'G': 3, 'L': 3, 'S': 3,
    'D': 4, 'M': 4, 'T': 4,
    'E': 5, 'N': 5,
    'U': 6, 'V': 6, 'W': 6, 'X': 6,
    'O': 7, 'Z': 7,
    'F': 8, 'H': 8, 'P': 8
}

def reduce_to_22_or_less(n):
    while n > 22:
        n = sum(int(digit) for digit in str(n))
    return n

def calculeaza_tranzite(cheie, an_nastere, an_final=2025):
    rezultate = {}
    for an in range(an_nastere, an_final + 1):
        semnatura = cheie + an
        semnatura_rezultata = reduce_to_22_or_less(semnatura)
        rezultate[an] = semnatura_rezultata
    return rezultate

def transforma_nume_ezoteric(nume):
    nume = nume.upper()
    cuvinte = nume.split()
    valori_cuvinte = []
    for cuvant in cuvinte:
        print(f"Cuvant: {cuvant}")
        suma_cuvant = 0
        for idx, litera in enumerate(reversed(cuvant)):
            valoare = HEBREW_LETTER_VALUES.get(litera, 0)
            suma_cuvant += valoare * (idx + 1)
        valori_cuvinte.append(suma_cuvant)
    print(f"Valori cuvinte: {valori_cuvinte}")
    suma_cifre = sum(int(cifra) for valoare in valori_cuvinte for cifra in str(valoare))
    while suma_cifre > 9:
        suma_cifre = sum(int(cifra) for cifra in str(suma_cifre))
    return suma_cifre

if __name__ == "__main__":
    if len(sys.argv) != 5:
        print("Utilizare: python Cheie_si_Semnatura.py <nume_complet> <an_nastere> <numar_zodie> <grad_soare>")
        sys.exit(1)
    nume_complet = sys.argv[1]
    an_nastere = int(sys.argv[2])
    numar_zodie = int(sys.argv[3])
    grad_soare = int(sys.argv[4])
    cheie_ezoterica = transforma_nume_ezoteric(nume_complet)
    cheie = cheie_ezoterica + numar_zodie + grad_soare
    cheie = reduce_to_22_or_less(cheie)

    print("--- Parametri primiți ---")
    print(f"Nume complet: {nume_complet}")
    print(f"An naștere: {an_nastere}")
    print(f"Număr zodie: {numar_zodie}")
    print(f"Grad Soare: {grad_soare}")
    print(f"Cheie ezoterică (din nume): {cheie_ezoterica}")
    print(f"Cheie finală (max 22): {cheie}")
    rezultate = calculeaza_tranzite(cheie, an_nastere)
    semnatura = next(iter(rezultate.values()))
    print(f"Semnătură (primul an): {semnatura}")
    print("\n--- Tranzite ---")
    for an, semnatura in rezultate.items():
        marker = ""
        if semnatura == cheie:
            marker += " [cheie]"
        if semnatura == next(iter(rezultate.values())):
            marker += " [semnatura]"
        print(f"Anul {an}: Tranzite {ARCANE_MAP.get(semnatura)}{marker}")