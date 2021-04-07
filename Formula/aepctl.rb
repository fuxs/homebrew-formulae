class Aepctl < Formula
    desc "AEP command line interface"
    homepage "https://www.bungenstock.de/aepctl/"
    url  "https://github.com/fuxs/aepctl/archive/v0.2.0.tar.gz"
    sha256 "56cc6f0146e38982edf08a426392ff1e371714f27d71497a3515eac836b7c051"
    license "Apache-2.0"
    version "v0.2.0"
    head "https://github.com/fuxs/aepctl.git"
  
    livecheck do
      url :head
      regex(/^v([\d.]+)$/i)
    end
  
    depends_on "go" => :build
    depends_on "pkger" => :build
    
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