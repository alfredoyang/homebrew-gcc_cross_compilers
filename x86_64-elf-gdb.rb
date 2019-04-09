require 'formula'

class X8664ElfGdb < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftp.gnu.org/gnu/gdb/gdb-7.11.1.tar.xz'
  sha256 'e9216da4e3755e9f414c1aa0026b626251dfc57ffe572a266e98da4f6988fc70'

  depends_on 'x86_64-elf-binutils'
  depends_on 'x86_64-elf-gcc'

  def install
    ENV['CC'] = '/usr/local/opt/gcc@7/bin/gcc-7'
    ENV['CXX'] = '/usr/local/opt/gcc@7/bin/g++-7'
    ENV['CPP'] = '/usr/local/opt/gcc@7/bin/cpp-7'
    ENV['LD'] = '/usr/local/opt/gcc@7/bin/gcc-7'

    mkdir 'build' do
      system '../configure', '--target=x86_64-pc-linux', "--prefix=#{prefix}"
      system 'make'
      system 'make install'
      FileUtils.rm_rf share/"locale"
    end
  end
end
