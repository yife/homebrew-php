require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Mongo < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/mongo'
  url 'http://pecl.php.net/get/mongo-1.2.12.tgz'
  sha1 '5bf06a36f275e40378db1ebdfda6dfb93419ae60'
  head 'https://github.com/mongodb/mongo-php-driver.git'

  depends_on 'autoconf' => :build
  depends_on 'php54' unless build.include?('without-homebrew-php')

  def install
    Dir.chdir "mongo-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/mongo.so"
    write_config_file unless build.include? "without-config-file"
  end
end
