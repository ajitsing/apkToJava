require_relative './setup.rb'

module ApkToJava
  class MacSetup < Setup
    DEX_TO_JAR = '/usr/local/Cellar/dex2jar/2.0/bin/d2j-dex2jar'
    JADX = '/usr/local/Cellar/jadx/bin/jadx-gui'

    def install_dex2jar
      print_info("Installing dex2jar..")
      `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null`
      `brew install dex2jar`
      print_success "Done!"
    end

    def dex2jar
      DEX_TO_JAR
    end

    def jadx
      JADX
    end

    def install_jadx
      print_info("Installing jadx..")
      `cd /usr/local/Cellar && #{download_jadx} && cd -`
      print_success "Done!"
    end
  end
end
