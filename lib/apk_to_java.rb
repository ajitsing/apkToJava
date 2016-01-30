require_relative 'apk_to_java/pretty_printer'

module ApkToJava
  include ApkToJava::PrettyPrinter
  DEX_TO_JAR = '/usr/local/Cellar/dex2jar/2.0/bin/d2j-dex2jar'
  JADX = '/usr/local/Cellar/jadx/bin/jadx-gui'

  module Setup
    def install_dex2jar
      print_info("installing dex2jar..")
      `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null && brew install dex2jar`
      print_success "done!"
    end

    def install_jadx
      print_info("installing jadx..")
      `cd /usr/local/Cellar && wget https://github.com/skylot/jadx/releases/download/v0.6.0/jadx-0.6.0.zip && unzip jadx-0.6.0.zip -d jadx/ && rm jadx-0.6.0.zip && cd -`
      print_success "done!"
    end

    def env_setup?
      !`ls #{ApkToJava::DEX_TO_JAR}`.empty? && !`ls #{ApkToJava::DEX_TO_JAR}`.empty?
    end

    def initialize_setup
      print_info("Initializing setup!!")
      install_dex2jar
      install_jadx
      print_success("setup done :)")
    end
  end

  module Operations
    def convert_to_dex(apk)
      print_info "Converting to dex.."
      `mkdir apkToJava`
      `cp #{apk} apkToJava/`
      apk_name = apk.split('/').last.split('.').first
      apk = "apkToJava/#{apk_name}"
      `mv apkToJava/#{apk_name}.apk apkToJava/#{apk_name}.zip`
      `unzip apkToJava/#{apk_name}.zip -d apkTojava/`
      `#{ApkToJava::DEX_TO_JAR} apkTojava/classes.dex`
      print_success "done!"
      `pwd`.chomp + "/apkTojava/classes.dex"
    end

    def dex_to_jar(apk)
      dex_file = convert_to_dex apk
      print_info "Converting dex to jar"
      command = ApkToJava::DEX_TO_JAR + " #{dex_file}"
      `#{command}`
      print_success "done!"
      `pwd`.chomp + '/classes-dex2jar.jar'
    end

    def clean_up
      print_info "cleaning the mess.."
      `rm -rf apkToJava`
      'rm classes-dex2jar.jar'
      print_success "done!"
    end

    def view_as_java_code(apk)
      jar_file = dex_to_jar apk
      clean_up
      print_info "Opening in gui interface.."

      command = ApkToJava::JADX + " #{jar_file} &"
      print_success "Please be patience, apkToJava might take some time to load your project in gui interface"
      `#{command}`
    end
  end
end
