require_relative 'apk_to_java/pretty_printer'
require_relative 'apk_to_java/mac_setup'
require_relative 'apk_to_java/linux_setup'
require_relative 'apk_to_java/os'

module ApkToJava
  include ApkToJava::PrettyPrinter
  module EnvSetup
    def supported_os
      if ApkToJava::OS.mac?
        ApkToJava::MacSetup.new
      elsif ApkToJava::OS.linux?
        ApkToJava::LinuxSetup.new
      end
    end

    def initialize_setup
      print_info("Initializing setup!!")
      os = supported_os
      if !os.nil?
        os.install_dex2jar if !os.dex_to_jar_installed?
        os.install_jadx if !os.jadx_installed?
        print_success("Setup done :)")
      else
        print_error "Sorry! apkToJava supports only MAC and Linux"
      end
    end

    def env_setup?
      supported_os.env_setup?
    end
  end

  module Operations
    TEMP_DIR = 'apkToJavaTmp'
    include ApkToJava::EnvSetup

    def copy_apk(apk)
      `mkdir #{TEMP_DIR}`
      `cp #{apk} #{TEMP_DIR}/`
    end

    def unzip(apk_name)
      `mv #{TEMP_DIR}/#{apk_name}.apk #{TEMP_DIR}/#{apk_name}.zip`
      `unzip #{TEMP_DIR}/#{apk_name}.zip -d #{TEMP_DIR}/`
    end

    def path_to_dex
      `pwd`.chomp + "/#{TEMP_DIR}/classes.dex"
    end

    def create_jar(dex_file)
      `#{supported_os.dex2jar} #{dex_file} --force`
    end

    def path_to_jar
      `pwd`.chomp + '/classes-dex2jar.jar'
    end

    def clean_up
      print_info "Cleaning the mess.."
      `rm -rf #{TEMP_DIR}`
      print_success "done!"
    end

    def open_code_in_gui(jar_file)
      `#{supported_os.jadx}  #{jar_file} > /dev/null 2>&1 & disown`
    end

    def convert_to_dex(apk)
      print_info "Converting to dex.."
      copy_apk apk
      apk_name = apk.split('/').last.split('.').first
      unzip apk_name
      print_success "Done!"
      path_to_dex
    end

    def dex_to_jar(apk)
      dex_file = convert_to_dex apk
      print_info "Converting dex to jar.."
      create_jar dex_file
      print_success "Done!"
      path_to_jar
    end

    def view_as_java_code(apk)
      jar_file = dex_to_jar apk
      clean_up
      print_info "Opening in gui interface.."
      print_success "Please be patient, apkToJava might take some time to load your project in gui interface"
      open_code_in_gui jar_file
    end
  end
end
