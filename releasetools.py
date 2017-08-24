import common

def FullOTA_InstallEnd(info):
  info.script.Print("Full OTA update, Writing x86qemu images...")
  # copy the data into the package.
  x86qemu_dat = info.input_zip.read("RADIO/x86qemu.dat")
  common.ZipWriteStr(info.output_zip, "x86qemu.dat", x86qemu_dat)

  # emit the script code to install this data on the device
  info.script.AppendExtra(
    """package_extract_file("x86qemu.dat", "/tmp/x86qemu.zip");""")
  info.script.AppendExtra(
    """x86qemu.reprogram("/tmp/x86qemu.zip", "/system/android-x86qemu");""")

def IncrementalOTA_InstallEnd(info):
  info.script.Print("Incremental OTA update, Writing x86qemu images...")
  # copy the data into the package.
  source_x86qemu_dat = info.source_zip.read("RADIO/x86qemu.dat")
  target_x86qemu_dat = info.target_zip.read("RADIO/x86qemu.dat")

  if source_x86qemu_dat == target_x86qemu_dat:
    # x86qemu.dat is unchanged from previous build; no
    # need to reprogram it
    return

  # include the new x86qemu.dat in the OTA package
  common.ZipWriteStr(info.output_zip, "x86qemu.dat", target_x86qemu_dat)

  # emit the script code to install this data on the device
  info.script.AppendExtra(
    """package_extract_file("x86qemu.dat", "/tmp/x86qemu.zip");""")
  info.script.AppendExtra(
    """x86qemu.reprogram("/tmp/x86qemu.zip", "/system/android-x86qemu");""")

