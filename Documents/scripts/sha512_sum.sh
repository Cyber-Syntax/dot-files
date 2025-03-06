
#!/bin/bash

# Paths to the files
FILE_OLD="superProductivity-x86_64(1).AppImage"
FILE_NEW="superProductivity-x86_64.AppImage"

# Base64 strings
BASE64_OLD="GSqZL22HcocLRTuJY/ShHVtnyZCq1Cn4Q7ShfQqs9EmS8lsNuJppRnXwt2iYEQ+oTs8mLWhDCegOWDFQHzNsEQ=="
# BASE64_NEW="OJ3XUc+B+8IiWMjgl3FdotJfWSKuZzRDlMp4EldATbvQBmo83bfblwTjtU4RFG+aICzy7y3x58ji31uL/MwGIg=="
BASE64_NEW="0FYoma9kltRQregFTzz4HllmODtsnMRg10mAlpW8pTLUT6LeimGQ60ilIHujOLCvlN5If/uTcB6RtVq3ARLBWg=="
# Function to calculate and print details for a file
compare_hashes() {
    local file=$1
    local base64_str=$2

    echo "File: $file"

    # Calculate SHA-512 hash
    local file_hash
    file_hash=$(sha512sum "$file" | awk '{print $1}')
    echo "Calculated SHA-512: $file_hash"

    # Decode Base64 and convert to hex
    local decoded_hex
    decoded_hex=$(echo "$base64_str" | base64 -d | xxd -p -c 256)
    echo "Base64-decoded hex: $decoded_hex"

    # Compare and print results
    if [[ "$file_hash" == "$decoded_hex" ]]; then
        echo "✅ Calculated hash matches the Base64-decoded hex!"
    else
        echo "❌ Calculated hash does NOT match the Base64-decoded hex!"
    fi

    echo "--------------------------------------------"
}

# Compare the old version
compare_hashes "$FILE_OLD" "$BASE64_OLD"

# Compare the new version
compare_hashes "$FILE_NEW" "$BASE64_NEW"

## OUTPUT
# ╰─❯ sh test.sh                                                                                                                                                    ─╯
# File: superProductivity-x86_64(1).AppImage
# Calculated SHA-512: 192a992f6d8772870b453b8963f4a11d5b67c990aad429f843b4a17d0aacf44992f25b0db89a694675f0b76898110fa84ecf262d684309e80e5831501f336c11
# Base64-decoded hex: 192a992f6d8772870b453b8963f4a11d5b67c990aad429f843b4a17d0aacf44992f25b0db89a694675f0b76898110fa84ecf262d684309e80e5831501f336c11
# ✅ Calculated hash matches the Base64-decoded hex!
# --------------------------------------------
# File: superProductivity-x86_64.AppImage
# Calculated SHA-512: c3410b29493baa60d737680a1282ded7564a870a538f21164d76afb812723c79ab11f6962d1e8d1ce34316492c7c49572f89579e390cabb520b78e0a55a2e0a0
# Base64-decoded hex: 389dd751cf81fbc22258c8e097715da2d25f5922ae67344394ca781257404dbbd0066a3cddb7db9704e3b54e11146f9a202cf2ef2df1e7c8e2df5b8bfccc0622
# ❌ Calculated hash does NOT match the Base64-decoded hex!
# --------------------------------------------
