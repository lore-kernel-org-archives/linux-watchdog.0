Return-Path: <pbmilley@gmail.com>
Return-path: <pbmilley@gmail.com>
Subject: Fwd: [BUG]: Error accessing realtime clock
References: <1518537392.3719.1.camel@gmail.com>
From: Peter Milley <pbmilley@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-watchdog@vger.kernel.org
Message-ID: <b7db3cf1-b2db-b29e-346f-2db8130bec6d@gmail.com>
Date: Sat, 17 Feb 2018 18:09:20 -0500
MIME-Version: 1.0
In-Reply-To: <1518537392.3719.1.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
List-ID: <linux-watchdog@vger.kernel.org>

I'm forwarding to this list hoping that it's closer to the cause of the
issue.=C2=A0 I've included the previous discussion with the RTC maintaine=
rs
for reference (see the end of this message).

I have confirmed that the issue still exists in the 4.16 rc1 kernel, and
I can provide any updated details that might be required.

Thanks in advance.=C2=A0 Please feel free to contact me if there are any
other questions.

-Peter Milley

-------- Forwarded Message --------
Subject: 	[BUG]: Error accessing realtime clock
Date: 	Tue, 13 Feb 2018 10:56:32 -0500
From: 	Peter Milley <pbmilley@gmail.com>
Reply-To: 	pbmilley@gmail.com
To: 	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
<alexandre.belloni@free-electrons.com>
CC: 	linux-rtc@vger.kernel.org



I just verified that this problem is still present in the latest RC
kernel - 4.16.0-041600rc1-generic.

On Wed, 2018-01-24 at 19:12 -0500, Peter Milley wrote:
> [1.] One line summary of the problem:
> Error accessing realtime clock
>=20
> [2.] Full description of the problem/report:
> I was running a script previously that uses rtcwake which has since
> stopped working. The script automatically hibernates my laptop after
> a
> set period of time in sleep mode, and was working perfectly in kernel
> 4.10.0-37.
>=20
> In the process of troubleshooting, I discovered that the problem was
> with rtcwake which is complaining about /dev/rtc0 missing.
>=20
> Here is output from a sample rtcwake command:
>=20
> peter@haven:~$ rtcwake -m no -s 1300
> rtcwake: assuming RTC uses UTC ...
> rtcwake: /dev/rtc0: unable to find device: No such file or directory
>=20
> I verified that in fact, that directory is missing.
>=20
> I get the following RTC messages in dmesg when I boot the current
> kernel:
>=20
> peter@haven:~$ dmesg | grep -i rtc
> [ 0.089393] RTC time: 17:03:55, date: 11/01/17
> [ 1.238784] rtc_cmos 00:01: RTC can wake from S4
> [ 1.238794] rtc_cmos: probe of 00:01 failed with error -16
> [ 1.295459] hctosys: unable to open rtc device (rtc0)
>=20
> In researching the error, I found some suggestions to get further
> information with timedatectl and hwclock, so here are the results
> from
> those commands as well.
>=20
> Output of timedatectl:
>=20
> peter@haven:~$ timedatectl
>       Local time: Fri 2017-10-27 19:06:26 EDT
>   Universal time: Fri 2017-10-27 23:06:26 UTC
>         RTC time: n/a
>        Time zone: America/New_York (EDT, -0400)
>  Network time on: yes
> NTP synchronized: yes
>  RTC in local TZ: no
>=20
> Output of hwclock --debug:
>=20
> peter@haven:~$ sudo hwclock --debug
> [sudo] password for peter:
> hwclock from util-linux 2.30.1
> Trying to open: /dev/rtc0
> Trying to open: /dev/rtc
> Trying to open: /dev/misc/rtc
> No usable clock interface found.
> hwclock: Cannot access the Hardware Clock via any known method.
>=20
> More evidence to suggest this is a kernel bug: I live-booted a copy
> of
> Antergos Linux, which was using the Arch kernel 4.14.12-1-ARCH and it
> exhibited the same problem with the real time clock as Ubuntu 17.10.
>=20
> [3.] Keywords (i.e., modules, networking, kernel):
>=20
> [4.] Kernel version (from /proc/version):
> Linux version 4.15.0-041500rc9-generic (kernel@tangerine) (gcc
> version
> 7.2.0 (Ubuntu 7.2.0-8ubuntu3)) #201801212130 SMP Mon Jan 22 02:31:37
> UTC 2018
>=20
> [5.] Output of Oops.. message:
> No OOPs message.
>=20
> [6.] A small shell script or example program:
>=20
> [7.] Environment:
> Description:	Ubuntu 17.10
> Release:	17.10
>=20
> [7.1.] Software (add the output of the ver_linux script here):
> Linux haven 4.15.0-041500rc9-generic #201801212130 SMP Mon Jan 22
> 02:31:37 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
>=20
> GNU Make            	4.1
> Binutils            	2.29.1
> Util-linux          	2.30.1
> Mount               	2.30.1
> Module-init-tools   	24
> E2fsprogs           	1.43.5
> Pcmciautils         	018
> PPP                 	2.4.7
> Linux C Library     	2.26
> Dynamic linker (ldd)	2.26
> Linux C++ Library   	6.0.24
> Procps              	3.3.12
> Net-tools           	2.10
> Kbd                 	2.0.3
> Console-tools       	2.0.3
> Sh-utils            	8.26
> Udev                	234
> Wireless-tools      	30
> Modules Loaded      	aesni_intel aes_x86_64 ahci arc4 autofs4
> binfmt_misc bluetooth bnep btbcm btintel btrtl btusb ccm cfg80211
> cifs
> coretemp crc32_pclmul crct10dif_pclmul cryptd crypto_simd drm
> drm_kms_helper ecdh_generic fb_sys_fops fscache ghash_clmulni_intel
> glue_helper i2c_algo_bit i915 ideapad_laptop input_leds intel_cstate
> intel_powerclamp intel_rapl intel_rapl_perf ip6table_filter
> ip6_tables
> ip6t_REJECT ip6t_rt iptable_filter ip_tables ipt_REJECT irqbypass
> iwlmvm iwlwifi joydev kvm kvm_intel libahci libcrc32c lp lpc_ich
> mac80211 mac_hid md4 media mei mei_me memstick mii nf_conntrack
> nf_conntrack_broadcast nf_conntrack_ftp nf_conntrack_ipv4
> nf_conntrack_ipv6 nf_conntrack_netbios_ns nf_defrag_ipv4
> nf_defrag_ipv6
> nf_log_common nf_log_ipv4 nf_log_ipv6 nf_nat nf_nat_ftp
> nf_reject_ipv4
> nf_reject_ipv6 nls_iso8859_1 nls_utf8 parport parport_pc pcbc ppdev
> psmouse r8169 rfcomm rtsx_usb rtsx_usb_ms rtsx_usb_sdmmc serio_raw
> shpchp snd snd_hda_codec snd_hda_codec_conexant snd_hda_codec_generic
> snd_hda_codec_hdmi snd_hda_core snd_hda_intel snd_hwdep snd_pcm
> snd_rawmidi snd_seq snd_seq_device snd_seq_midi snd_seq_midi_event
> snd_timer soundcore sparse_keymap syscopyarea sysfillrect sysimgblt
> uvcvideo video videobuf2_core videobuf2_memops videobuf2_v4l2
> videobuf2_vmalloc videodev vmw_vmci vmw_vsock_vmci_transport vsock
> wmi
> x86_pkg_temp_thermal x_tables xt_addrtype xt_conntrack xt_hl xt_limit
> xt_LOG xt_tcpudp
>=20
> [7.2.] Processor information (from /proc/cpuinfo):
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 69
> model name	: Intel(R) Core(TM) i7-4510U CPU @ 2.00GHz
> stepping	: 1
> microcode	: 0x20
> cpu MHz		: 798.226
> cache size	: 4096 KB
> physical id	: 0
> siblings	: 4
> core id		: 0
> cpu cores	: 2
> apicid		: 0
> initial apicid	: 0
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep
> mtrr
> pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq
> dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 movbe popcnt tsc_deadline_timer aes xsave avx f16c
> rdrand
> lahf_lm abm cpuid_fault epb invpcid_single pti retpoline tpr_shadow
> vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2
> erms
> invpcid xsaveopt dtherm ida arat pln pts
> bugs		: cpu_meltdown spectre_v1 spectre_v2
> bogomips	: 5188.44
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 39 bits physical, 48 bits virtual
> power management:
>=20
> processor	: 1
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 69
> model name	: Intel(R) Core(TM) i7-4510U CPU @ 2.00GHz
> stepping	: 1
> microcode	: 0x20
> cpu MHz		: 798.571
> cache size	: 4096 KB
> physical id	: 0
> siblings	: 4
> core id		: 0
> cpu cores	: 2
> apicid		: 1
> initial apicid	: 1
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep
> mtrr
> pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq
> dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 movbe popcnt tsc_deadline_timer aes xsave avx f16c
> rdrand
> lahf_lm abm cpuid_fault epb invpcid_single pti retpoline tpr_shadow
> vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2
> erms
> invpcid xsaveopt dtherm ida arat pln pts
> bugs		: cpu_meltdown spectre_v1 spectre_v2
> bogomips	: 5188.44
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 39 bits physical, 48 bits virtual
> power management:
>=20
> processor	: 2
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 69
> model name	: Intel(R) Core(TM) i7-4510U CPU @ 2.00GHz
> stepping	: 1
> microcode	: 0x20
> cpu MHz		: 798.247
> cache size	: 4096 KB
> physical id	: 0
> siblings	: 4
> core id		: 1
> cpu cores	: 2
> apicid		: 2
> initial apicid	: 2
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep
> mtrr
> pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq
> dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 movbe popcnt tsc_deadline_timer aes xsave avx f16c
> rdrand
> lahf_lm abm cpuid_fault epb invpcid_single pti retpoline tpr_shadow
> vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2
> erms
> invpcid xsaveopt dtherm ida arat pln pts
> bugs		: cpu_meltdown spectre_v1 spectre_v2
> bogomips	: 5188.44
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 39 bits physical, 48 bits virtual
> power management:
>=20
> processor	: 3
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 69
> model name	: Intel(R) Core(TM) i7-4510U CPU @ 2.00GHz
> stepping	: 1
> microcode	: 0x20
> cpu MHz		: 798.326
> cache size	: 4096 KB
> physical id	: 0
> siblings	: 4
> core id		: 1
> cpu cores	: 2
> apicid		: 3
> initial apicid	: 3
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 13
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep
> mtrr
> pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> pbe
> syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
> rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq
> dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
> sse4_1 sse4_2 movbe popcnt tsc_deadline_timer aes xsave avx f16c
> rdrand
> lahf_lm abm cpuid_fault epb invpcid_single pti retpoline tpr_shadow
> vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2
> erms
> invpcid xsaveopt dtherm ida arat pln pts
> bugs		: cpu_meltdown spectre_v1 spectre_v2
> bogomips	: 5188.44
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 39 bits physical, 48 bits virtual
> power management:
>=20
> [7.3.] Module information (from /proc/modules):
> rfcomm 77824 2 - Live 0xffffffffc0f26000
> vmw_vsock_vmci_transport 28672 0 - Live 0xffffffffc0ef0000
> vsock 36864 1 vmw_vsock_vmci_transport,[permanent], Live
> 0xffffffffc0ee1000
> vmw_vmci 69632 1 vmw_vsock_vmci_transport, Live 0xffffffffc0ec8000
> md4 16384 0 - Live 0xffffffffc0ec0000
> nls_utf8 16384 1 - Live 0xffffffffc0e07000
> cifs 720896 2 - Live 0xffffffffc0e0f000
> fscache 61440 1 cifs, Live 0xffffffffc0df7000
> ccm 20480 6 - Live 0xffffffffc0deb000
> bnep 20480 2 - Live 0xffffffffc0d06000
> binfmt_misc 20480 1 - Live 0xffffffffc0cf3000
> nls_iso8859_1 16384 1 - Live 0xffffffffc0a89000
> intel_rapl 20480 0 - Live 0xffffffffc0d2a000
> x86_pkg_temp_thermal 16384 0 - Live 0xffffffffc0d1a000
> intel_powerclamp 16384 0 - Live 0xffffffffc0a84000
> snd_hda_codec_conexant 24576 1 - Live 0xffffffffc0be2000
> snd_hda_codec_hdmi 49152 1 - Live 0xffffffffc0cf9000
> snd_hda_codec_generic 73728 1 snd_hda_codec_conexant, Live
> 0xffffffffc0ce0000
> coretemp 16384 0 - Live 0xffffffffc0af9000
> snd_hda_intel 40960 8 - Live 0xffffffffc0dba000
> kvm_intel 204800 0 - Live 0xffffffffc0d42000
> snd_hda_codec 126976 4
> snd_hda_codec_conexant,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_h
> da
> _intel, Live 0xffffffffc0f4f000
> kvm 589824 1 kvm_intel, Live 0xffffffffc0c4b000
> irqbypass 16384 1 kvm, Live 0xffffffffc0bdd000
> crct10dif_pclmul 16384 0 - Live 0xffffffffc0bd8000
> crc32_pclmul 16384 0 - Live 0xffffffffc0a7f000
> uvcvideo 86016 0 - Live 0xffffffffc0ae3000
> videobuf2_vmalloc 16384 1 uvcvideo, Live 0xffffffffc0ade000
> videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0xffffffffc0a2f000
> videobuf2_v4l2 24576 1 uvcvideo, Live 0xffffffffc0a9b000
> videobuf2_core 40960 2 uvcvideo,videobuf2_v4l2, Live
> 0xffffffffc0a90000
> videodev 176128 3 uvcvideo,videobuf2_v4l2,videobuf2_core, Live
> 0xffffffffc0ab2000
> rtsx_usb_ms 20480 0 - Live 0xffffffffc0a34000
> media 40960 2 uvcvideo,videodev, Live 0xffffffffc0a24000
> memstick 16384 1 rtsx_usb_ms, Live 0xffffffffc0a1b000
> snd_hda_core 81920 5
> snd_hda_codec_conexant,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_h
> da
> _intel,snd_hda_codec, Live 0xffffffffc0a6a000
> ghash_clmulni_intel 16384 0 - Live 0xffffffffc0a16000
> arc4 16384 2 - Live 0xffffffffc0a11000
> ip6t_REJECT 16384 1 - Live 0xffffffffc0a0c000
> nf_reject_ipv6 16384 1 ip6t_REJECT, Live 0xffffffffc0bc3000
> pcbc 16384 0 - Live 0xffffffffc0bbe000
> btusb 45056 0 - Live 0xffffffffc0bcc000
> snd_hwdep 20480 1 snd_hda_codec, Live 0xffffffffc0aa3000
> iwlmvm 364544 0 - Live 0xffffffffc0bec000
> mac80211 778240 1 iwlmvm, Live 0xffffffffc0aff000
> btrtl 16384 1 btusb, Live 0xffffffffc0a02000
> aesni_intel 188416 4 - Live 0xffffffffc0a3b000
> btbcm 16384 1 btusb, Live 0xffffffffc0a07000
> btintel 16384 1 btusb, Live 0xffffffffc09fd000
> nf_log_ipv6 16384 10 - Live 0xffffffffc0944000
> snd_pcm 98304 4
> snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core, Live
> 0xffffffffc09e4000
> aes_x86_64 20480 1 aesni_intel, Live 0xffffffffc0aac000
> bluetooth 544768 31 rfcomm,bnep,btusb,btrtl,btbcm,btintel, Live
> 0xffffffffc095e000
> crypto_simd 16384 1 aesni_intel, Live 0xffffffffc0959000
> glue_helper 16384 1 aesni_intel, Live 0xffffffffc0954000
> cryptd 24576 3 ghash_clmulni_intel,aesni_intel,crypto_simd, Live
> 0xffffffffc0949000
> intel_cstate 20480 0 - Live 0xffffffffc08e7000
> ecdh_generic 24576 1 bluetooth, Live 0xffffffffc08e0000
> intel_rapl_perf 16384 0 - Live 0xffffffffc08b8000
> ideapad_laptop 32768 0 - Live 0xffffffffc093b000
> joydev 20480 0 - Live 0xffffffffc08da000
> input_leds 16384 0 - Live 0xffffffffc08c2000
> snd_seq_midi 16384 0 - Live 0xffffffffc07e1000
> snd_seq_midi_event 16384 1 snd_seq_midi, Live 0xffffffffc0804000
> sparse_keymap 16384 1 ideapad_laptop, Live 0xffffffffc07e6000
> iwlwifi 278528 1 iwlmvm, Live 0xffffffffc08f6000
> xt_hl 16384 22 - Live 0xffffffffc08bd000
> snd_rawmidi 32768 1 snd_seq_midi, Live 0xffffffffc08ed000
> wmi 24576 1 ideapad_laptop, Live 0xffffffffc07f5000
> snd_seq 65536 2 snd_seq_midi,snd_seq_midi_event, Live
> 0xffffffffc08c9000
> snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
> 0xffffffffc07ff000
> snd_timer 32768 2 snd_pcm,snd_seq, Live 0xffffffffc07d8000
> ip6t_rt 16384 3 - Live 0xffffffffc07c2000
> cfg80211 622592 3 iwlmvm,mac80211,iwlwifi, Live 0xffffffffc081f000
> snd 81920 27
> snd_hda_codec_conexant,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_h
> da
> _intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_de
> vi
> ce,snd_timer, Live 0xffffffffc080a000
> serio_raw 16384 0 - Live 0xffffffffc07b2000
> shpchp 36864 0 - Live 0xffffffffc07eb000
> soundcore 16384 1 snd, Live 0xffffffffc07d3000
> mei_me 40960 0 - Live 0xffffffffc07c8000
> lpc_ich 24576 0 - Live 0xffffffffc07bb000
> mei 90112 1 mei_me, Live 0xffffffffc079b000
> mac_hid 16384 0 - Live 0xffffffffc0796000
> nf_conntrack_ipv6 20480 11 - Live 0xffffffffc0790000
> nf_defrag_ipv6 36864 1 nf_conntrack_ipv6, Live 0xffffffffc0782000
> ipt_REJECT 16384 1 - Live 0xffffffffc077a000
> nf_reject_ipv4 16384 1 ipt_REJECT, Live 0xffffffffc0775000
> nf_log_ipv4 16384 10 - Live 0xffffffffc0770000
> nf_log_common 16384 2 nf_log_ipv6,nf_log_ipv4, Live
> 0xffffffffc076b000
> xt_LOG 16384 20 - Live 0xffffffffc0766000
> xt_limit 16384 21 - Live 0xffffffffc0761000
> xt_tcpudp 16384 18 - Live 0xffffffffc075c000
> xt_addrtype 16384 4 - Live 0xffffffffc0754000
> nf_conntrack_ipv4 16384 11 - Live 0xffffffffc074b000
> nf_defrag_ipv4 16384 1 nf_conntrack_ipv4, Live 0xffffffffc0743000
> xt_conntrack 16384 22 - Live 0xffffffffc073b000
> ip6table_filter 16384 1 - Live 0xffffffffc06e6000
> ip6_tables 28672 1 ip6table_filter, Live 0xffffffffc0722000
> nf_conntrack_netbios_ns 16384 0 - Live 0xffffffffc071d000
> nf_conntrack_broadcast 16384 1 nf_conntrack_netbios_ns, Live
> 0xffffffffc06e1000
> nf_nat_ftp 16384 0 - Live 0xffffffffc06d3000
> nf_nat 32768 1 nf_nat_ftp, Live 0xffffffffc06ec000
> nf_conntrack_ftp 20480 1 nf_nat_ftp, Live 0xffffffffc06be000
> nf_conntrack 131072 8
> nf_conntrack_ipv6,nf_conntrack_ipv4,xt_conntrack,nf_conntrack_netbios
> _n
> s,nf_conntrack_broadcast,nf_nat_ftp,nf_nat,nf_conntrack_ftp, Live
> 0xffffffffc06fc000
> libcrc32c 16384 2 nf_nat,nf_conntrack, Live 0xffffffffc06d9000
> parport_pc 32768 0 - Live 0xffffffffc06ca000
> ppdev 20480 0 - Live 0xffffffffc06c4000
> iptable_filter 16384 1 - Live 0xffffffffc0523000
> lp 20480 0 - Live 0xffffffffc0528000
> parport 49152 3 parport_pc,ppdev,lp, Live 0xffffffffc06b1000
> ip_tables 28672 1 iptable_filter, Live 0xffffffffc04f5000
> x_tables 40960 13
> ip6t_REJECT,xt_hl,ip6t_rt,ipt_REJECT,xt_LOG,xt_limit,xt_tcpudp,xt_add
> rt
> ype,xt_conntrack,ip6table_filter,ip6_tables,iptable_filter,ip_tables,
> Live 0xffffffffc04e5000
> autofs4 40960 2 - Live 0xffffffffc0457000
> rtsx_usb_sdmmc 28672 0 - Live 0xffffffffc03e9000
> rtsx_usb 20480 2 rtsx_usb_ms,rtsx_usb_sdmmc, Live 0xffffffffc06f6000
> i915 1581056 30 - Live 0xffffffffc052e000
> i2c_algo_bit 16384 1 i915, Live 0xffffffffc0466000
> drm_kms_helper 167936 1 i915, Live 0xffffffffc042d000
> syscopyarea 16384 1 drm_kms_helper, Live 0xffffffffc0426000
> sysfillrect 16384 1 drm_kms_helper, Live 0xffffffffc041f000
> sysimgblt 16384 1 drm_kms_helper, Live 0xffffffffc0418000
> fb_sys_fops 16384 1 drm_kms_helper, Live 0xffffffffc0413000
> r8169 81920 0 - Live 0xffffffffc03fe000
> ahci 36864 3 - Live 0xffffffffc03d8000
> psmouse 143360 0 - Live 0xffffffffc04ff000
> drm 397312 30 i915,drm_kms_helper, Live 0xffffffffc0483000
> mii 16384 1 r8169, Live 0xffffffffc047c000
> libahci 32768 1 ahci, Live 0xffffffffc046f000
> video 40960 2 ideapad_laptop,i915, Live 0xffffffffc03f3000
>=20
> [7.4.] Loaded driver and hardware information (/proc/ioports):
> 0000-0cf7 : PCI Bus 0000:00
>   0000-001f : dma1
>   0020-0021 : pic1
>   0040-0043 : timer0
>   0050-0053 : timer1
>   0060-0060 : keyboard
>   0062-0062 : PNP0C09:00
>     0062-0062 : EC data
>   0064-0064 : keyboard
>   0066-0066 : PNP0C09:00
>     0066-0066 : EC cmd
>   0070-0072 : wdat_wdt
>   0080-008f : dma page reg
>   00a0-00a1 : pic2
>   00c0-00df : dma2
>   00f0-00ff : fpu
>   0680-069f : pnp 00:00
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>   164e-164f : pnp 00:00
>   1800-1803 : ACPI PM1a_EVT_BLK
>   1804-1805 : ACPI PM1a_CNT_BLK
>   1808-180b : ACPI PM_TMR
>   1810-1815 : ACPI CPU throttle
>   1850-1850 : ACPI PM2_CNT_BLK
>   1854-1857 : pnp 00:02
>   1860-1862 : wdat_wdt
>   1868-186c : wdat_wdt
>   1872-1874 : wdat_wdt
>   1880-189f : ACPI GPE0_BLK
>   3000-3fff : PCI Bus 0000:01
>     3000-30ff : 0000:01:00.0
>       3000-30ff : r8169
>   4000-403f : 0000:00:02.0
>   4040-405f : 0000:00:1f.3
>   4060-407f : 0000:00:1f.2
>     4060-407f : ahci
>   4080-4087 : 0000:00:1f.2
>     4080-4087 : ahci
>   4088-408f : 0000:00:1f.2
>     4088-408f : ahci
>   4090-4093 : 0000:00:1f.2
>     4090-4093 : ahci
>   4094-4097 : 0000:00:1f.2
>     4094-4097 : ahci
>   ffff-ffff : pnp 00:00
>     ffff-ffff : pnp 00:00
>       ffff-ffff : pnp 00:00
>=20
> (/proc/iomem):
> 00000000-00000fff : Reserved
> 00001000-0006efff : System RAM
> 0006f000-0006ffff : Reserved
> 00070000-00087fff : System RAM
> 00088000-000bffff : Reserved
>   000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000c3fff : PCI Bus 0000:00
> 000c4000-000c7fff : PCI Bus 0000:00
> 000c8000-000cbfff : PCI Bus 0000:00
> 000cc000-000cffff : PCI Bus 0000:00
> 000d0000-000d3fff : PCI Bus 0000:00
> 000d4000-000d7fff : PCI Bus 0000:00
> 000d8000-000dbfff : PCI Bus 0000:00
> 000dc000-000dffff : PCI Bus 0000:00
> 000e0000-000e3fff : PCI Bus 0000:00
> 000e4000-000e7fff : PCI Bus 0000:00
> 000e8000-000ebfff : PCI Bus 0000:00
> 000ec000-000effff : PCI Bus 0000:00
> 000f0000-000fffff : System ROM
> 00100000-a56affff : System RAM
> a56b0000-a5eaffff : Reserved
> a5eb0000-aa6befff : System RAM
> aa6bf000-aa8befff : Unknown E820 type
> aa8bf000-aaebefff : Reserved
> aaebf000-aafbefff : ACPI Non-volatile Storage
> aafbf000-aaffefff : ACPI Tables
> aafff000-aaffffff : System RAM
> ab000000-af9fffff : Reserved
>   aba00000-af9fffff : Graphics Stolen Memory
> afa00000-feafffff : PCI Bus 0000:00
>   afa10000-afa1ffff : pnp 00:05
>   afa20000-afa20fff : pnp 00:05
>   b0000000-bfffffff : 0000:00:02.0
>   c0000000-c03fffff : 0000:00:02.0
>   c0400000-c04fffff : PCI Bus 0000:02
>     c0400000-c0401fff : 0000:02:00.0
>       c0400000-c0401fff : iwlwifi
>   c0500000-c05fffff : PCI Bus 0000:01
>     c0500000-c0503fff : 0000:01:00.0
>       c0500000-c0503fff : r8169
>     c0504000-c0504fff : 0000:01:00.0
>       c0504000-c0504fff : r8169
>   c0600000-c060ffff : 0000:00:14.0
>     c0600000-c060ffff : xhci-hcd
>   c0610000-c0613fff : 0000:00:03.0
>     c0610000-c0613fff : ICH HD audio
>   c0614000-c0617fff : 0000:00:1b.0
>     c0614000-c0617fff : ICH HD audio
>   c0618000-c061801f : 0000:00:16.0
>     c0618000-c061801f : mei_me
>   c0619000-c06190ff : 0000:00:1f.3
>   c061b000-c061b7ff : 0000:00:1f.2
>     c061b000-c061b7ff : ahci
>   c061c000-c061c3ff : 0000:00:1d.0
>     c061c000-c061c3ff : ehci_hcd
>   e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
>     e0000000-efffffff : Reserved
>       e0000000-efffffff : pnp 00:05
>   fe101000-fe112fff : Reserved
> feb00000-feb0ffff : Reserved
> fec00000-fec00fff : Reserved
>   fec00000-fec003ff : IOAPIC 0
> fed00000-fee00fff : Reserved
>   fed00000-fed003ff : HPET 0
>     fed00000-fed003ff : PNP0103:00
>   fed10000-fed17fff : pnp 00:05
>   fed18000-fed18fff : pnp 00:05
>   fed19000-fed19fff : pnp 00:05
>   fed1c000-fed1ffff : pnp 00:05
>     fed1f800-fed1f9ff : intel-spi
>   fed20000-fed3ffff : pnp 00:05
>   fed90000-fed93fff : pnp 00:05
>   fee00000-fee00fff : Local APIC
> ff000000-ffffffff : INT0800:00
>   ffc00000-ffffffff : Reserved
> 100000000-44f5fffff : System RAM
>   2b4800000-2b54031f0 : Kernel code
>   2b54031f1-2b5e695ff : Kernel data
>   2b60dd000-2b6338fff : Kernel bss
> 44f600000-44fffffff : RAM buffer
>=20
> [7.5.] PCI information ('lspci -vvv' as root):
> 00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller
> (rev
> 0b)
> 	Subsystem: Lenovo Haswell-ULT DRAM Controller
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
> 	Latency: 0
> 	Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
> 	Kernel driver in use: hsw_uncore
>=20
> 00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT
> Integrated Graphics Controller (rev 0b) (prog-if 00 [VGA controller])
> 	Subsystem: Lenovo Haswell-ULT Integrated Graphics Controller
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 45
> 	Region 0: Memory at c0000000 (64-bit, non-prefetchable)
> [size=3D4M]
> 	Region 2: Memory at b0000000 (64-bit, prefetchable) [size=3D256M]
> 	Region 4: I/O ports at 4000 [size=3D64]
> 	[virtual] Expansion ROM at 000c0000 [disabled] [size=3D128K]
> 	Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> 		Address: fee04004  Data: 4023
> 	Capabilities: [d0] Power Management version 2
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-
> ,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> 	Capabilities: [a4] PCI Advanced Features
> 		AFCap: TP+ FLR+
> 		AFCtrl: FLR-
> 		AFStatus: TP-
> 	Kernel driver in use: i915
> 	Kernel modules: i915
>=20
> 00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio
> Controller
> (rev 0b)
> 	Subsystem: Lenovo Haswell-ULT HD Audio Controller
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 49
> 	Region 0: Memory at c0610000 (64-bit, non-prefetchable)
> [size=3D16K]
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-
> ,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> 	Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> 		Address: fee04004  Data: 4024
> 	Capabilities: [70] Express (v1) Root Complex Integrated
> Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr- TransPend-
> 	Kernel driver in use: snd_hda_intel
> 	Kernel modules: snd_hda_intel
>=20
> 00:14.0 USB controller: Intel Corporation 8 Series USB xHCI HC (rev
> 04)
> (prog-if 30 [XHCI])
> 	Subsystem: Lenovo 8 Series USB xHCI HC
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
> > TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>=20
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 42
> 	Region 0: Memory at c0600000 (64-bit, non-prefetchable)
> [size=3D64K]
> 	Capabilities: [70] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0-
> ,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> 	Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
> 		Address: 00000000fee02004  Data: 4022
> 	Kernel driver in use: xhci_hcd
>=20
> 00:16.0 Communication controller: Intel Corporation 8 Series HECI #0
> (rev 04)
> 	Subsystem: Lenovo 8 Series HECI
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 46
> 	Region 0: Memory at c0618000 (64-bit, non-prefetchable)
> [size=3D32]
> 	Capabilities: [50] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-
> ,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> 	Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> 		Address: 00000000fee08004  Data: 4023
> 	Kernel driver in use: mei_me
> 	Kernel modules: mei_me
>=20
> 00:1b.0 Audio device: Intel Corporation 8 Series HD Audio Controller
> (rev 04)
> 	Subsystem: Lenovo 8 Series HD Audio Controller
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 48
> 	Region 0: Memory at c0614000 (64-bit, non-prefetchable)
> [size=3D16K]
> 	Capabilities: [50] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-
> ,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> 	Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> 		Address: 00000000fee02004  Data: 4024
> 	Capabilities: [70] Express (v1) Root Complex Integrated
> Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE-
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+ TransPend-
> 	Capabilities: [100 v1] Virtual Channel
> 		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
> 		Arb:	Fixed- WRR32- WRR64- WRR128-
> 		Ctrl:	ArbSelect=3DFixed
> 		Status:	InProgress-
> 		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1
> RejSnoopTrans-
> 			Arb:	Fixed- WRR32- WRR64- WRR128-
> TWRR128- WRR256-
> 			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed
> TC/VC=3Dff
> 			Status:	NegoPending- InProgress-
> 		VC1:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1
> RejSnoopTrans-
> 			Arb:	Fixed- WRR32- WRR64- WRR128-
> TWRR128- WRR256-
> 			Ctrl:	Enable- ID=3D0 ArbSelect=3DFixed
> TC/VC=3D00
> 			Status:	NegoPending- InProgress-
> 	Kernel driver in use: snd_hda_intel
> 	Kernel modules: snd_hda_intel
>=20
> 00:1c.0 PCI bridge: Intel Corporation 8 Series PCI Express Root Port
> 3
> (rev e4) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin C routed to IRQ 40
> 	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
> 	I/O behind bridge: 00003000-00003fff
> 	Memory behind bridge: c0500000-c05fffff
> 	Prefetchable memory behind bridge: 00000000fff00000-
> 00000000000fffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+ TransPend-
> 		LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM L0s
> L1, Exit Latency L0s <512ns, L1 <16us
> 			ClockPM- Surprise- LLActRep+ BwNot+
> ASPMOptComp-
> 		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled-
> CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
> 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
> HotPlug- Surprise-
> 			Slot #2, PowerLimit 10.000W; Interlock-
> NoCompl+
> 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet-
> CmdCplt- HPIrq- LinkChg-
> 			Control: AttnInd Unknown, PwrInd Unknown,
> Power- Interlock-
> 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt-
> PresDet+ Interlock-
> 			Changed: MRL- PresDet- LinkState+
> 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> PMEIntEna+ CRSVisible-
> 		RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range ABC, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> ,=20
> LTR-, OBFF Disabled ARIFwd-
> 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-
> SpeedDis-
> 			 Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
> 	Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> 		Address: fee04004  Data: 4021
> 	Capabilities: [90] Subsystem: Lenovo 8 Series PCI Express Root
> Port 3
> 	Capabilities: [a0] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-
> ,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> 	Capabilities: [100 v0] #00
> 	Capabilities: [200 v1] L1 PM Substates
> 		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> ASPM_L1.1+ L1_PM_Substates+
> 			  PortCommonModeRestoreTime=3D40us
> PortTPowerOnTime=3D10us
> 		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2-
> ASPM_L1.1-
> 			   T_CommonMode=3D150us LTR1.2_Threshold=3D163840ns
> 		L1SubCtl2: T_PwrOn=3D150us
> 	Kernel driver in use: pcieport
> 	Kernel modules: shpchp
>=20
> 00:1c.3 PCI bridge: Intel Corporation 8 Series PCI Express Root Port
> 4
> (rev e4) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin D routed to IRQ 41
> 	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: c0400000-c04fffff
> 	Prefetchable memory behind bridge: 00000000fff00000-
> 00000000000fffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+ TransPend-
> 		LnkCap:	Port #4, Speed 5GT/s, Width x1, ASPM L0s
> L1, Exit Latency L0s <512ns, L1 <16us
> 			ClockPM- Surprise- LLActRep+ BwNot+
> ASPMOptComp-
> 		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled-
> CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
> 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
> HotPlug- Surprise-
> 			Slot #3, PowerLimit 10.000W; Interlock-
> NoCompl+
> 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet-
> CmdCplt- HPIrq- LinkChg-
> 			Control: AttnInd Unknown, PwrInd Unknown,
> Power- Interlock-
> 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt-
> PresDet+ Interlock-
> 			Changed: MRL- PresDet- LinkState+
> 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> PMEIntEna+ CRSVisible-
> 		RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range ABC, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> ,=20
> LTR-, OBFF Disabled ARIFwd-
> 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-
> SpeedDis-
> 			 Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
> 	Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> 		Address: fee08004  Data: 4021
> 	Capabilities: [90] Subsystem: Lenovo 8 Series PCI Express Root
> Port 4
> 	Capabilities: [a0] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-
> ,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> 	Capabilities: [100 v0] #00
> 	Capabilities: [200 v1] L1 PM Substates
> 		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> ASPM_L1.1+ L1_PM_Substates+
> 			  PortCommonModeRestoreTime=3D40us
> PortTPowerOnTime=3D10us
> 		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> ASPM_L1.1+
> 			   T_CommonMode=3D40us LTR1.2_Threshold=3D163840ns
> 		L1SubCtl2: T_PwrOn=3D60us
> 	Kernel driver in use: pcieport
> 	Kernel modules: shpchp
>=20
> 00:1d.0 USB controller: Intel Corporation 8 Series USB EHCI #1 (rev
> 04)
> (prog-if 20 [EHCI])
> 	Subsystem: Lenovo 8 Series USB EHCI
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
> > TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>=20
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 23
> 	Region 0: Memory at c061c000 (32-bit, non-prefetchable)
> [size=3D1K]
> 	Capabilities: [50] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> 	Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
> 	Capabilities: [98] PCI Advanced Features
> 		AFCap: TP+ FLR+
> 		AFCtrl: FLR-
> 		AFStatus: TP-
> 	Kernel driver in use: ehci-pci
>=20
> 00:1f.0 ISA bridge: Intel Corporation 8 Series LPC Controller (rev
> 04)
> 	Subsystem: Lenovo 8 Series LPC Controller
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium
> > TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>=20
> 	Latency: 0
> 	Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
> 	Kernel driver in use: lpc_ich
> 	Kernel modules: lpc_ich
>=20
> 00:1f.2 SATA controller: Intel Corporation 8 Series SATA Controller 1
> [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
> 	Subsystem: Lenovo 8 Series SATA Controller 1 [AHCI mode]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
> > TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>=20
> 	Latency: 0
> 	Interrupt: pin B routed to IRQ 43
> 	Region 0: I/O ports at 4088 [size=3D8]
> 	Region 1: I/O ports at 4094 [size=3D4]
> 	Region 2: I/O ports at 4080 [size=3D8]
> 	Region 3: I/O ports at 4090 [size=3D4]
> 	Region 4: I/O ports at 4060 [size=3D32]
> 	Region 5: Memory at c061b000 (32-bit, non-prefetchable)
> [size=3D2K]
> 	Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> 		Address: fee02004  Data: 4025
> 	Capabilities: [70] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-
> ,D2-,D3hot+,D3cold-)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> 	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
> 	Kernel driver in use: ahci
> 	Kernel modules: ahci
>=20
> 00:1f.3 SMBus: Intel Corporation 8 Series SMBus Controller (rev 04)
> 	Subsystem: Lenovo 8 Series SMBus Controller
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
> > TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>=20
> 	Interrupt: pin C routed to IRQ 0
> 	Region 0: Memory at c0619000 (64-bit, non-prefetchable)
> [size=3D256]
> 	Region 4: I/O ports at 4040 [size=3D32]
> 	Kernel modules: i2c_i801
>=20
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 10)
> 	Subsystem: Lenovo RTL8111/8168/8411 PCI Express Gigabit
> Ethernet Controller
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 44
> 	Region 0: I/O ports at 3000 [size=3D256]
> 	Region 2: Memory at c0504000 (64-bit, non-prefetchable)
> [size=3D4K]
> 	Region 4: Memory at c0500000 (64-bit, non-prefetchable)
> [size=3D16K]
> 	Capabilities: [40] Power Management version 3
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> 	Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> 		Address: 00000000fee02004  Data: 4023
> 	Capabilities: [70] Express (v2) Endpoint, MSI 01
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0,
> Latency L0s <512ns, L1 <64us
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> SlotPowerLimit 10.000W
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported-
> 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 4096 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM
> L0s L1, Exit Latency L0s unlimited, L1 <64us
> 			ClockPM+ Surprise- LLActRep- BwNot-
> ASPMOptComp+
> 		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled-
> CommClk+
> 			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,
> LTR+, OBFF Via message/WAKE#
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> ,=20
> LTR-, OBFF Disabled
> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
> SpeedDis-
> 			 Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
> 	Capabilities: [b0] MSI-X: Enable- Count=3D4 Masked-
> 		Vector table: BAR=3D4 offset=3D00000000
> 		PBA: BAR=3D4 offset=3D00000800
> 	Capabilities: [d0] Vital Product Data
> pcilib: sysfs_read_vpd: read failed: Input/output error
> 		Not readable
> 	Capabilities: [100 v15] #ffff
> 	Capabilities: [ffc v15] #ffff
> 	Capabilities: [ffc v15] <chain looped>
> 	Kernel driver in use: r8169
> 	Kernel modules: r8169
>=20
> 02:00.0 Network controller: Intel Corporation Wireless 3160 (rev 93)
> 	Subsystem: Intel Corporation Dual Band Wireless AC 3160
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 47
> 	Region 0: Memory at c0400000 (64-bit, non-prefetchable)
> [size=3D8K]
> 	Capabilities: [c8] Power Management version 3
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-
> ,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> 	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> 		Address: 00000000fee08004  Data: 4024
> 	Capabilities: [40] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0,
> Latency L0s <512ns, L1 unlimited
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> SlotPowerLimit 0.000W
> 		DevCtl:	Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported-
> 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
> FLReset-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM
> L0s L1, Exit Latency L0s <4us, L1 <32us
> 			ClockPM+ Surprise- LLActRep- BwNot-
> ASPMOptComp-
> 		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes
> Disabled- CommClk+
> 			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Range B, TimeoutDis+,
> LTR+, OBFF Via WAKE#
> 		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-
> ,=20
> LTR-, OBFF Disabled
> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
> SpeedDis-
> 			 Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover-
> Timeout- NonFatalErr+
> 		AERCap:	First Error Pointer: 00, GenCap- CGenEn-
> ChkCap- ChkEn-
> 	Capabilities: [140 v1] Device Serial Number d0-7e-35-ff-ff-2f-
> 3a-d2
> 	Capabilities: [14c v1] Latency Tolerance Reporting
> 		Max snoop latency: 3145728ns
> 		Max no snoop latency: 3145728ns
> 	Capabilities: [154 v1] Vendor Specific Information: ID=3Dcafe
> Rev=3D1 Len=3D014 <?>
> 	Kernel driver in use: iwlwifi
> 	Kernel modules: iwlwifi
>=20
> [7.6.] SCSI information (from /proc/scsi/scsi):
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: ST1000LM024 HN-M Rev: 0001
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: HL-DT-ST Model: DVDRAM GUA0N     Rev: AL00
>   Type:   CD-ROM                           ANSI  SCSI revision: 05
>=20
> [7.7.] Other information that might be relevant to the problem
>        (please look in /proc and include all information that you
>        think to be relevant):
> 1     1484  1649  191   2005  2363  3047  47   998          mdstat
> 10    1489  1685  1913  201   2367  306   48   acpi         meminfo
> 100   15    1742  1918  202   237   307   49   asound       misc
> 1000  1511  1746  1922  2030  2389  31    50   buddyinfo    modules
> 1001  1561  1747  1925  2034  2392  32    530  bus          mounts
> 1035  1566  1754  1929  2046  24    3247  55   cgroups      mtrr
> 105   1568  1758  1931  2054  240   33    56   cmdline      net
> 11    1572  1760  1943  2089  241   3312  570  consoles     pagetypei
> nf
> o
> 1124  1573  1762  1945  2098  2491  3342  571  cpuinfo      partition
> s
> 114   1586  18    1952  21    25    3350  6    crypto       sched_deb
> ug
> 1163  1591  1826  1961  2102  2552  3352  7    devices      schedstat
> 1169  1594  1831  1962  2103  26    3390  759  diskstats    scsi
> 1172  1597  184   1965  2106  2628  34    8    dma          self
> 12    16    1846  1968  2111  2678  3485  9    driver       slabinfo
> 1220  1608  185   1969  2114  268   3500  911  execdomains  softirqs
> 1242  1609  1852  1979  2117  27    3620  958  fb           stat
> 1296  1611  1859  198   212   2706  3621  959  filesystems  swaps
> 1297  1612  186   1980  2126  272   3641  960  fs           sys
> 13    1613  1864  1981  2129  2728  37    961  interrupts   sysrq-
> trigger
> 131   1614  1866  1984  214   2763  38    962  iomem        sysvipc
> 1325  1615  187   199   2156  279   39    966  ioports      thread-
> self
> 14    1618  1872  1991  2165  28    397   967  irq          timer_lis
> t
> 1415  1622  1876  1992  2175  2805  4     976  kallsyms     tty
> 1426  1623  188   1993  2177  2837  40    98   kcore        uptime
> 1432  1625  1888  1994  22    2839  41    980  keys         version
> 1446  1630  189   1999  2216  2865  42    987  key-
> users    vmallocinfo
> 1459  1631  1893  2     2233  2880  422   988  kmsg         vmstat
> 1463  1634  1894  20    2297  2895  43    99   kpagecgroup  zoneinfo
> 1464  1635  1898  200   2317  2904  44    990  kpagecount
> 1469  1636  19    2001  2319  2914  444   992  kpageflags
> 1471  1637  190   2002  2335  30    45    994  loadavg
> 1473  1645  1900  2003  2356  3003  46    997  locks
>=20
> [X.] Other notes, patches, fixes, workarounds:
> A bug has been filed with the Ubuntu kernel team as well.
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1743027

Email thread with RTC maintainer for additional background:
On 02/13/2018 08:45 PM, Alexandre Belloni wrote:
> On 13/02/2018 at 18:56:34 -0500, Peter Milley wrote:
>> Okay, I've booted the new kernel.
>>
>> peter@haven:~$ uname -a
>> Linux haven 4.16.0-rc1+ #32 SMP Tue Feb 13 22:11:39 CET 2018 x86_64
>> x86_64 x86_64 GNU/Linux
>> peter@haven:~$ dmesg | grep -i rtc
>> [    0.045403] RTC time: 23:46:52, date: 02/13/18
>> [    1.368198] rtc_cmos 00:01: RTC can wake from S4
>> [    1.368205] rtc_cmos: drivers/rtc/rtc-cmos.c +679 cmos_do_probe
>> [    1.368235] rtc_cmos: drivers/rtc/rtc-cmos.c +684 cmos_do_probe
>> [    1.368260] rtc_cmos: drivers/rtc/rtc-cmos.c +688 cmos_do_probe
>> [    1.368285] rtc_cmos: 1: 70 8
>> [    1.368302] rtc_cmos: probe of 00:01 failed with error -16
>> [    1.408861] hctosys: unable to open rtc device (rtc0)
>>
> [...]
>
>> And /proc/ioports:
>> peter@haven:~$ sudo cat /proc/ioports
>> 0000-0cf7 : PCI Bus 0000:00
>>    0000-001f : dma1
>>    0020-0021 : pic1
>>    0040-0043 : timer0
>>    0050-0053 : timer1
>>    0060-0060 : keyboard
>>    0062-0062 : PNP0C09:00
>>      0062-0062 : EC data
>>    0064-0064 : keyboard
>>    0066-0066 : PNP0C09:00
>>      0066-0066 : EC cmd
>>    0070-0072 : wdat_wdt
> So I can tell you what is happening but I can't tell you why. You have =
a
> watchdog at 0x70 (size 2) and the RTC at 0x70 (size 8).
>
> Because the watchdog driver is probed first and it requests the io
> region, when the RTC driver is probed, it fails to request the same
> region.
>
> Maybe your 4.10 kernel didn't have CONFIG_WDAT_WDT (this appeared in
> 4.9).
> I'm afraid, that is as far as I can help, you'd have to ask someone tha=
t
> is more knowledgeable about x86 to go further (I've added the wdat_wdt
> driver author in Cc).
>
