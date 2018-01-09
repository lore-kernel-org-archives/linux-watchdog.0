Return-Path: <lyude@redhat.com>
Return-path: <lyude@redhat.com>
Message-ID: <1515538687.4373.18.camel@redhat.com>
Subject: Re: [11/12] watchdog: sp5100-tco: Abort if watchdog is disabled by
 hardware
From: Lyude Paul <lyude@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?ISO-8859-1?Q?Zolt=E1n_B=F6sz=F6rm=E9nyi?=
	 <zboszor@pr.hu>
Date: Tue, 09 Jan 2018 17:58:07 -0500
In-Reply-To: <1514149457-20273-12-git-send-email-linux@roeck-us.net>
References: <1514149457-20273-12-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi! I'm the one from the Fedora bugzilla who said they'd help review these
patches. I might end up responding to this with a real review comment after
this message, but first:

mind cc'ing me future versions of this patchset and also, is there any way you
know of that one could figure out whether or not the sp5100_tco wdt is
actually disabled by the OEM on a board? I tried testing these patches with my
system and it appears to be convinced that it's disabled on my system, but I'm
hoping something in this patch is just broken…

motherboard in question is MSI A320M, CPU is a Ryzen 5 1700. Already checked
the bios, no related options in sight.

dmesg:

➜  ~ dmesg   
[    0.000000] Linux version 4.15.0-rc7Lyude-Test+ (lyudess@malachite) (gcc version 7.2.1 20170915 (Red Hat 7.2.1-2) (GCC)) #1 SMP Tue Jan 9 16:03:44 EST 2018
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.15.0-rc7Lyude-Test+ root=/dev/mapper/TestTowerGammaFedora26-root ro resume=/dev/dm-5 nmi_watchdog=1 oops=panic softlockup_panic=1 crashkernel=256M rd.driver.blacklist=nouveau,i2c_piix4 modprobe.blacklist=nouveau,i2c_piix4 nvidia-drm.modeset=1 LANG=en_US.UTF-8 consoleblank=30 nouveau.config=NvPmEnableGating=1 trace_options=trace_printk=1
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009d7ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009d80000-0x0000000009ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x00000000dd2fcfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dd2fd000-0x00000000dd3eafff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dd3eb000-0x00000000dd7dcfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dd7dd000-0x00000000dd8a8fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000dd8a9000-0x00000000de3e9fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000de3ea000-0x00000000deffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000df000000-0x00000000dfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fdf00000-0x00000000fdffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000fea0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec30000-0x00000000fec30fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedcffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedd4000-0x00000000fedd5fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021f37ffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x9f946018-0x9f954057] usable ==> usable
[    0.000000] e820: update [mem 0x9f946018-0x9f954057] usable ==> usable
[    0.000000] e820: update [mem 0x9f926018-0x9f945a57] usable ==> usable
[    0.000000] e820: update [mem 0x9f926018-0x9f945a57] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009d7ffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009d80000-0x0000000009ffffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000a000000-0x000000009f926017] usable
[    0.000000] reserve setup_data: [mem 0x000000009f926018-0x000000009f945a57] usable
[    0.000000] reserve setup_data: [mem 0x000000009f945a58-0x000000009f946017] usable
[    0.000000] reserve setup_data: [mem 0x000000009f946018-0x000000009f954057] usable
[    0.000000] reserve setup_data: [mem 0x000000009f954058-0x00000000dd2fcfff] usable
[    0.000000] reserve setup_data: [mem 0x00000000dd2fd000-0x00000000dd3eafff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000dd3eb000-0x00000000dd7dcfff] usable
[    0.000000] reserve setup_data: [mem 0x00000000dd7dd000-0x00000000dd8a8fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000dd8a9000-0x00000000de3e9fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000de3ea000-0x00000000deffffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000df000000-0x00000000dfffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fdf00000-0x00000000fdffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fea00000-0x00000000fea0ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec30000-0x00000000fec30fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fedc2000-0x00000000fedcffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fedd4000-0x00000000fedd5fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000feefffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000021f37ffff] usable
[    0.000000] efi: EFI v2.60 by American Megatrends
[    0.000000] efi:  ACPI 2.0=0xdd7dd000  ACPI=0xdd7dd000  SMBIOS=0xde29b000  ESRT=0xdb15b418  MEMATTR=0xd8c88018 
[    0.000000] random: fast init done
[    0.000000] SMBIOS 3.0 present.
[    0.000000] DMI: MSI MS-7A39/A320M GAMING PRO (MS-7A39), BIOS 1.60 09/19/2017
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x21f380 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFE0000000 write-back
[    0.000000]   3 base 0000DF000000 mask FFFFFF000000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 0000000220000000 aka 8704M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: update [mem 0xdf000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xdf000 max_arch_pfn = 0x400000000
[    0.000000] esrt: Reserving ESRT space from 0x00000000db15b418 to 0x00000000db15b450.
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [        (ptrval)] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x03672000, 0x03672fff] PGTABLE
[    0.000000] BRK [0x03673000, 0x03673fff] PGTABLE
[    0.000000] BRK [0x03674000, 0x03674fff] PGTABLE
[    0.000000] BRK [0x03675000, 0x03675fff] PGTABLE
[    0.000000] BRK [0x03676000, 0x03676fff] PGTABLE
[    0.000000] BRK [0x03677000, 0x03677fff] PGTABLE
[    0.000000] Secure boot disabled
[    0.000000] RAMDISK: [mem 0x3d2b7000-0x3e614fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000DD7DD000 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000DD7DD098 0000B4 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000DD7E2F40 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0x0000000000000000/0x1 (20170831/tbfadt-658)
[    0.000000] ACPI: DSDT 0x00000000DD7DD1E8 005D53 (v02 ALASKA A M I    01072009 INTL 20120913)
[    0.000000] ACPI: FACS 0x00000000DD892E00 000040
[    0.000000] ACPI: APIC 0x00000000DD7E3058 0000DE (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000DD7E3138 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x00000000DD7E3180 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000DD7E3220 008C4C (v02 AMD    AMD ALIB 00000002 MSFT 04000000)
[    0.000000] ACPI: SSDT 0x00000000DD7EBE70 001084 (v01 AMD    AMD CPU  00000001 AMD  00000001)
[    0.000000] ACPI: CRAT 0x00000000DD7ECEF8 000850 (v01 AMD    AMD CRAT 00000001 AMD  00000001)
[    0.000000] ACPI: CDIT 0x00000000DD7ED748 000029 (v01 AMD    AMD CDIT 00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x00000000DD7ED778 0017B7 (v01 AMD    AMD AOD  00000001 INTL 20120913)
[    0.000000] ACPI: MCFG 0x00000000DD7EEF30 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x00000000DD7EEF70 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: SSDT 0x00000000DD7EEFA8 000024 (v01 AMDFCH FCHZP    00001000 INTL 20120913)
[    0.000000] ACPI: UEFI 0x00000000DD7EEFD0 000042 (v01                 00000000      00000000)
[    0.000000] ACPI: IVRS 0x00000000DD7EF018 0000D0 (v02 AMD    AMD IVRS 00000001 AMD  00000000)
[    0.000000] ACPI: BGRT 0x00000000DD7EF0E8 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: BGRT 0x00000000DD7EF120 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000DD7EF158 0000F8 (v01 AMD    AMD PT   00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000DD7EF250 001664 (v01 AMD    CPMCMN   00000001 INTL 20120913)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Reserving 256MB of memory at 640MB for crashkernel (System RAM: 8147MB)
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] tsc: Using PIT calibration value
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000021f37ffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000009d7ffff]
[    0.000000]   node   0: [mem 0x000000000a000000-0x00000000dd2fcfff]
[    0.000000]   node   0: [mem 0x00000000dd3eb000-0x00000000dd7dcfff]
[    0.000000]   node   0: [mem 0x00000000de3ea000-0x00000000deffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000021f37ffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000021f37ffff]
[    0.000000] On node 0 totalpages: 2085796
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 23 pages reserved
[    0.000000]   DMA zone: 3999 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14147 pages used for memmap
[    0.000000]   DMA32 zone: 905349 pages, LIFO batch:31
[    0.000000]   Normal zone: 18382 pages used for memmap
[    0.000000]   Normal zone: 1176448 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 97 pages
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 9, version 33, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 10, version 33, address 0xfec01000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.000000] smpboot: 16 Processors exceeds NR_CPUS limit of 8
[    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x09d80000-0x09ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x9f926000-0x9f926fff]
[    0.000000] PM: Registered nosave memory: [mem 0x9f945000-0x9f945fff]
[    0.000000] PM: Registered nosave memory: [mem 0x9f946000-0x9f946fff]
[    0.000000] PM: Registered nosave memory: [mem 0x9f954000-0x9f954fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdd2fd000-0xdd3eafff]
[    0.000000] PM: Registered nosave memory: [mem 0xdd7dd000-0xdd8a8fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdd8a9000-0xde3e9fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdf000000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfdefffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfdf00000-0xfdffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe000000-0xfe9fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfea00000-0xfea0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfea10000-0xfeb7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeb80000-0xfec01fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec02000-0xfec0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec11000-0xfec2ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec30000-0xfec30fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec31000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfed3ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed40000-0xfed44fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed45000-0xfed7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed80000-0xfed8ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed90000-0xfedc1fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedc2000-0xfedcffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedd0000-0xfedd3fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedd4000-0xfedd5fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedd6000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfeefffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfef00000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0xe0000000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] percpu: Embedded 43 pages/cpu @        (ptrval) s138136 r8192 d29800 u262144
[    0.000000] pcpu-alloc: s138136 r8192 d29800 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 2053180
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.15.0-rc7Lyude-Test+ root=/dev/mapper/TestTowerGammaFedora26-root ro resume=/dev/dm-5 nmi_watchdog=1 oops=panic softlockup_panic=1 crashkernel=256M rd.driver.blacklist=nouveau,i2c_piix4 modprobe.blacklist=nouveau,i2c_piix4 nvidia-drm.modeset=1 LANG=en_US.UTF-8 consoleblank=30 nouveau.config=NvPmEnableGating=1 trace_options=trace_printk=1
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Memory: 7782084K/8343184K available (10252K kernel code, 1192K rwdata, 3304K rodata, 1408K init, 860K bss, 561100K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] ftrace: allocating 30764 entries in 121 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] NR_IRQS: 4352, nr_irqs: 1032, preallocated irqs: 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20170831
[    0.000000] ACPI: 7 ACPI AML tables successfully acquired and loaded
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.005000] tsc: Fast TSC calibration failed
[    0.007000] tsc: PIT calibration matches HPET. 1 loops
[    0.007000] tsc: Detected 3199.490 MHz processor
[    0.007000] Calibrating delay loop (skipped), value calculated using timer frequency.. 6398.98 BogoMIPS (lpj=3199490)
[    0.007000] pid_max: default: 32768 minimum: 301
[    0.008016] Security Framework initialized
[    0.008017] Yama: becoming mindful.
[    0.008037] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.008050] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.008168] CPU: Physical Processor ID: 0
[    0.008169] CPU: Processor Core ID: 0
[    0.008176] mce: CPU supports 23 MCE banks
[    0.008194] LVT offset 1 assigned for vector 0xf9
[    0.008317] LVT offset 2 assigned for vector 0xf4
[    0.008329] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.008331] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[    0.008404] Freeing SMP alternatives memory: 32K
[    0.012000] smpboot: CPU0: AMD Ryzen 5 1400 Quad-Core Processor (family: 0x17, model: 0x1, stepping: 0x1)
[    0.012000] Performance Events: Fam17h core perfctr, AMD PMU driver.
[    0.012000] ... version:                0
[    0.012000] ... bit width:              48
[    0.012000] ... generic registers:      6
[    0.012000] ... value mask:             0000ffffffffffff
[    0.012000] ... max period:             00007fffffffffff
[    0.012000] ... fixed-purpose events:   0
[    0.012000] ... event mask:             000000000000003f
[    0.012000] Hierarchical SRCU implementation.
[    0.012000] smp: Bringing up secondary CPUs ...
[    0.012000] x86: Booting SMP configuration:
[    0.012000] .... node  #0, CPUs:      #1
[    0.012025] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.012113]  #2 #3 #4 #5 #6 #7
[    0.019020] smp: Brought up 1 node, 8 CPUs
[    0.019020] smpboot: Max logical packages: 1
[    0.019020] smpboot: Total of 8 processors activated (51191.84 BogoMIPS)
[    0.020781] devtmpfs: initialized
[    0.021057] PM: Registering ACPI NVS region [mem 0xdd7dd000-0xdd8a8fff] (835584 bytes)
[    0.021104] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.021104] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.021104] pinctrl core: initialized pinctrl subsystem
[    0.021130] RTC time: 22:20:06, date: 01/09/18
[    0.021198] NET: Registered protocol family 16
[    0.021282] audit: initializing netlink subsys (disabled)
[    0.021287] audit: type=2000 audit(1515536406.021:1): state=initialized audit_enabled=0 res=1
[    0.021287] cpuidle: using governor menu
[    0.021287] ACPI: bus type PCI registered
[    0.021287] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.021287] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.021287] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.021287] PCI: Using configuration type 1 for base access
[    0.022555] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.022555] ACPI: Added _OSI(Module Device)
[    0.022555] ACPI: Added _OSI(Processor Device)
[    0.022555] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.022555] ACPI: Added _OSI(Processor Aggregator Device)
[    0.022555] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.022555] ACPI: Executed 2 blocks of module-level executable AML code
[    0.031557] ACPI: Interpreter enabled
[    0.031572] ACPI: (supports S0 S3 S4 S5)
[    0.031574] ACPI: Using IOAPIC for interrupt routing
[    0.031715] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.032000] ACPI: Enabled 2 GPEs in block 00 to 1F
[    0.039683] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.039688] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.039919] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.039924] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.040261] PCI host bridge to bus 0000:00
[    0.040264] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.040266] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.040268] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.040270] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.040272] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.040275] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.040277] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xfec2ffff window]
[    0.040279] pci_bus 0000:00: root bus resource [mem 0xfee00000-0xffffffff window]
[    0.040281] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.040288] pci 0000:00:00.0: [1022:1450] type 00 class 0x060000
[    0.040365] pci 0000:00:00.2: [1022:1451] type 00 class 0x080600
[    0.040456] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
[    0.040524] pci 0000:00:01.3: [1022:1453] type 01 class 0x060400
[    0.040568] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
[    0.040634] pci 0000:00:02.0: [1022:1452] type 00 class 0x060000
[    0.040712] pci 0000:00:03.0: [1022:1452] type 00 class 0x060000
[    0.040776] pci 0000:00:03.1: [1022:1453] type 01 class 0x060400
[    0.040839] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.040916] pci 0000:00:04.0: [1022:1452] type 00 class 0x060000
[    0.040998] pci 0000:00:07.0: [1022:1452] type 00 class 0x060000
[    0.041063] pci 0000:00:07.1: [1022:1454] type 01 class 0x060400
[    0.041080] pci 0000:00:07.1: enabling Extended Tags
[    0.041102] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
[    0.041168] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
[    0.041231] pci 0000:00:08.1: [1022:1454] type 01 class 0x060400
[    0.041250] pci 0000:00:08.1: enabling Extended Tags
[    0.041272] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.041373] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.041587] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.041804] pci 0000:00:18.0: [1022:1460] type 00 class 0x060000
[    0.041858] pci 0000:00:18.1: [1022:1461] type 00 class 0x060000
[    0.041910] pci 0000:00:18.2: [1022:1462] type 00 class 0x060000
[    0.041963] pci 0000:00:18.3: [1022:1463] type 00 class 0x060000
[    0.042016] pci 0000:00:18.4: [1022:1464] type 00 class 0x060000
[    0.042068] pci 0000:00:18.5: [1022:1465] type 00 class 0x060000
[    0.042121] pci 0000:00:18.6: [1022:1466] type 00 class 0x060000
[    0.042173] pci 0000:00:18.7: [1022:1467] type 00 class 0x060000
[    0.042281] pci 0000:03:00.0: [1022:43bc] type 00 class 0x0c0330
[    0.042301] pci 0000:03:00.0: reg 0x10: [mem 0xfd6a0000-0xfd6a7fff 64bit]
[    0.042372] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    0.042420] pci 0000:03:00.1: [1022:43b8] type 00 class 0x010601
[    0.042462] pci 0000:03:00.1: reg 0x24: [mem 0xfd680000-0xfd69ffff]
[    0.042469] pci 0000:03:00.1: reg 0x30: [mem 0xfd600000-0xfd67ffff pref]
[    0.042504] pci 0000:03:00.1: PME# supported from D3hot D3cold
[    0.042541] pci 0000:03:00.2: [1022:43b3] type 01 class 0x060400
[    0.042609] pci 0000:03:00.2: PME# supported from D3hot D3cold
[    0.045020] pci 0000:00:01.3: PCI bridge to [bus 03-21]
[    0.045026] pci 0000:00:01.3:   bridge window [io  0xf000-0xffff]
[    0.045028] pci 0000:00:01.3:   bridge window [mem 0xfd500000-0xfd6fffff]
[    0.045093] pci 0000:04:04.0: [1022:43b4] type 01 class 0x060400
[    0.045177] pci 0000:04:04.0: PME# supported from D3hot D3cold
[    0.045232] pci 0000:04:05.0: [1022:43b4] type 01 class 0x060400
[    0.045315] pci 0000:04:05.0: PME# supported from D3hot D3cold
[    0.045365] pci 0000:04:06.0: [1022:43b4] type 01 class 0x060400
[    0.045445] pci 0000:04:06.0: PME# supported from D3hot D3cold
[    0.045489] pci 0000:04:07.0: [1022:43b4] type 01 class 0x060400
[    0.045568] pci 0000:04:07.0: PME# supported from D3hot D3cold
[    0.045622] pci 0000:03:00.2: PCI bridge to [bus 04-21]
[    0.045628] pci 0000:03:00.2:   bridge window [io  0xf000-0xffff]
[    0.045630] pci 0000:03:00.2:   bridge window [mem 0xfd500000-0xfd5fffff]
[    0.045681] pci 0000:1e:00.0: [10ec:8168] type 00 class 0x020000
[    0.045721] pci 0000:1e:00.0: reg 0x10: [io  0xf000-0xf0ff]
[    0.045757] pci 0000:1e:00.0: reg 0x18: [mem 0xfd504000-0xfd504fff 64bit]
[    0.045778] pci 0000:1e:00.0: reg 0x20: [mem 0xfd500000-0xfd503fff 64bit]
[    0.045901] pci 0000:1e:00.0: supports D1 D2
[    0.045902] pci 0000:1e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.049037] pci 0000:04:04.0: PCI bridge to [bus 1e]
[    0.049045] pci 0000:04:04.0:   bridge window [io  0xf000-0xffff]
[    0.049048] pci 0000:04:04.0:   bridge window [mem 0xfd500000-0xfd5fffff]
[    0.049089] pci 0000:04:05.0: PCI bridge to [bus 1f]
[    0.049132] pci 0000:04:06.0: PCI bridge to [bus 20]
[    0.049173] pci 0000:04:07.0: PCI bridge to [bus 21]
[    0.049257] pci 0000:22:00.0: [10de:1004] type 00 class 0x030000
[    0.049284] pci 0000:22:00.0: reg 0x10: [mem 0xfc000000-0xfcffffff]
[    0.049298] pci 0000:22:00.0: reg 0x14: [mem 0xe8000000-0xefffffff 64bit pref]
[    0.049311] pci 0000:22:00.0: reg 0x1c: [mem 0xf0000000-0xf1ffffff 64bit pref]
[    0.049320] pci 0000:22:00.0: reg 0x24: [io  0xe000-0xe07f]
[    0.049329] pci 0000:22:00.0: reg 0x30: [mem 0xfd000000-0xfd07ffff pref]
[    0.049343] pci 0000:22:00.0: BAR 1: assigned to efifb
[    0.049450] pci 0000:22:00.1: [10de:0e1a] type 00 class 0x040300
[    0.049467] pci 0000:22:00.1: reg 0x10: [mem 0xfd080000-0xfd083fff]
[    0.052026] pci 0000:00:03.1: PCI bridge to [bus 22]
[    0.052033] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
[    0.052036] pci 0000:00:03.1:   bridge window [mem 0xfc000000-0xfd0fffff]
[    0.052039] pci 0000:00:03.1:   bridge window [mem 0xe8000000-0xf1ffffff 64bit pref]
[    0.052095] pci 0000:23:00.0: [1022:145a] type 00 class 0x130000
[    0.052120] pci 0000:23:00.0: enabling Extended Tags
[    0.052176] pci 0000:23:00.2: [1022:1456] type 00 class 0x108000
[    0.052189] pci 0000:23:00.2: reg 0x18: [mem 0xfd300000-0xfd3fffff]
[    0.052197] pci 0000:23:00.2: reg 0x24: [mem 0xfd400000-0xfd401fff]
[    0.052203] pci 0000:23:00.2: enabling Extended Tags
[    0.052262] pci 0000:23:00.3: [1022:145c] type 00 class 0x0c0330
[    0.052274] pci 0000:23:00.3: reg 0x10: [mem 0xfd200000-0xfd2fffff 64bit]
[    0.052294] pci 0000:23:00.3: enabling Extended Tags
[    0.052320] pci 0000:23:00.3: PME# supported from D0 D3hot D3cold
[    0.052369] pci 0000:00:07.1: PCI bridge to [bus 23]
[    0.052374] pci 0000:00:07.1:   bridge window [mem 0xfd200000-0xfd4fffff]
[    0.052418] pci 0000:24:00.0: [1022:1455] type 00 class 0x130000
[    0.052444] pci 0000:24:00.0: enabling Extended Tags
[    0.052493] pci 0000:24:00.2: [1022:7901] type 00 class 0x010601
[    0.052519] pci 0000:24:00.2: reg 0x24: [mem 0xfd708000-0xfd708fff]
[    0.052525] pci 0000:24:00.2: enabling Extended Tags
[    0.052551] pci 0000:24:00.2: PME# supported from D3hot D3cold
[    0.052583] pci 0000:24:00.3: [1022:1457] type 00 class 0x040300
[    0.052591] pci 0000:24:00.3: reg 0x10: [mem 0xfd700000-0xfd707fff]
[    0.052609] pci 0000:24:00.3: enabling Extended Tags
[    0.052633] pci 0000:24:00.3: PME# supported from D0 D3hot D3cold
[    0.052674] pci 0000:00:08.1: PCI bridge to [bus 24]
[    0.052679] pci 0000:00:08.1:   bridge window [mem 0xfd700000-0xfd7fffff]
[    0.052695] pci_bus 0000:00: on NUMA node 0
[    0.053100] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    0.053159] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    0.053210] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    0.053273] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    0.053330] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    0.053377] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    0.053424] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    0.053471] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    0.054010] pci 0000:22:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.054014] pci 0000:22:00.0: vgaarb: bridge control possible
[    0.054015] pci 0000:22:00.0: vgaarb: setting as boot device
[    0.054017] vgaarb: loaded
[    0.054064] SCSI subsystem initialized
[    0.054070] libata version 3.00 loaded.
[    0.054081] ACPI: bus type USB registered
[    0.054090] usbcore: registered new interface driver usbfs
[    0.054096] usbcore: registered new interface driver hub
[    0.054096] usbcore: registered new device driver usb
[    0.054096] pps_core: LinuxPPS API ver. 1 registered
[    0.054096] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.054096] PTP clock support registered
[    0.054096] EDAC MC: Ver: 3.0.0
[    0.054110] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    0.054116] Registered efivars operations
[    0.078578] PCI: Using ACPI for IRQ routing
[    0.081800] PCI: pci_cache_line_size set to 64 bytes
[    0.081854] e820: reserve RAM buffer [mem 0x09d80000-0x0bffffff]
[    0.081855] e820: reserve RAM buffer [mem 0x9f926018-0x9fffffff]
[    0.081856] e820: reserve RAM buffer [mem 0x9f946018-0x9fffffff]
[    0.081856] e820: reserve RAM buffer [mem 0xdd2fd000-0xdfffffff]
[    0.081857] e820: reserve RAM buffer [mem 0xdd7dd000-0xdfffffff]
[    0.081857] e820: reserve RAM buffer [mem 0xdf000000-0xdfffffff]
[    0.081858] e820: reserve RAM buffer [mem 0x21f380000-0x21fffffff]
[    0.081914] NetLabel: Initializing
[    0.081916] NetLabel:  domain hash size = 128
[    0.081917] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.081929] NetLabel:  unlabeled traffic allowed by default
[    0.082032] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.082035] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.085023] clocksource: Switched to clocksource hpet
[    0.090112] VFS: Disk quotas dquot_6.6.0
[    0.090128] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.090172] pnp: PnP ACPI init
[    0.090289] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.090294] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.090349] system 00:01: [mem 0xfeb80000-0xfebfffff] has been reserved
[    0.090353] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.090429] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.090577] system 00:03: [io  0x0a00-0x0a0f] has been reserved
[    0.090579] system 00:03: [io  0x0a10-0x0a1f] has been reserved
[    0.090581] system 00:03: [io  0x0a20-0x0a2f] has been reserved
[    0.090583] system 00:03: [io  0x0a40-0x0a4f] has been reserved
[    0.090586] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.090898] pnp 00:04: [dma 0 disabled]
[    0.090926] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.091115] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.091118] system 00:05: [io  0x040b] has been reserved
[    0.091120] system 00:05: [io  0x04d6] has been reserved
[    0.091121] system 00:05: [io  0x0c00-0x0c01] has been reserved
[    0.091123] system 00:05: [io  0x0c14] has been reserved
[    0.091125] system 00:05: [io  0x0c50-0x0c51] has been reserved
[    0.091126] system 00:05: [io  0x0c52] has been reserved
[    0.091128] system 00:05: [io  0x0c6c] has been reserved
[    0.091129] system 00:05: [io  0x0c6f] has been reserved
[    0.091131] system 00:05: [io  0x0cd0-0x0cd1] has been reserved
[    0.091133] system 00:05: [io  0x0cd2-0x0cd3] has been reserved
[    0.091134] system 00:05: [io  0x0cd4-0x0cd5] has been reserved
[    0.091136] system 00:05: [io  0x0cd6-0x0cd7] has been reserved
[    0.091138] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
[    0.091139] system 00:05: [io  0x0800-0x089f] has been reserved
[    0.091141] system 00:05: [io  0x0b00-0x0b0f] has been reserved
[    0.091143] system 00:05: [io  0x0b20-0x0b3f] has been reserved
[    0.091144] system 00:05: [io  0x0900-0x090f] has been reserved
[    0.091146] system 00:05: [io  0x0910-0x091f] has been reserved
[    0.091148] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.091150] system 00:05: [mem 0xfec01000-0xfec01fff] could not be reserved
[    0.091152] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.091154] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.091156] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    0.091158] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.091159] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.091163] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.091486] pnp: PnP ACPI: found 6 devices
[    0.098232] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.098281] pci 0000:04:04.0: PCI bridge to [bus 1e]
[    0.098284] pci 0000:04:04.0:   bridge window [io  0xf000-0xffff]
[    0.098288] pci 0000:04:04.0:   bridge window [mem 0xfd500000-0xfd5fffff]
[    0.098295] pci 0000:04:05.0: PCI bridge to [bus 1f]
[    0.098305] pci 0000:04:06.0: PCI bridge to [bus 20]
[    0.098314] pci 0000:04:07.0: PCI bridge to [bus 21]
[    0.098323] pci 0000:03:00.2: PCI bridge to [bus 04-21]
[    0.098326] pci 0000:03:00.2:   bridge window [io  0xf000-0xffff]
[    0.098330] pci 0000:03:00.2:   bridge window [mem 0xfd500000-0xfd5fffff]
[    0.098336] pci 0000:00:01.3: PCI bridge to [bus 03-21]
[    0.098338] pci 0000:00:01.3:   bridge window [io  0xf000-0xffff]
[    0.098341] pci 0000:00:01.3:   bridge window [mem 0xfd500000-0xfd6fffff]
[    0.098346] pci 0000:00:03.1: PCI bridge to [bus 22]
[    0.098348] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
[    0.098351] pci 0000:00:03.1:   bridge window [mem 0xfc000000-0xfd0fffff]
[    0.098354] pci 0000:00:03.1:   bridge window [mem 0xe8000000-0xf1ffffff 64bit pref]
[    0.098359] pci 0000:00:07.1: PCI bridge to [bus 23]
[    0.098362] pci 0000:00:07.1:   bridge window [mem 0xfd200000-0xfd4fffff]
[    0.098366] pci 0000:00:08.1: PCI bridge to [bus 24]
[    0.098369] pci 0000:00:08.1:   bridge window [mem 0xfd700000-0xfd7fffff]
[    0.098374] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.098375] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.098376] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.098376] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.098377] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.098378] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.098379] pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff window]
[    0.098379] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff window]
[    0.098380] pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
[    0.098381] pci_bus 0000:03: resource 1 [mem 0xfd500000-0xfd6fffff]
[    0.098382] pci_bus 0000:04: resource 0 [io  0xf000-0xffff]
[    0.098382] pci_bus 0000:04: resource 1 [mem 0xfd500000-0xfd5fffff]
[    0.098383] pci_bus 0000:1e: resource 0 [io  0xf000-0xffff]
[    0.098384] pci_bus 0000:1e: resource 1 [mem 0xfd500000-0xfd5fffff]
[    0.098385] pci_bus 0000:22: resource 0 [io  0xe000-0xefff]
[    0.098385] pci_bus 0000:22: resource 1 [mem 0xfc000000-0xfd0fffff]
[    0.098386] pci_bus 0000:22: resource 2 [mem 0xe8000000-0xf1ffffff 64bit pref]
[    0.098387] pci_bus 0000:23: resource 1 [mem 0xfd200000-0xfd4fffff]
[    0.098387] pci_bus 0000:24: resource 1 [mem 0xfd700000-0xfd7fffff]
[    0.098441] NET: Registered protocol family 2
[    0.098534] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.098600] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.098721] TCP: Hash tables configured (established 65536 bind 65536)
[    0.098746] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.098762] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.098801] NET: Registered protocol family 1
[    0.099022] PCI: CLS 64 bytes, default 64
[    0.099047] Unpacking initramfs...
[    0.339561] Freeing initrd memory: 19832K
[    0.339581] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.339584] software IO TLB [mem 0xd0d44000-0xd4d44000] (64MB) mapped at [00000000b02a4455-00000000214ba808]
[    0.339651] amd_uncore: AMD NB counters detected
[    0.339654] amd_uncore: AMD LLC counters detected
[    0.340861] Scanning for low memory corruption every 60 seconds
[    0.341316] Initialise system trusted keyrings
[    0.341362] workingset: timestamp_bits=62 max_order=21 bucket_order=0
[    0.341877] zbud: loaded
[    0.545600] NET: Registered protocol family 38
[    0.545603] Key type asymmetric registered
[    0.545605] Asymmetric key parser 'x509' registered
[    0.545624] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    0.545662] io scheduler noop registered
[    0.545663] io scheduler deadline registered
[    0.545686] io scheduler cfq registered (default)
[    0.545687] io scheduler mq-deadline registered
[    0.545689] io scheduler kyber registered
[    0.545903] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    0.546721] pcieport 0000:00:01.3: AER enabled with IRQ 25
[    0.546739] pcieport 0000:00:03.1: AER enabled with IRQ 26
[    0.546748] pcieport 0000:00:01.3: Signaling PME with IRQ 25
[    0.546757] pcieport 0000:00:03.1: Signaling PME with IRQ 26
[    0.546774] pcieport 0000:00:07.1: Signaling PME with IRQ 27
[    0.546790] pcieport 0000:00:08.1: Signaling PME with IRQ 29
[    0.546812] efifb: probing for efifb
[    0.546823] efifb: framebuffer at 0xe8000000, using 3072k, total 3072k
[    0.546825] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    0.546826] efifb: scrolling: redraw
[    0.546827] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.548038] Console: switching to colour frame buffer device 128x48
[    0.549190] fb0: EFI VGA frame buffer device
[    0.549254] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.549279] ACPI: Power Button [PWRB]
[    0.549308] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.549345] ACPI: Power Button [PWRF]
[    0.550228] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.571208] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.571599] Non-volatile memory driver v1.3
[    0.571635] Linux agpgart interface v0.103
[    0.572339] ahci 0000:03:00.1: version 3.0
[    0.572411] ahci 0000:03:00.1: SSS flag set, parallel bus scan disabled
[    0.572459] ahci 0000:03:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
[    0.572480] ahci 0000:03:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst 
[    0.572871] scsi host0: ahci
[    0.572969] scsi host1: ahci
[    0.573084] scsi host2: ahci
[    0.573190] scsi host3: ahci
[    0.573281] scsi host4: ahci
[    0.573379] scsi host5: ahci
[    0.573884] scsi host6: ahci
[    0.574386] scsi host7: ahci
[    0.574782] ata1: SATA max UDMA/133 abar m131072@0xfd680000 port 0xfd680100 irq 39
[    0.575191] ata2: SATA max UDMA/133 abar m131072@0xfd680000 port 0xfd680180 irq 39
[    0.575577] ata3: DUMMY
[    0.575955] ata4: DUMMY
[    0.576357] ata5: SATA max UDMA/133 abar m131072@0xfd680000 port 0xfd680300 irq 39
[    0.576736] ata6: SATA max UDMA/133 abar m131072@0xfd680000 port 0xfd680380 irq 39
[    0.577131] ata7: DUMMY
[    0.577503] ata8: DUMMY
[    0.577958] ahci 0000:24:00.2: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    0.578361] ahci 0000:24:00.2: flags: 64bit ncq sntf ilck led clo only pmp fbs pio 
[    0.578909] scsi host8: ahci
[    0.579318] ata9: SATA max UDMA/133 abar m4096@0xfd708000 port 0xfd708100 irq 41
[    0.579746] libphy: Fixed MDIO Bus: probed
[    0.580155] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    0.580570] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.581027] i8042: PNP: No PS/2 controller found.
[    0.581543] mousedev: PS/2 mouse device common for all mice
[    0.582057] rtc_cmos 00:02: RTC can wake from S4
[    0.582657] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.583116] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.583559] IR NEC protocol handler initialized
[    0.583992] IR RC5(x/sz) protocol handler initialized
[    0.584495] IR RC6 protocol handler initialized
[    0.584893] IR JVC protocol handler initialized
[    0.585287] IR Sony protocol handler initialized
[    0.585666] IR SANYO protocol handler initialized
[    0.586046] IR Sharp protocol handler initialized
[    0.586407] IR MCE Keyboard/mouse protocol handler initialized
[    0.586775] IR XMP protocol handler initialized
[    0.587164] device-mapper: uevent: version 1.0.3
[    0.587594] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel@redhat.com
[    0.588179] EFI Variables Facility v0.08 2004-May-17
[    0.614493] hidraw: raw HID events driver (C) Jiri Kosina
[    0.614964] drop_monitor: Initializing network drop monitor service
[    0.615425] ip_tables: (C) 2000-2006 Netfilter Core Team
[    0.616146] Initializing XFRM netlink socket
[    0.616637] NET: Registered protocol family 10
[    0.617327] Segment Routing with IPv6
[    0.617731] mip6: Mobile IPv6
[    0.618134] NET: Registered protocol family 17
[    0.625748] microcode: CPU0: patch_level=0x08001129
[    0.626270] microcode: CPU1: patch_level=0x08001129
[    0.626684] microcode: CPU2: patch_level=0x08001129
[    0.627118] microcode: CPU3: patch_level=0x08001129
[    0.627703] microcode: CPU4: patch_level=0x08001129
[    0.628109] microcode: CPU5: patch_level=0x08001129
[    0.628666] microcode: CPU6: patch_level=0x08001129
[    0.629144] microcode: CPU7: patch_level=0x08001129
[    0.629595] microcode: Microcode Update Driver: v2.2.
[    0.629602] AVX2 version of gcm_enc/dec engaged.
[    0.630430] AES CTR mode by8 optimization enabled
[    0.637862] sched_clock: Marking stable (637855879, 0)->(750301090, -112445211)
[    0.638614] registered taskstats version 1
[    0.638993] Loading compiled-in X.509 certificates
[    0.639382] zswap: loaded using pool lzo/zbud
[    0.643145] Key type big_key registered
[    0.643732]   Magic number: 2:251:350
[    0.644150] console [netcon0] enabled
[    0.644499] netconsole: network logging started
[    0.644927] rtc_cmos 00:02: setting system clock to 2018-01-09 22:20:07 UTC (1515536407)
[    0.887817] ata1: SATA link down (SStatus 0 SControl 300)
[    0.887818] ata9: SATA link down (SStatus 0 SControl 300)
[    1.199861] ata2: SATA link down (SStatus 0 SControl 300)
[    1.375502] tsc: Refined TSC clocksource calibration: 3199.998 MHz
[    1.375512] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e204823bcd, max_idle_ns: 440795224253 ns
[    1.671515] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.672109] ata5.00: ATA-11: TOSHIBA-TL100, SBFZ10.3, max UDMA/133
[    1.672553] ata5.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.673108] ata5.00: configured for UDMA/133
[    1.673662] scsi 4:0:0:0: Direct-Access     ATA      TOSHIBA-TL100    10.3 PQ: 0 ANSI: 5
[    1.674370] sd 4:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB/224 GiB)
[    1.674401] sd 4:0:0:0: Attached scsi generic sg0 type 0
[    1.675209] sd 4:0:0:0: [sda] Write Protect is off
[    1.675604] sd 4:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.675641] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.678218]  sda: sda1 sda2 sda3 sda4 sda5
[    1.679116] sd 4:0:0:0: [sda] Attached SCSI disk
[    1.983919] ata6: SATA link down (SStatus 0 SControl 300)
[    1.986428] Freeing unused kernel memory: 1408K
[    1.986821] Write protecting the kernel read-only data: 16384k
[    1.987735] Freeing unused kernel memory: 2016K
[    1.989708] Freeing unused kernel memory: 792K
[    1.990106] rodata_test: all tests were successful
[    2.062296] systemd[1]: systemd 234 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN default-hierarchy=hybrid)
[    2.075876] systemd[1]: Detected architecture x86-64.
[    2.076385] systemd[1]: Running in initial RAM disk.
[    2.078406] systemd[1]: Set hostname to <LyudeTestTowerGamma.usersys.redhat.com>.
[    2.105854] systemd[1]: Reached target Swap.
[    2.107022] systemd[1]: Listening on Journal Socket (/dev/log).
[    2.108202] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    2.109381] systemd[1]: Listening on Journal Audit Socket.
[    2.110549] systemd[1]: Reached target Paths.
[    2.111872] systemd[1]: Created slice System Slice.
[    2.124024] audit: type=1130 audit(1515536408.977:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.125944] audit: type=1130 audit(1515536408.979:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.155681] audit: type=1130 audit(1515536409.009:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.170844] audit: type=1130 audit(1515536409.024:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.188615] audit: type=1130 audit(1515536409.042:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.194499] audit: type=1130 audit(1515536409.048:7): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.230729] audit: type=1130 audit(1515536409.084:8): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.242030] QUIRK: Enable AMD PLL fix
[    2.242046] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    2.243071] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
[    2.245544] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    2.250161] r8169 0000:1e:00.0 eth0: RTL8168h/8111h at 0x00000000c4faa809, 4c:cc:6a:fe:e7:af, XID 14100800 IRQ 42
[    2.250981] r8169 0000:1e:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    2.265685] r8169 0000:1e:00.0 enp30s0: renamed from eth0
[    2.299310] xhci_hcd 0000:03:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x00000418
[    2.300180] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.300924] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.301696] usb usb1: Product: xHCI Host Controller
[    2.302474] usb usb1: Manufacturer: Linux 4.15.0-rc7Lyude-Test+ xhci-hcd
[    2.303256] usb usb1: SerialNumber: 0000:03:00.0
[    2.304155] hub 1-0:1.0: USB hub found
[    2.304925] hub 1-0:1.0: 9 ports detected
[    2.305991] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    2.306862] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 2
[    2.307841] xhci_hcd 0000:03:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    2.308762] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.309584] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    2.310660] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.311557] usb usb2: Product: xHCI Host Controller
[    2.312334] usb usb2: Manufacturer: Linux 4.15.0-rc7Lyude-Test+ xhci-hcd
[    2.313080] usb usb2: SerialNumber: 0000:03:00.0
[    2.313943] hub 2-0:1.0: USB hub found
[    2.314685] hub 2-0:1.0: 3 ports detected
[    2.315595] xhci_hcd 0000:23:00.3: xHCI Host Controller
[    2.316297] xhci_hcd 0000:23:00.3: new USB bus registered, assigned bus number 3
[    2.317080] xhci_hcd 0000:23:00.3: hcc params 0x0270f665 hci version 0x100 quirks 0x00000418
[    2.317855] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    2.318548] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.319215] usb usb3: Product: xHCI Host Controller
[    2.319860] usb usb3: Manufacturer: Linux 4.15.0-rc7Lyude-Test+ xhci-hcd
[    2.320509] usb usb3: SerialNumber: 0000:23:00.3
[    2.321212] hub 3-0:1.0: USB hub found
[    2.321843] hub 3-0:1.0: 4 ports detected
[    2.322594] xhci_hcd 0000:23:00.3: xHCI Host Controller
[    2.323191] xhci_hcd 0000:23:00.3: new USB bus registered, assigned bus number 4
[    2.323798] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.324425] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    2.325007] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.325596] usb usb4: Product: xHCI Host Controller
[    2.326160] usb usb4: Manufacturer: Linux 4.15.0-rc7Lyude-Test+ xhci-hcd
[    2.326737] usb usb4: SerialNumber: 0000:23:00.3
[    2.327381] hub 4-0:1.0: USB hub found
[    2.327946] hub 4-0:1.0: 4 ports detected
[    2.384222] clocksource: Switched to clocksource tsc
[    2.447911] PM: Starting manual resume from disk
[    2.448642] PM: Image not found (code -22)
[    2.449635] audit: type=1130 audit(1515536409.303:9): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hibernate-resume@dev-dm\x2d5 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.450808] audit: type=1131 audit(1515536409.303:10): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hibernate-resume@dev-dm\x2d5 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.485114] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: (null)
[    2.688149] usb 1-4: new low-speed USB device number 2 using xhci_hcd
[    2.713565] systemd-journald[217]: Received SIGTERM from PID 1 (systemd).
[    2.732574] systemd: 16 output lines suppressed due to ratelimiting
[    2.992705] usb 1-4: New USB device found, idVendor=04f2, idProduct=0112
[    2.993171] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.993613] usb 1-4: Product: USB Keyboard
[    2.994049] usb 1-4: Manufacturer: CHICONY
[    3.051682] EXT4-fs (dm-3): re-mounted. Opts: (null)
[    3.069307] systemd-journald[573]: Received request to flush runtime journal from PID 1
[    3.172137] usb 1-5: new low-speed USB device number 3 using xhci_hcd
[    3.210066] acpi_cpufreq: overriding BIOS provided _PSD data
[    3.237135] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    3.238281] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    3.239479] sp5100-tco sp5100-tco: Using 0xfed80b00 for watchdog MMIO address
[    3.240382] sp5100-tco sp5100-tco: Watchdog hardware is disabled
[    3.318840] Adding 8388604k swap on /dev/mapper/TestTowerGammaFedora26-swap.  Priority:-2 extents:1 across:8388604k SSFS
[    3.476505] usb 1-5: New USB device found, idVendor=093a, idProduct=2510
[    3.477703] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.478880] usb 1-5: Product: USB Optical Mouse
[    3.480067] usb 1-5: Manufacturer: PixArt
[    3.515819] input: CHICONY USB Keyboard as /devices/pci0000:00/0000:00:01.3/0000:03:00.0/usb1/1-4/1-4:1.0/0003:04F2:0112.0001/input/input2
[    3.570823] hid-generic 0003:04F2:0112.0001: input,hidraw0: USB HID v1.10 Keyboard [CHICONY USB Keyboard] on usb-0000:03:00.0-4/input0
[    3.583600] input: CHICONY USB Keyboard as /devices/pci0000:00/0000:00:01.3/0000:03:00.0/usb1/1-4/1-4:1.1/0003:04F2:0112.0002/input/input3
[    3.585753] hid-generic 0003:04F2:0112.0002: input,hidraw1: USB HID v1.10 Mouse [CHICONY USB Keyboard] on usb-0000:03:00.0-4/input1
[    3.597718] input: PixArt USB Optical Mouse as /devices/pci0000:00/0000:00:01.3/0000:03:00.0/usb1/1-5/1-5:1.0/0003:093A:2510.0003/input/input4
[    3.599444] hid-generic 0003:093A:2510.0003: input,hidraw2: USB HID v1.11 Mouse [PixArt USB Optical Mouse] on usb-0000:03:00.0-5/input0
[    3.601049] usbcore: registered new interface driver usbhid
[    3.601997] usbhid: USB HID core driver
[    3.769424] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[    3.769770] EXT4-fs (dm-4): mounted filesystem with ordered data mode. Opts: (null)
[    3.984655] random: crng init done
[    4.257961] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[    4.276201] r8169 0000:1e:00.0 enp30s0: link down
[    4.276204] r8169 0000:1e:00.0 enp30s0: link down
[    4.277336] IPv6: ADDRCONF(NETDEV_UP): enp30s0: link is not ready
[    7.857216] r8169 0000:1e:00.0 enp30s0: link up
[    7.857261] IPv6: ADDRCONF(NETDEV_CHANGE): enp30s0: link becomes ready

On Sun, 2017-12-24 at 13:04 -0800, Guenter Roeck wrote:
> If the watchdog control register indicates that the watchdog hardware
> is disabled even after we tried to enable it, there is no point to
> instantiate the driver.
> 
> Cc: Zoltán Böszörményi <zboszor@pr.hu>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/sp5100_tco.c | 8 +++++++-
>  drivers/watchdog/sp5100_tco.h | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index bb6c4608c1c0..23246cb40598 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -273,14 +273,20 @@ static int sp5100_tco_setupdevice(struct device *dev,
>  	/* Setup the watchdog timer */
>  	tco_timer_enable();
>  
> -	/* Check that the watchdog action is set to reset the system */
>  	val = readl(SP5100_WDT_CONTROL(tco->tcobase));
> +	if (val & SP5100_WDT_DISABLED) {
> +		dev_err(dev, "Watchdog hardware is disabled\n");
> +		ret = -ENODEV;
> +		goto unreg_region;
> +	}
> +
>  	/*
>  	 * Save WatchDogFired status, because WatchDogFired flag is
>  	 * cleared here.
>  	 */
>  	if (val & SP5100_WDT_FIRED)
>  		wdd->bootstatus = WDIOF_CARDRESET;
> +	/* Set watchdog action to reset the system */
>  	val &= ~SP5100_WDT_ACTION_RESET;
>  	writel(val, SP5100_WDT_CONTROL(tco->tcobase));
>  
> diff --git a/drivers/watchdog/sp5100_tco.h b/drivers/watchdog/sp5100_tco.h
> index ca0721c8d879..008b2094bd13 100644
> --- a/drivers/watchdog/sp5100_tco.h
> +++ b/drivers/watchdog/sp5100_tco.h
> @@ -19,6 +19,7 @@
>  #define SP5100_WDT_START_STOP_BIT	BIT(0)
>  #define SP5100_WDT_FIRED		BIT(1)
>  #define SP5100_WDT_ACTION_RESET		BIT(2)
> +#define SP5100_WDT_DISABLED		BIT(3)
>  #define SP5100_WDT_TRIGGER_BIT		BIT(7)
>  
>  #define SP5100_PM_IOPORTS_SIZE		0x02
-- 
Cheers,
	Lyude Paul
