module ApkToJava
  class LinuxSetup < Setup
    DEX_TO_JAR_URL = "'https://drive.google.com/uc?id=0BxXHKToe2BBtbmJocnE0SlhNNXc&export=download'"
    DEX_TO_JAR = '/lib/dex2jar/dex2jar-0.0.9.15/d2j-dex2jar.sh'
    JADX = '/lib/jadx/bin/jadx-gui'

    def dex2jar
      "sudo sh " + DEX_TO_JAR
    end

    def jadx
      JADX
    end

    def download_dex2jar
      "wget --no-check-certificate #{DEX_TO_JAR_URL} -O dex2jar.zip && sudo unzip dex2jar.zip -d dex2jar && rm dex2jar.zip"
    end

    def install_dex2jar
      print_info("Installing dex2jar..")
      `cd /lib && sudo #{download_dex2jar} && cd -`
      print_success "Done!"
    end

    def install_jadx
      print_info("Installing jadx..")
      `cd /lib && sudo #{download_jadx} && cd -`
      print_success "Done!"
    end
  end
end
