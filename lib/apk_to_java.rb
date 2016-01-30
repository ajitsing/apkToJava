require_relative 'apk_to_java/pretty_printer'

module ApkToJava
  include ApkToJava::PrettyPrinter
  DEX_TO_JAR = '/usr/local/Cellar/dex2jar/2.0/bin/d2j-dex2jar'
  JADX = '/usr/local/Cellar/jadx/bin/jadx-gui'

  module Setup
    def install_dex2jar
      print_info("Installing dex2jar..")
      `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null && brew install dex2jar`
      print_success "Done!"
    end

    def install_jadx
      print_info("Installing jadx..")
      `cd /usr/local/Cellar && wget https://github.com/skylot/jadx/releases/download/v0.6.0/jadx-0.6.0.zip && unzip jadx-0.6.0.zip -d jadx/ && rm jadx-0.6.0.zip && cd -`
      print_success "Done!"
    end

    def jadx_installed?
      !`ls #{ApkToJava::JADX}`.empty?
    end

    def dex_to_jar_installed?
      !`ls #{ApkToJava::DEX_TO_JAR}`.empty?
    end

    def env_setup?
      dex_to_jar_installed? && jadx_installed?
    end

    def initialize_setup
      print_info("Initializing setup!!")
      install_dex2jar if !dex_to_jar_installed?
      install_jadx if !jadx_installed?
      print_success("Setup done :)")
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
      print_success "Done!"
      `pwd`.chomp + "/apkTojava/classes.dex"
    end

    def dex_to_jar(apk)
      remove_existing_jar if jar_exists?
      dex_file = convert_to_dex apk
      print_info "Converting dex to jar.."
      command = ApkToJava::DEX_TO_JAR + " #{dex_file}"
      `#{command}`
      print_success "Done!"
      `pwd`.chomp + '/classes-dex2jar.jar'
    end

    def jar_exists?
      print `ls #{`pwd`.chomp}/classes-dex2jar.jar`
      !`ls #{`pwd`.chomp}/classes-dex2jar.jar`.empty?
    end

    def remove_existing_jar
      print_info "Removing existing jar.."
      `rm #{`pwd`.chomp}/classes-dex2jar.jar`
    end

    def clean_up
      print_info "Cleaning the mess.."
      `rm -rf apkToJava`
      print_success "done!"
    end

    def view_as_java_code(apk)
      jar_file = dex_to_jar apk
      clean_up
      print_info "Opening in gui interface.."

      command = ApkToJava::JADX + " #{jar_file} &"
      print_success "Please be patient, apkToJava might take some time to load your project in gui interface"
      `#{command}`
    end
  end
end
