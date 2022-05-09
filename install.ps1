$targetDir = "$env:LOCALAPPDATA\Microsoft\Windows\Cursors\Posy"

# Copy the files where we want them
New-Item -ItemType Directory -Path $targetDir -ErrorAction Ignore | Out-Null
gci | where Extension -Match ".(cur|ani)" | Copy-Item -Destination $targetDir | Out-Null

# create the data for the regsitry
# This order must be preserved, the regsitry uses the order of elements to assign them
$regParts = @(
    "$targetDir\posy_cursor.cur",
    "$targetDir\posy_help.cur",
    "$targetDir\posy_background_max_96.ani",
    "$targetDir\posy_wait_max_96.ani",
    "$targetDir\posy_precise.cur",
    "$targetDir\posy_beam.cur",
    "$targetDir\posy_pen.cur",
    "$targetDir\posy_forbidden.cur",
    "$targetDir\posy_size_NS.cur",
    "$targetDir\posy_size_EW.cur",
    "$targetDir\Posy_size_NwSe.cur",
    "$targetDir\posy_size_NeSw.cur",
    "$targetDir\posy_move.cur",
    "$targetDir\posy_alt.cur",
    "$targetDir\posy_hand.cur",
    "$targetDir\posy_pin.cur",
    "$targetDir\posy_person.cur"
)
$regString = $regParts -join ','

# Install the theme into the registry, so it can be selected from the 'themes -> cursor' settings menu
New-Item -Path 'HKCU:\Control Panel\Cursors' -Name Schemes -ErrorAction Ignore
Remove-ItemProperty -Path 'HKCU:\Control Panel\Cursors\Schemes' -Name 'Posy' -ErrorAction Ignore
New-ItemProperty `
    -Path 'HKCU:\Control Panel\Cursors\Schemes' `
    -Name 'Posy' -PropertyType 'String' `
    -Value $regString | Out-Null
