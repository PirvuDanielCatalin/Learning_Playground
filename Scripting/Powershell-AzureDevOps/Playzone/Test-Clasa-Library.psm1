class Test {
    [String]$Nume
    [String]$Prenume

    Test() { }
    Test([String]$Nume, [String]$Prenume) {
        $this.Nume = $Nume
        $this.Prenume = $Prenume
    }

    [String] GetNume() {
        return $this.Nume
    }

    [void] SetNume([String]$Nume) {
        $this.Nume = $Nume
    }

    [String] GetPrenume() {
        return $this.Prenume
    }

    [void] SetPrenume([String]$Prenume) {
        $this.Prenume = $Prenume
    }

    [string] ToString() {
        return "Nume: {0} ; Prenume: {1}" -f $this.Nume, $this.Prenume
    }
}