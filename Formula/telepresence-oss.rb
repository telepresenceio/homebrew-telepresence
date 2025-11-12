# packaging/formula-template.rb
class TelepresenceOss < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  version "2.26.0-test.0"

  option "with-daemon", "Install system-wide root daemon (requires sudo)"

  BASE_URL = "https://github.com/telepresenceio/telepresence/releases/download"
  ARCH     = Hardware::CPU.arm? ? "arm64" : "amd64"
  OS_NAME  = OS.mac? ? "darwin" : "linux"
  PKG_NAME = "telepresence-\#{OS_NAME}-\#{ARCH}"

  url "\#{BASE_URL}/v\#{version}/\#{PKG_NAME}"

  # SHA-256 checksums – injected by generate-formula.sh
  sha256 "bfa774f4db8cade7b8a4ec82efa0efdae21a40a33f60330a0315b40fff92d2b7" if OS.mac? && Hardware::CPU.intel?
  sha256 "9f80486d72d0815737f1f96e021ea7e7e69a2e8bd850308ee73534c3f03f433d" if OS.mac? && Hardware::CPU.arm?
  sha256 "74dac9ca323f9319926bbd9745bab3a6f4d1e69c62555a76b0f577ab04428d9b"  if OS.linux? && Hardware::CPU.intel?
  sha256 "5a32f1df511cc1c2691d45f02835cf72e0c188776e64486252f2e3fc2160aaf3"  if OS.linux? && Hardware::CPU.arm?

  conflicts_with "telepresence"

  # System-wide directories – only used with --with-daemon
  def system_config_dir
    OS.mac? ? "/Library/Application Support/telepresence/config" : "/etc/telepresence"
  end

  def system_log_dir
    OS.mac? ? "/Library/Logs/telepresence" : "/var/log/telepresence"
  end

  def system_cache_dir
    OS.mac? ? "/Library/Application Support/telepresence/cache" : "/var/cache/telepresence"
  end

  def system_runtime_dir
    "/var/run/telepresence"
  end

  def system_config_path
    "\#{system_config_dir}/config.yml"
  end

  def system_log_path
    "\#{system_log_dir}/daemon.log"
  end

  def system_socket_path
    "\#{system_runtime_dir}/telepresence-daemon.socket"
  end

  def install
    bin.install "\#{PKG_NAME}" => "telepresence"
    install_system_daemon if build.with? "daemon"
  end

  def install_system_daemon
    sudo = Process.uid.zero? ? "" : "sudo "
    [system_config_dir, system_log_dir, system_cache_dir, system_runtime_dir].each do |dir|
      system "\#{sudo}mkdir", "-p", dir
    end

    unless File.exist?(system_config_path)
      (system_config_path).write <<~EOS
        # Telepresence root daemon config
        cluster_id: ""
      EOS
    end

    if OS.mac?
      (etc/"launchd"/"io.telepresence.daemon.plist").write <<~EOS
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
          <key>Label</key>             <string>io.telepresence.daemon</string>
          <key>ProgramArguments</key>
          <array>
            <string>\#{bin}/telepresence</string>
            <string>rootd</string>
            <string>--config</string>    <string>\#{system_config_path}</string>
            <string>--logfile</string>   <string>\#{system_log_path}</string>
            <string>\#{system_cache_dir}</string>
            <string>\#{system_socket_path}</string>
          </array>
          <key>RunAtLoad</key>         <true/>
          <key>KeepAlive</key>         <true/>
          <key>StandardOutPath</key>   <string>\#{system_log_dir}/daemon.out</string>
          <key>StandardErrorPath</key> <string>\#{system_log_dir}/daemon.err</string>
          <key>WorkingDirectory</key> <string>\#{HOMEBREW_PREFIX}</string>
          <key>UserName</key>          <string>root</string>
          <key>GroupName</key>         <string>admin</string>
          <key>Umask</key>             <integer>022</integer>
        </dict>
        </plist>
      EOS
    end

    if OS.linux?
      (etc/"systemd/system"/"telepresence-daemon.service").write <<~EOS
        [Unit]
        Description=Telepresence Root Daemon
        After=network.target
        Documentation=https://telepresence.io

        [Service]
        Type=simple
        ExecStart=\#{bin}/telepresence rootd \\
          --config \#{system_config_path} \\
          --logfile \#{system_log_path} \\
          #\{system_cache_dir} \\
          #\{system_socket_path}
        Restart=always
        RestartSec=5
        StandardOutput=append:\#{system_log_path}
        StandardError=append:\#{system_log_path}
        WorkingDirectory=\#{HOMEBREW_PREFIX}
        User=root
        Group=root
        RuntimeDirectory=telepresence
        RuntimeDirectoryMode=0755
        StateDirectory=telepresence
        StateDirectoryMode=0755
        CacheDirectory=telepresence
        CacheDirectoryMode=0755

        [Install]
        WantedBy=multi-user.target
      EOS
    end
  end

  service do
    run [opt_bin/"telepresence", "rootd",
         "--config", system_config_path,
         "--logfile", system_log_path,
         system_cache_dir,
         system_socket_path]

    log_path system_log_path
    error_log_path system_log_path
    working_dir HOMEBREW_PREFIX
    require_root true
    run_type :immediate
    keep_alive true
    environment_variables PATH: "\#{HOMEBREW_PREFIX}/bin:/usr/local/bin:/usr/bin:/bin"
  end

  def caveats
    if build.with? "daemon"
      <<~EOS
        System-wide Telepresence root daemon installed.

        Config:   #{system_config_path}
        Logs:     #{system_log_path}
        Cache:    #{system_cache_dir}
        Socket:   #{system_socket_path}

        Start:
          sudo brew services start telepresence

        Manual:
          # macOS
          sudo launchctl load -w /Library/LaunchDaemons/io.telepresence.daemon.plist
          # Linux
          sudo systemctl daemon-reload && sudo systemctl enable --now telepresence-daemon.service
      EOS
    else
      <<~EOS
        Only the Telepresence CLI is installed.

        To use the daemon, install with:
          brew install --with-daemon telepresence
      EOS
    end
  end

  def post_install
    system "sudo", "mkdir", "-p", system_runtime_dir if build.with? "daemon"
  end

  test do
    system "\#{bin}/telepresence", "--help"
  end
end
