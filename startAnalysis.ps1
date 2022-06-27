function Open-File([string] $initialDirectory){

    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "All files (*.*)| *.*"
    $OpenFileDialog.ShowDialog() |  Out-Null

    return $OpenFileDialog.filename
} 
$scriptPath = Get-Location
$OpenFile=Open-File $scriptPath

if ($OpenFile -ne "") 
{
    & Start-Process java -ArgumentList 'org.antlr.v4.Tool', './HTMLLexer.g4' -Wait
    & Start-Process java -ArgumentList 'org.antlr.v4.Tool', './HTMLParser.g4'   -Wait
    & Start-Process javac -ArgumentList 'HTML*.java'  -Wait
    & Start-Process grun -ArgumentList 'HTML ','htmlDocument', $OpenFile, '-gui'
} 
else 
{
    echo "No File was chosen"
}



