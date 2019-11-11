####### MODULO DE GIT #######

Set-Alias funcionesGit gitFunctions

Function comitear{
    <#
    .SYNOPSIS
     Comitea y pushea powershell repo
    
    .DESCRIPTION 
      Hace un commit del repositorio de powershell y despues hace el push
    
    .EXAMPLE 
      comitear "Mensaje a enviar"
     
    #> 

    PARAM ([Parameter(`
            Mandatory=$true)]
            $mensaje,
            $branch="master")

    $rutaActual = $pwd
    $repo = ([system.io.fileinfo]$profile).DirectoryName

    cd $repo
    git add .
    git commit -m $mensaje
    git push origin $branch

    cd $rutaActual
}

Function gitFunctions 
{
    Write-Host "  git config --global user.email sam@google.com";
    Write-Host "  git init";
    Write-Host "  git add .";
    Write-Host "  git clone http://repoexample";
    Write-Host "  git commit –m \"Message\"";
    Write-Host "  git status";
    Write-Host "  git push  origin master";
    Write-Host "  git pull";
    Write-Host "  git checkout -b <banch-name>";
    Write-Host "  git checkout <branch-name>";
    Write-Host "  git remote -v";
    Write-Host "  git remote add origin <93.188.160.58>";
    Write-Host "  git branch";
    Write-Host "  git branch -d <branch-name>";
    Write-Host "  git merge <branch-name>";
    Write-Host "  git diff --base <file-name>";
    Write-Host "  git diff";
    Write-Host "  git diff <source-branch> <target-branch>";
    Write-Host "  git tag 1.1.0 <instert-commitID-here>";
    Write-Host "  git log";
    Write-Host "  git reset - -hard HEAD";
    Write-Host "  git rm filename.txt";
    Write-Host "  git stash";
    Write-Host "  git show";
    Write-Host "  git fetch origin";
    Write-Host "  git ls-tree HEAD";
    Write-Host "  git cat-file –p d670460b4b4aece5915caf5c68d12f560a9fe3e4";
    Write-Host "  git grep \"www.tupaginaweb.com\" ";
    Write-Host "  gitk";
    Write-Host "  git instaweb –http=webrick";
  
    Write-Host "  git fsck";

    Write-Host "  CUIDADO" -foregroundcolor "Red";
    Write-Host "  --------" -foregroundcolor "Red";
    Write-Host "  git gc";
    Write-Host "  git archive – -format=tar master";
    Write-Host "  git prune";
    Write-Host "  git rebase";

    Write-Host "  https://elbauldelprogramador.com/mini-tutorial-y-chuleta-de-comandos-git/";
}

Function gitExp 
{
    Write-Host "  git branch -d <branch-name>";
    Write-Host "  Borrar rama"-foregroundcolor "Green";

    Write-Host "  git log";
    Write-Host "  Lista de commits en una rama junto con todos los detalles"-foregroundcolor "Green";

    Write-Host "  git stash";
    Write-Host "  Salvar cambios temporalmente"-foregroundcolor "Green";

    Write-Host "  git show";
    Write-Host "  Se usa para mostrar información sobre cualquier objeto git"-foregroundcolor "Green";
   
    Write-Host "  gitk";
    Write-Host "  Interfaz gráfica para un repositorio local"-foregroundcolor "Green";

    Write-Host "  git instaweb –http=webrick";
    Write-Host "  Servidor web puede correr interconectado con el repositorio local"-foregroundcolor "Green";

    Write-Host "  git fsck";
    Write-Host "  Chequeo de integridad del sistema de archivos"-foregroundcolor "Green";
    Write-Host ""

    Write-Host "  CUIDADO" -foregroundcolor "Red";
    Write-Host "  --------" -foregroundcolor "Red";
    Write-Host "  git gc";
    Write-Host "  Para optimizar el repositorio por medio de una"-foregroundcolor "Green";
    Write-Host "  recolección de basura, que limpiara archivos"-foregroundcolor "Green";
    Write-Host "  innecesarios y los optimizara, usa:git hc"-foregroundcolor "Green";

    Write-Host "  git archive – -format=tar master";
    Write-Host "  Este comando le permite al usuario crear archivos"-foregroundcolor "Green";
    Write-Host "  zip o tar que contengan los constituyentes de un"-foregroundcolor "Green";
    Write-Host "  solo árbol de repositorio:git archive – -format=tar master"-foregroundcolor "Green";
                   
    Write-Host "  git prune";
    Write-Host "  Objetos que no tengan ningún puntero entrante serán eliminados"-foregroundcolor "Green";

    Write-Host "  git rebase";
    Write-Host "  Merge de toda la rama"-foregroundcolor "Green";

    Write-Host ""
    Write-Host "  https://elbauldelprogramador.com/mini-tutorial-y-chuleta-de-comandos-git/";
}



Export-ModuleMember -function gitFunctions, gitExp, comitear -Alias funcionesGit