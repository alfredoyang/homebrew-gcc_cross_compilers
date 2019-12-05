require 'formula'

class X8664ElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url "http://mirror.tochlab.net/pub/gnu/gcc/gcc-7.5.0/gcc-7.5.0.tar.gz"
  mirror "https://ftp.gnu.org/gnu/gcc/gcc-7.5.0/gcc-7.5.0.tar.gz"
  sha256 "4f518f18cfb694ad7975064e99e200fe98af13603b47e67e801ba9580e50a07f"

  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "isl"
  depends_on 'x86_64-elf-binutils'

  def install
    binutils = Formulary.factory 'x86_64-elf-binutils'

    ENV['CC'] = '/usr/local/opt/gcc@7/bin/gcc-7'
    ENV['CXX'] = '/usr/local/opt/gcc@7/bin/g++-7'
    ENV['CPP'] = '/usr/local/opt/gcc@7/bin/cpp-7'
    ENV['LD'] = '/usr/local/opt/gcc@7/bin/gcc-7'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=x86_64-elf','--disable-werror',
                             "--prefix=#{prefix}",
                             "--enable-languages=c,c++",
                             "--without-headers",
                             "--with-gmp=#{Formula["gmp"].opt_prefix}",
                             "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
                             "--with-mpc=#{Formula["libmpc"].opt_prefix}"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"x86_64-elf", prefix/"x86_64-elf"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
