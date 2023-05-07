Using module ".\TestClasa.psm1"

$Marius = New-Object Test
$Marius.GetNume()
$Marius.GetPrenume()

$Marius.SetNume("Mirica")
$Marius.SetPrenume("FaraFrica")

$Marius.GetNume()
$Marius.GetPrenume()

$Dani = New-Object Test  -ArgumentList "Pirvu", "Daniel"
$Dani.ToString()

$Cristi = [Test]::new("Cristi", "Mexicanul")
$Cristi.ToString()

