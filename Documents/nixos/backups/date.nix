#FIX: bug
{
  lib,
  timestamp,
  currentTime,
  runCommand,
  pkgs,
  self,
  ...
}:
# Let's define a `let` block for our expressions, which allows us to reuse code
let
  # `generateTimestamp` is a function that takes a `time` and returns a Nix derivation
  # which runs a command to generate a timestamp string using `date`
  generateTimestamp = time:
    pkgs.runCommand "timestamp"
    {
      # `runCommand` is used to execute a shell command in the Nix build process
      env.when = time; # We pass the `time` value to the environment variable `when`
    }
    ''
      # This is the shell command that generates the formatted timestamp
      # `date -d @$when` converts the epoch time into a human-readable timestamp
      echo "Timestamp: $(date -d @$when +%Y-%m-%d_%H-%M-%S)"
      # `echo` outputs the result to the standard output, which Nix captures
      # The timestamp format is: Year-Month-Day_Hour-Minute-Second
    '';

  # Now we generate two timestamps using the `generateTimestamp` function.
  # `currentTime` is a built-in Nix value representing the current time in seconds since Unix epoch
  currentTimestamp = generateTimestamp currentTime;

  # `self.sourceInfo.lastModified` is the last modified time of the source (like a Git repo)
  sourceTimestamp = generateTimestamp self.sourceInfo.lastModified;
in
  # The `in` block is where we return the final values or outputs
  {
    # The `currentBackup` will be a string that starts with "backup-" followed by the timestamp
    # We use `pkgs.lib.readFile` to read the file generated by `runCommand` containing the timestamp
    currentBackup = "backup-" + pkgs.lib.readFile currentTimestamp;

    # Similarly, we do the same for `sourceBackup`, using the timestamp from the source file's last modification
    sourceBackup = "backup-" + pkgs.lib.readFile sourceTimestamp;
  }
