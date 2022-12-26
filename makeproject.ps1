Clear-Host

write-host ""
write-host "  RRRRRRRRRRRRRRRRR        OOOOOOOOO     BBBBBBBBBBBBBBBBB   YYYYYYY       YYYYYYYTTTTTTTTTTTTTTTTTTTTTTTEEEEEEEEEEEEEEEEEEEEEE "
write-host "  R::::::::::::::::R     OO:::::::::OO   B::::::::::::::::B  Y:::::Y       Y:::::YT:::::::::::::::::::::TE::::::::::::::::::::E "
write-host "  R::::::RRRRRR:::::R  OO:::::::::::::OO B::::::BBBBBB:::::B Y:::::Y       Y:::::YT:::::::::::::::::::::TE::::::::::::::::::::E "
write-host "  RR:::::R     R:::::RO:::::::OOO:::::::OBB:::::B     B:::::BY::::::Y     Y::::::YT:::::TT:::::::TT:::::TEE::::::EEEEEEEEE::::E "
write-host "    R::::R     R:::::RO::::::O   O::::::O  B::::B     B:::::BYYY:::::Y   Y:::::YYYTTTTTT  T:::::T  TTTTTT  E:::::E       EEEEEE "
write-host "    R::::R     R:::::RO:::::O     O:::::O  B::::B     B:::::B   Y:::::Y Y:::::Y           T:::::T          E:::::E              "
write-host "    R::::RRRRRR:::::R O:::::O     O:::::O  B::::BBBBBB:::::B     Y:::::Y:::::Y            T:::::T          E::::::EEEEEEEEEE    "
write-host "    R:::::::::::::RR  O:::::O     O:::::O  B:::::::::::::BB       Y:::::::::Y             T:::::T          E:::::::::::::::E    "
write-host "    R::::RRRRRR:::::R O:::::O     O:::::O  B::::BBBBBB:::::B       Y:::::::Y              T:::::T          E:::::::::::::::E    "
write-host "    R::::R     R:::::RO:::::O     O:::::O  B::::B     B:::::B       Y:::::Y               T:::::T          E::::::EEEEEEEEEE    "
write-host "    R::::R     R:::::RO:::::O     O:::::O  B::::B     B:::::B       Y:::::Y               T:::::T          E:::::E              "
write-host "    R::::R     R:::::RO::::::O   O::::::O  B::::B     B:::::B       Y:::::Y               T:::::T          E:::::E       EEEEEE "
write-host "  RR:::::R     R:::::RO:::::::OOO:::::::OBB:::::BBBBBB::::::B       Y:::::Y             TT:::::::TT      EE::::::EEEEEEEE:::::E "
write-host "  R::::::R     R:::::R OO:::::::::::::OO B:::::::::::::::::B     YYYY:::::YYYY          T:::::::::T      E::::::::::::::::::::E "
write-host "  R::::::R     R:::::R   OO:::::::::OO   B::::::::::::::::B      Y:::::::::::Y          T:::::::::T      E::::::::::::::::::::E "
write-host "  RRRRRRRR     RRRRRRR     OOOOOOOOO     BBBBBBBBBBBBBBBBB       YYYYYYYYYYYYY          TTTTTTTTTTT      EEEEEEEEEEEEEEEEEEEEEE "


write-host ""
write-host ""
write-host "----------------------------------------------------- MAKE NEW PROJECT SCRIPT ------------------------------------------------- "
write-host ""
write-host "	Creator: 		Robin Aerts "
write-host ""
write-host "	More Info:		https://robyte.me/scripts/makeproject "
write-host ""
write-host "	Version: 		0.0.1"
write-host ""
write-host "	Last updated: 		23 December 2022 "
write-host ""
write-host "------------------------------------------------------------------------------------------------------------------------------- "
write-host ""
write-host ""

write-host "Select what you want to do:"
write-host ""
write-host "[1] Create a new project"
write-host "[2] Open a project"
write-host "[3] Open in GUI"

function main {
    $choice = ChooseTask
    switch ($choice) {
        1 { createProject }
        2 { write-host "You selected 2" }
        3 { write-host "You selected 3" }
    }
}

function ChooseTask {
    $choice = read-host "Choice"
    if ($choice -in 1, 2, 3) {
        return $choice
    }
    else {
        write-host "Please select a valid option"
        ChooseTask
    }
}

function createProject {
    $path = askPath
    $project = chooseProject
    $projectName = read-host "Project name" -replace " ", ""

    switch ($project) {
        0 { createBasicProject $projectName }
        1 { createNextProject $projectName }
        2 { createNextProject $projectName }
        3 { createReactProject $projectName }
        4 { createThreeProject $projectName }
        5 { createExpressProject $projectName }
        6 { createElectronProject $projectName }
        7 { createCSharpProject $projectName }
        8 { createCPlusPlusProject $projectName }
        9 { createPythonProject $projectName }
        10 { createReactNativeProject $projectName }
        11 { createFlutterProject $projectName }
    }
}

function createBasicProject {
    param($projectName)
    write-host "Creating basic project..."
    $null = New-Item -ItemType Directory -Path . -Name "$projectName"
    Set-Location $projectName
    $null = New-Item -ItemType File -Path . -Name "style.css"
    $null = New-Item -ItemType File -Path . -Name "index.html"
    $null = New-Item -ItemType File -Path . -Name "app.js"
    write-host "Done! Starting VS Code..."
    code .
}

function askPath {
    Clear-Host 
    write-host "Where do you want to create the project?"
    $path = read-host "Path ($pwd)"   

    try { Set-location $path } 
    catch { createProject }

    return $path
}

function chooseProject {
    clear-host
    write-host "What project do you want to create?"
    write-host ""
    write-host "WEB:"
    write-host "[0] Basic (HTML, CSS, JS))"
    write-host "[1] NextJS (TS)"
    write-host "[2] NextJS (JS)"
    write-host "[3] ReactJS (JS)"
    write-host "[4] ThreeJS (JS)"
    write-host "[5] Express"
    write-host ""
    write-host "DESKTOP:"
    write-host "[6] ElectronJS"
    write-host "[7] C#"
    write-host "[8] C++"
    write-host "[9] Python"
    write-host ""
    write-host "MOBILE:"
    write-host "[10] React Native"
    write-host "[11] Flutter"

    $choice = read-host "Choice"
    if ($choice -in 0...11) {
        return $choice
    }
    else {
        write-host "Please select a valid option"
        chooseProject
    }
}

main

PAUSE