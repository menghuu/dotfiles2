Write-Warning "current, it is implemented ugly"


$vimrc_path = Join-Path $env:USERPROFILE '.vimrc'
$vim_path = Join-Path $env:USERPROFILE '.vim'
$nvim_path = Join-Path $env:LOCALAPPDATA 'nvim'
$condarc_path = Join-Path $env:USERPROFILE '.condarc'

function Remove-And-Link($from_path, $target) {
    Write-Host "from path is: $from_path, target is: $target"
    if (Test-Path $from_path ) {
        Write-Host "delete $from_path"
        Write-Host "if failed, should delete manually"
        Remove-Item $from_path -Recurse -Force
    }
    New-Item -ItemType SymbolicLink -Path $from_path -Target $target -Force
}

# echo $vimrc_path
# echo $vim_path
# echo $nvim_path
# echo $condarc_path

Remove-And-Link "$env:USERPROFILE\.vimrc" '.\dotfiles\.vimrc'
Remove-And-Link "$env:USERPROFILE\.vimrc" '.\dotfiles\.vimrc'
Remove-And-Link "$env:USERPROFILE\.condarc" '.\dotfiles\.condarc'
Remove-And-Link "$env:USERPROFILE\.vim" '.\dotfiles\.vim'
Remove-And-Link "$env:LOCALAPPDATA\nvim" '.\dotfiles\.vim'

# install vim-plug
if (! (Test-Path '~\AppData\Local\nvim\autoload\plug.vim') ) {
    # if the plug is outdate, should 
    md ~\AppData\Local\nvim\autoload
    $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    (New-Object Net.WebClient).DownloadFile(
        $uri,
        $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
            "~\AppData\Local\nvim\autoload\plug.vim"
        )
    )
}


# New-Item -ItemType SymbolicLink -Path $vimrc_path -Target ".\dotfiles\.vimrc" -Force
# New-Item -ItemType SymbolicLink -Path $vim_path -Target "$(Join-Path dotfiles .vim)" -Force
# # New-Item -ItemType SymbolicLink -Path "$(Join-Path $USERPROFILE .fzf)" -Target ".\dotfiles\vendor\fzf" -Force
# New-Item -ItemType SymbolicLink -Path $nvim_path -Target '.\dotfiles\.config\nvim' -Force
# New-Item -ItemType SymbolicLink -Path $condarc_path -Target '.\dotfiles\.condarc' -Force
