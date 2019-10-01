#!/usr/bin/env python3
"""
shell工具拷贝自: https://github.com/toastdriven/shell
只做了微小的改动
这里的安装过程只要求两点:
1. 尽可能少的依赖, 目前需要依赖python3.5以上, 不想再依赖除了python自带包以外的东西
2. 尽可能的简单, 追求完美太累了
"""
import logging
from invoke import task, Context, Result, run
import tempfile
import os
import os.path as osp
import sys
import platform
import shlex
import subprocess
import shutil
import datetime
try:
    from typing import Union, List
except ImportError:
    print('不支持typing类型标注')

logger = logging.getLogger(__name__)
logger.setLevel('DEBUG')

# 当使用了pty=True的时候, 这个时候stdout和stderr是分离不开的


class InstallPackageFailed(Exception):
    def __init__(self, package_names: Union[List[str], str] = 'unknow', by='unknow', msg_or_res: Union[str, Result, List[Result]] = ''):

        assert isinstance(package_names, (list, str))

        self.package_names = package_names

        self.by = by
        self.msg_str = '<' + '=' * 78 + '\n'
        assert isinstance(msg_or_res, (str, List, Result))
        if isinstance(msg_or_res, str):
            self.msg_str += msg_or_res
        elif isinstance(msg_or_res, Result):
            self.msg_str += extract_other_msg_from_res(msg_or_res)
        else:
            self.msg_str = ';'.join(
                [extract_other_msg_from_res(res) if isinstance(res, Result) else res for res in msg_or_res])
        self.msg_str += '=' * 78 + '>' + '\n'

        super(InstallPackageFailed, self).__init__(
            f'尝试通过{self.by}安装{self.package_names}, 但是没有成功. 可能有用的信息有:\n{self.msg_str}')


class BrewInstallPackageFailed(InstallPackageFailed):
    def __init__(self, package_names: Union[List[str], str] = 'unknow', msg_or_res: Union[str, Result, List[Result]] = ''):
        super(BrewInstallPackageFailed, self).__init__(
            package_names=package_names, msg_or_res=msg_or_res, by='brew')


# configure here
_res = run('uname', hide=True, warn=True)
if not _res:
    raise OSError('get system_type wrong, {}'.format(_res))
system_type = _res.stdout.strip().lower()

_res = run('uname -m', hide=True, warn=True)
if not _res:
    raise OSError('get arch_type wrong')
arch_type = _res.stdout.strip().lower()

del _res
if system_type == 'linux':
    machine = 'linux'
elif system_type == 'darwin':
    machine = 'macosx'
else:
    raise OSError('不支持这个操作系统{}'.format(system_type))

os.environ['HOMEBREW_NO_AUTO_UPDATE'] = '1'

local_dir = osp.expanduser('~/.local')
if not osp.exists(local_dir):
    os.makedirs(local_dir)

app_dir = osp.expanduser('~/.apps')
if not osp.exists(app_dir):
    os.makedirs(app_dir)

backup_dir = osp.expanduser(
    f'~/.backups/backup_on_{datetime.datetime.now().strftime("%Y.%m.%d_%H:%M:%S")}')

miniconda_version = 'latest'
anaconda_version = '2019.07'

miniconda_url = f'https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda-{miniconda_version}-{machine}-{arch_type}.sh'
anaconda_url = f'https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-{anaconda_version}-{machine}-{arch_type}.sh'

install_homebrew_command = '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
install_linuxbrew_command = 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"'

# helper function here


def make_sure_dir_exist(dir_path):
    if osp.exists(dir_path) or os.makedirs(dir_path):
        assert osp.isdir(dir_path)
        return dir_path
    raise RuntimeError('cannot make sure the dir is exist')


def command_is_exist(command_name):
    res = run(f'command -v {command_name} 2>&1 >/dev/null', warn=True)
    return res


def conda_package_is_installed(conda_package):
    try:
        return conda_package in run(f'conda list -c -f {conda_package}', hide=True).stdout
    except Exception as e:
        raise RuntimeError(f'在寻找是否安装conda package的时候出错, 错误信息是: {e}')


def extract_other_msg_from_res(res):
    # return f'stdout: {res.stdout}; stderr: {res.stderr}'
    return str(res)


def try_download(url, save_path=None, prog='wget'):
    assert prog in ['wget', 'curl']
    if save_path is None:
        save_path = tempfile.mkstemp()
    if not command_is_exist(prog):
        return None
    if prog == 'wget':
        res = run(f'wget -O  {save_path} {url}')
    else:
        res = run(f'curl {url} > {save_path}')

    if res:
        return save_path
    else:
        return None


def download_url(url, save_path=None):
    if save_path is None:
        save_path = tempfile.mkstemp()
    return try_download(url, save_path, prog='wget') or try_download(url, save_path, prog='curl')


def _make_sure_package_names_checks_forces(package_names, checks, forces):
    assert isinstance(package_names, (str, list))
    if isinstance(package_names, str):
        package_names = [package_names]

    assert isinstance(checks, (list, bool, str))
    if isinstance(checks, list):
        assert len(checks) == len(package_names)
    elif isinstance(checks, bool):
        checks = [checks] * len(package_names)
    elif isinstance(checks, str):
        checks = [checks] * len(package_names)
    else:
        raise ValueError('checks参数要不就是一个布尔值,要不就是一个和package_names一样长的list')
    # 这么变换之后, checks 就一定是一个list, 每个元素要不就是一个str, 要不就是一个bool

    for i in range(len(package_names)):
        if checks[i] == True:
            checks[i] = package_names[i]
        elif checks[i] == False:
            checks[i] = None
        else:
            pass
            # 这里必然有 isinstance(package_names[i], str)
    # 这么变换完之后, checks就一定是一个list, 里面元素要不就是一个字符串, 要不就是一个None

    assert isinstance(forces, (list, bool))
    if isinstance(forces, list):
        assert len(forces) == len(package_names)
    elif isinstance(forces, bool):
        forces = [forces] * len(package_names)
    else:
        raise ValueError('forces参数要不就是一个布尔值,要不就是一个和package_names一样长的list')
    # 这么变换之后, checks 就一定是一个List[bool]

    for i in range(len(forces)):
        assert isinstance(forces[i], bool)

    assert len(package_names) == len(checks) == len(forces)
    pass

    return package_names, checks, forces


def brew_install(package_names: Union[List[str], str], checks: Union[List[str], List[bool], str, bool] = True, forces: [bool, List[bool]] = False, verbose=False):

    package_names, checks, forces = _make_sure_package_names_checks_forces(
        package_names, checks, forces)

    successed = {}
    failed = {}
    failed_msg = ''
    for package_name, check, force in zip(package_names, checks, forces):
        if not force and check and command_is_exist(check):
            # raise Exception('ff')
            # print('命令{}存在, 并且不强制安装{}'.format(check, package_name))
            return
        else:
            if verbose:
                res = run(
                    f'brew install --verbose {package_name}', pty=True, warn=True)
            else:
                res = run(f'brew install {package_name}', pty=True, warn=True)
            if res:
                successed[package_name] = res
            else:
                failed[package_name] = res
                failed_msg += str(res) + '- ' * 20 + '\n'
                # failed_msg += f'{package_name}: {res.stdout} + \n + {res.stderr} + \n'
    if len(failed) != 0:
        raise BrewInstallPackageFailed(
            package_names='/'.join(failed), msg_or_res=failed_msg)


def conda_install(package_names: Union[List[str], str], checks: Union[List, str, bool] = True, forces: [bool, List[bool]] = False):

    package_names, checks, forces = _make_sure_package_names_checks_forces(
        package_names, checks, forces)

    successed = {}
    failed = {}
    failed_msg = ''
    for package_name, check, force in zip(package_names, checks, forces):
        if check and conda_package_is_installed(check) and not force:
            pass
        else:
            res = run(f'conda install -y {package_name}', pty=True, warn=True)
            if res:
                successed[package_name] = res
            else:
                failed[package_name] = res
                failed_msg += str(res) + '- ' * 20 + '\n'
                # failed_msg += f'{package_name}: {res.stdout} + \n + {res.stderr} + \n'
    if len(failed) != 0:
        raise BrewInstallPackageFailed(
            package_names='/'.join(failed), msg_or_res=failed_msg)


def pipx_install(package_names: Union[List[str], str], checks: Union[List, str, bool] = True, forces: [bool, List[bool]] = False):
    package_names, checks, forces = _make_sure_package_names_checks_forces(
        package_names, checks, forces)

    successed = {}
    failed = {}
    failed_msg = ''
    for package_name, check, force in zip(package_names, checks, forces):
        if check and command_is_exist(check) and not force:
            pass
        else:
            res = run(f'pipx install {package_name}', pty=True, warn=True)
            if res:
                successed[package_name] = res
            else:
                failed[package_name] = res
                failed_msg += str(res) + '- ' * 20 + '\n'
                # failed_msg += f'{package_name}: {res.stdout} + \n + {res.stderr} + \n'
    if len(failed) != 0:
        raise BrewInstallPackageFailed(
            package_names='/'.join(failed), msg_or_res=failed_msg)


def link_with_backup(old, new=None, backup_dir=backup_dir, after_backup_dir_prefix=''):
    old = osp.abspath(osp.expanduser(osp.expandvars(old)))
    if new is None:
        new = osp.join('~', osp.basename(old))
    new = osp.abspath(osp.expanduser(osp.expandvars(new)))
    backup_dir = osp.join(
        osp.abspath(osp.expandvars(osp.expanduser(backup_dir))), after_backup_dir_prefix)

    if not osp.exists(backup_dir):
        os.makedirs(backup_dir)

    if osp.exists(new):
        backup_file_path = osp.join(backup_dir, osp.basename(new))
        shutil.move(new, backup_file_path)
    os.symlink(old, new)

def link_files_in_dir(c, target_dir='~',  dir='dotfiles/', ignore_dir=True, after_backup_dir_prefix=''):
    dir = osp.abspath(dir)
    target_dir = osp.abspath(osp.expanduser(target_dir))
    for file_or_dir_name in os.listdir(dir):
        file_or_dir_path = osp.join(dir, file_or_dir_name)
        if osp.isdir(file_or_dir_path) and ignore_dir:
            continue
        file_path = file_or_dir_path
        link_with_backup(file_path,
                            osp.join(target_dir, osp.basename(file_path)),
                            after_backup_dir_prefix=after_backup_dir_prefix)

# task here

@task
def install_pipx(c, force=False):
    if command_is_exist('pipx') and not force:
        pass
    else:
        res = c.run(
            'python3 -m pip install --user pipx && python3 -m pipx ensurepath', pty=True)
        if res:
            return
        else:
            raise InstallPackageFailed(
                package_names='pipx', by='python3 -m pip', msg_or_res=res)


@task(aliases=['conda'])
def install_conda(c, conda_package='miniconda', force=False):
    """安装conda

    建议使用安装miniconda来安装conda, 这样的话, 能省许多的事情
    miniconda 即不大, 又能安装二进制软件, 省的自己编译一些十分有必要的软件

    :param c: context
    :type c: Context
    :param conda_package: conda包名, defaults to 'miniconda'
    :type conda_package: str, optional
    :param force: 如果安装了,是否强制重新安装, defaults to False
    :type force: bool, optional
    :raises RuntimeError: 安装出错
    """
    if command_is_exist('conda') and not force:
        pass
        # print('命令conda存在并且不强制安装')
    elif conda_package == 'pypi':
        # 如果选择使用pypi安装的话, 会有很多的限制, 比如不能安装二进制包
        if not command_is_exist('pip'):
            logger.critical('从pip安装conda失败')
            raise InstallPackageFailed(
                package_names='conda', by=conda_package, msg_or_res='no `pip` comamnd')
        res = c.run('pip install conda')
        if not res:
            logger.critical('{}\n{}'.format(res.stdout, res.stderr))
            raise InstallPackageFailed(
                package_names='conda', by=conda_package, msg_or_res=res)
    else:
        url = miniconda_url if conda_package == 'miniconda' else anaconda_url
        path = download_url(url)
        if path:
            res = c.run(f'sh {path}', pty=True, warn=True)
            if res:
                logger.info('install {} success'.format(conda_package))
            else:
                logger.critical('install {} failed'.format(conda_package))
                raise InstallPackageFailed(
                    package_names='conda', by=conda_package, msg_or_res=extract_other_msg_from_res(res))
        else:
            logger.critical('不能够下载{}'.format(conda_package))
            raise InstallPackageFailed(
                msg_or_res=res, package_names='conda', by=conda_package
            )
    if conda_package != 'pypi':
        # 这是为了使用conda安装相应的库文件而准备搜索路径
        res = c.run(f'source ~/.bashrc && which conda', hide=True, warn=True)
        if not res:
            RuntimeError(f'cannot found conda, error is : {res}')
        else:
            conda_bin_path = res.stdout.strip()
            conda_root_dir_path = osp.split(osp.dirname(conda_bin_path))[0]

            # 寻找添加LD_LIBRARY_PATH
            CONDA_LD_LIBRARY_PATH = osp.join(conda_root_dir_path, "lib")
            LD_LIBRARY_PATH = os.environ.get('LD_LIBRARY_PATH', '')
            os.environ['LD_LIBRARY_PATH'] = f'{LD_LIBRARY_PATH}:{CONDA_LD_LIBRARY_PATH}'

            # 寻找添加C_INCLUDE_PATH
            CONDA_C_INCLUDE_PATH = osp.join(conda_root_dir_path, "include")
            C_INCLUDE_PATH = os.environ.get('C_INCLUDE_PATH', '')
            os.environ['C_INCLUDE_PATH'] = f'{C_INCLUDE_PATH}:{CONDA_C_INCLUDE_PATH}'

            # 寻找添加CPLUS_INCLUDE_PATH
            CONDA_CPLUS_INCLUDE_PATH = osp.join(conda_root_dir_path, "include")
            CPLUS_INCLUDE_PATH = os.environ.get('CPLUS_INCLUDE_PATH', '')
            os.environ['CPLUS_INCLUDE_PATH'] = f'{CPLUS_INCLUDE_PATH}:{CONDA_CPLUS_INCLUDE_PATH}'

            # 寻找添加PATH
            CONDA_PATH = osp.join(conda_root_dir_path, "bin")
            PATH = os.environ.get('PATH', '')
            os.environ['PATH'] = f'{PATH}:{CONDA_PATH}'
    return


@task(aliases=['ruby'], pre=[install_conda])
def install_ruby(c, force=False):
    if command_is_exist('ruby') and not force:
        return
    else:
        res = c.run('conda install ruby')
        if not res:
            raise InstallPackageFailed(
                by='conda', msg_or_res=res, package_names='ruby')


@task(aliases=['brew'], pre=[install_ruby])
def install_brew(c, force=False):
    if command_is_exist('brew') and not force:
        return
    else:
        if system_type.lower() == 'linux':
            res = c.run(install_linuxbrew_command, pty=True)
        elif system_type.lower() == 'darwin':
            res = c.run(install_homebrew_command, pty=True)
        else:
            raise RuntimeError('不支持这个操作系统')
        if not res:
            raise InstallPackageFailed(
                package_names='brew', by='shell/ruby', msg_or_res=res)
        # print('安装brew成功')


@task(pre=[install_brew])
def update_brew(c):
    c.run('brew update', pty=True)


@task
def install_fpp(c, force=False):
    if command_is_exist('fpp') and not force:
        return
    make_sure_dir_exist(osp.expanduser('~/.app'))
    make_sure_dir_exist(osp.expanduser('~/.local/bin'))
    if osp.exists(osp.expanduser('~/.apps/fpp')):
        return
    res = c.run('git clone https://github.com/facebook/PathPicker.git ~/.apps/fpp_source && '
                'ln -s "~/.apps/fpp_source/fpp ~/.local/bin/fpp')
    if not res:
        raise InstallPackageFailed(
            package_names='fpp', by='git', msg_or_res=res)


@task
def install_direnv(c, force=False):
    if command_is_exist('direnv') and not force:
        return
    local_bin_dir = make_sure_dir_exist(osp.join(local_dir, 'bin'))
    if sys.platform == 'linux' or sys.platform == 'cygwin':
        ostype = 'linux'
    elif sys.platform == 'darwin':
        ostype = 'darwin'
    elif sys.platform == 'win32':
        ostype = 'windows'
    else:
        raise ValueError(f'do not support this system type {sys.platform}')

    if platform.machine() == 'i386':
        archtype = '386'
    elif platform.machine() == 'x86_64':
        archtype = 'amd64'
    else:
        raise ValueError(f'do not support this arch type {platform.machine()}')

    url = f'https://github.com/direnv/direnv/releases/latest/download/direnv.{ostype}-{archtype}'
    print(url)

    bin_path = osp.join(local_bin_dir, "direnv")
    # bin_path = osp.join('/tmp', "direnv")
    res = c.run(f'curl -L {url} -o {bin_path} && '
                f'chmod u+x {bin_path}')
    if not res:
        raise InstallPackageFailed(
            package_names='direnv',  by='curl', msg_or_res=res)


@task
def install_fzf(c, force=False):
    if command_is_exist('fzf') and not force:
        return
    source_dir = osp.join(app_dir, 'fzf_source')
    if osp.exists(source_dir):
        return
    res = c.run(
        f'git clone --depth 1 https://github.com/junegunn/fzf.git {source_dir} && '
        f'{osp.join(source_dir, "install")}', pty=True)
    if not res:
        raise InstallPackageFailed(
            package_names='fzf', by='gt', msg_or_res=res)


@task
def install_zlua(c, force=False):
    if command_is_exist('z') and not force:
        return
    # for z.lua
    source_dir = osp.join(app_dir, 'z.lua')
    brew_install('lua')
    res = not osp.exists(source_dir) \
        and run(f'git clone https://github.com/skywind3000/z.lua.git {source_dir}', warn=True)
    if not res:
        raise InstallPackageFailed(
            package_names='z.lua', by='git', msg_or_res=res)


@task
def install_yarn(c, force=False):
    if command_is_exist('yarn') and not force:
        return
    res = c.run('curl -o- -L https://yarnpkg.com/install.sh | bash', pty=True)
    if not res:
        raise InstallPackageFailed(
            package_names='yarn', by='bash', msg_or_res=res)


@task
def install_pyenv(c, force=False):
    if command_is_exist('pyenv') and force:
        return
    else:
        res = c.run('curl https://pyenv.run | bash', pyt=True, warn=True)
        if res:
            pass
        else:
            raise InstallPackageFailed(
                package_names='pyenv', by='bash', msg_or_res=res)


@task
def install_tpm(c, force=False):
    if osp.exists(osp.expanduser('~/.tmux/plugins/tpm')) and not force:
        return
    os.makedirs(osp.expanduser('~/.tmux/plugins'))
    shutil.rmtree(osp.expanduser('~/.tmux/plugins/tpm'),
                  ignore_errors=True, onerror=None)
    res = c.run(
        'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm', pty=True, warn=True)
    if not res:
        raise InstallPackageFailed(
            package_names='tpm', by='git', msg_or_res=res)


@task
def install_vimcdoc(c, force=False):
    if osp.exists(osp.expanduser('~/.vim/doc/map.cnx')) and not force:
        return
    tmp_dir = tempfile.mkdtemp()
    vimcdoc_url = 'https://sourceforge.net/projects/vimcdoc/files/vimcdoc/vimcdoc-2.1.0.tar.gz/download'
    res = c.run(
        f'curl -L -s -o {tmp_dir}/vimcdoc.tar.gz {vimcdoc_url} && '
        f'tar -xzf {tmp_dir}/vimcdoc.tar.gz -C {tmp_dir} && '
        f'cd $(find {tmp_dir} -maxdepth 1 -type d -name "vimcdoc*") && '
        f'sh ./vimcdoc.sh -i && rm -fr {tmp_dir}',
        pty=True, warn=True)
    if not res:
        raise InstallPackageFailed('vimcdoc', 'shell script', msg_or_res=res)
    pass

# @task(aliases=['common_deps'], pre=[update_brew])
@task(aliases=['common_deps'], pre=[install_conda, update_brew, install_pipx])
def install_common_deps(c):
    logger.info('install common deps')
    # 此函数用来安装所有平台上的通用依赖, 主要包括conda, brew, git之类的工具
    logger.info('install git curl wget by brew')
    brew_install(['git', 'curl', 'wget'])
    # 这些都是常见的库和工具, 不过编译安装速度非常慢, 谨慎运行
    logger.info('install common library by brew')
    brew_install(['bzip2', 'libffi', 'libxml2', 'libxmlsec1',
                  'openssl', 'readline', 'sqlite', 'xz', 'zlib'], verbose=True)
    # 这个可能在`pyenv install 3.7.4`时有用
    # conda_install(package_names=['libffi', 'ncurses'])


@task(aliases=['common_packages'], pre=[install_common_deps])
def install_common_packages(c):
    logger.info('install common packages')
    brew_install('tmux', checks='tmux', forces=False)
    brew_install('neovim', checks='nvim')
    brew_install('trash-cli', checks='trash-put')
    pipx_install('ranger-fm')
    install_fpp(c)
    install_direnv(c)
    install_fzf(c)
    # install_zlua(c)
    install_yarn(c)
    install_tpm(c)
    install_vimcdoc(c)


@task(pre=[install_common_deps, install_common_packages])
def install(c):
    if system_type == 'darwin':
        logger.info('install extra macos packages')
        brew_install('coreutils')
        brew_install('bash-completion')
        pass



@task
def link(c):
    link_files_in_dir(c)
    link_with_backup(osp.join('dotfiles', '.vim'), '~/.vim')
    link_files_in_dir(c, target_dir='~/.config', dir='dotfiles/.config',
                      ignore_dir=False, after_backup_dir_prefix='.config')
