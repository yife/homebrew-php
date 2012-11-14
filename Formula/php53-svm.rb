require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Svm < AbstractPhp53Extension
  init
  homepage 'http://php.net/manual/en/book.svm.php'
  url 'https://github.com/ianbarber/php-svm/tarball/master'
  sha1 '10b3a64170639602f9929c1b47d1c4f4da210a2b'
  head 'https://github.com/ianbarber/php-svm.git'
  version '0.1.8'

  depends_on 'autoconf' => :build
  depends_on 'php53' unless build.include?('without-homebrew-php')

  def install
    Dir.chdir "svm-#{version}" unless build.head?

    safe_phpize
    ENV["CFLAGS"] = '-Wno-return-type'
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/svm.so"
    write_config_file unless build.include? "without-config-file"
  end
end
