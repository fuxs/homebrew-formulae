class Aepctl < Formula
    desc "AEP command line interface"
    homepage "https://www.bungenstock.de/aepctl/"
    url  "https://github.com/fuxs/aepctl/archive/v0.1.0.tar.gz"
    sha256 "21db1a97dbf7883a3c9946a531666506b9eeb04a2ab5e4721758d1935f7045d7"
    license "Apache-2.0"
    head "https://github.com/fuxs/aepctl.git"
  
    livecheck do
      url :head
      regex(/^v([\d.]+)$/i)
    end
  
    depends_on "go" => :build
  
    def install
      # Build
      system "make","build"
      bin.install "bin/aepctl"
  
      # bash completion
      output = Utils.safe_popen_read("#{bin}/aepctl", "completion", "bash")
      (bash_completion/"aepctl").write output
  
      # zsh completion
      output = Utils.safe_popen_read("#{bin}/aepctl", "completion", "zsh")
      (zsh_completion/"_aepctl").write output
    end
  
    test do
      run_output = shell_output("#{bin}/aepctl 2>&1")
      assert_match "The command line tool for AEP", run_output
    end
  end