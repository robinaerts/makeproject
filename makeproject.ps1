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
    $projectNameInp = read-host "Project name"
    $projectName = ($projectNameInp -replace " ", "").ToLower()

    Clear-Host

    switch ($project) {
        0 { createBasicProject $projectName }
        1 { createNextProject $projectName "ts" }
        2 { createNextProject $projectName "js" }
        3 { createReactProject $projectName "js" }
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

function createNextProject {
    param($projectName, $language)
    write-host "Creating NextJS project..."
    try {
        npx create-next-app $projectName --$language
    }
    catch {
        write-host "Something went wrong, please try again"
        createProject
    }
    Clear-Host
    additionalNPM

    Set-Location $projectName
    write-host "Done! Starting VS Code..."
    code .
}

function createReactProject {
    param($projectName, $language)
    write-host "Creating ReactJS project..."
    try {
        npx create-react-app $projectName --$language
    }
    catch {
        write-host "Something went wrong, please try again"
        createProject
    }
    Clear-Host
    additionalNPM

    Set-Location $projectName
    write-host "Done! Starting VS Code..."
    code .
}

function createThreeProject {
    
}

function createExpressProject {
    param($projectName)
    write-host "Creating Express project..."
    try {
        npx express-generator $projectName
    }
    catch {
        write-host "Something went wrong, please try again"
        createProject
    }
    Clear-Host
    additionalNPM

    Set-Location $projectName
    write-host "Done! Starting VS Code..."
    code .
}

function createElectronProject {
    param($projectName)
    write-host "Creating Electron project..."
    try {
        npx create-electron-app $projectName
    }
    catch {
        write-host "Something went wrong, please try again"
        createProject
    }
    Clear-Host
    additionalNPM

    Set-Location $projectName
    write-host "Done! Starting VS Code..."
    code .
}

function createCSharpProject {
    param($projectName)
    write-host "Creating C# project..."
    try {
        dotnet new console -o $projectName
    }
    catch {
        write-host "Something went wrong, please try again"
        createProject
    }
    Clear-Host
    write-host "Done! Starting VS Code..."
    code $projectName
}

function createCPlusPlusProject {
    param($projectName)
    write-host "Creating C++ project..."
    try {
        mkdir $projectName
        Set-Location $projectName
        mkdir src
        Set-Location src
        New-Item -ItemType File -Path . -Name "main.cpp"
        Set-Location ..
        New-Item -ItemType File -Path . -Name "CMakeLists.txt"
        New-Item -ItemType File -Path . -Name "README.md"
    }
    catch {
        write-host "Something went wrong, please try again"
        createProject
    }
    Clear-Host
    write-host "Done! Starting VS Code..."
    code .
}

function createPythonProject {
    param($projectName)
    write-host "Creating Python project..."
    try {
        mkdir $projectName
        Set-Location $projectName
        New-Item -ItemType File -Path . -Name "main.py"
    }
    catch {
        write-host "Something went wrong, please try again"
        createProject
    }
    Clear-Host
    write-host "Done! Starting VS Code..."
    code .
}

function createReactNativeProject {
    param($projectName)
    write-host "Creating React Native project..."
    try {
        npx react-native init $projectName
    }
    catch {
        write-host "Something went wrong, please try again"
        createProject
    }
    Clear-Host
    additionalNPM

    Set-Location $projectName
    write-host "Done! Starting VS Code..."
    code .
}

function createFlutterProject {
    param($projectName)
    write-host "Creating Flutter project..."
    try {
        flutter create $projectName
    }
    catch {
        write-host "Something went wrong, please try again"
        createProject
    }
    Clear-Host
    write-host "Done! Starting VS Code..."
    code $projectName
}

function additionalNPM {
    param($projectName)
    write-host "Do you want to install additional NPM packages? (y/N)"
    $inp = read-host
    if ($inp -eq "y") {
        write-host "What packages do you want to install? (separate with space)"
        $packages = read-host
        
        npm install $packages.Replace('"', "")
    }
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
    if ($choice -in 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11) {
        return $choice
    }
    else {
        write-host "Please select a valid option"
        chooseProject
    }
}

main

PAUSE