class Bobble < Formula
  desc "Detect head nods and shakes using AirPods motion for hands-free interactions"
  homepage "https://github.com/hyusap/bobble"
  url "https://github.com/hyusap/bobble.git",
      tag:      "v1.0.0",
      revision: "6c0427cc26f83341cf2630d6930e9dd63b816be3"
  license "MIT"
  head "https://github.com/hyusap/bobble.git", branch: "main"

  depends_on xcode: ["14.0", :build]
  depends_on macos: :sonoma

  uses_from_macos "swift" => :build

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/bobble"
    generate_completions_from_executable(bin/"bobble", "--generate-completion-script")
  end

  test do
    assert_match "1.0.0", shell_output("#{bin}/bobble --version")
    assert_match "Detect head nods", shell_output("#{bin}/bobble --help")
  end
end
