Return-path: <maheshkhanwalkar@gmail.com>
From: Mahesh Khanwalkar <maheshkhanwalkar@gmail.com>
To: corbet@lwn.net,
	sudeep.dutt@intel.com,
	ashutosh.dixit@intel.com,
	tglx@linutronix.de,
	clemens@ladisch.de,
	wim@iguana.be,
	linux@roeck-us.net,
	gregkh@linuxfoundation.org,
	maheshkhanwalkar@gmail.com,
	dasaratharaman.chandramouli@intel.com,
	timur@codeaurora.org,
	arnd@arndb.de,
	nab@linux-iscsi.org,
	hans.verkuil@cisco.com,
	mchehab@osg.samsung.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pcmcia@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v4] Documentation: Move samples from doc to samples/
Date: Mon, 18 Jul 2016 15:55:00 -0400
Message-Id: <1468871700-12889-1-git-send-email-maheshkhanwalkar@gmail.com>
In-Reply-To: <1468870350.1900.18.camel () perches ! com>
References: <1468870350.1900.18.camel () perches ! com>
List-ID: <linux-watchdog@vger.kernel.org>

Moved sample code found in Documentation/ to samples/ but kept actual
documentation where it is, while updating any in-text references to the
moved code. Updated the Documentation/Makefile and samples/Makefile to
reflect the change. Built with CONFIG_SAMPLES=y in .config with no
build errors. The directories added within samples/ still follow the
same structure that they did in Documentation. Directories in
Documentation/ that contained code still exist, only the code within
them has been moved out accordingly.

Documentation/Makefile: Removed subdirectories that no longer have any
code or Makefiles in them

samples/Makefile: Added references to the new subdirectories created
from the move

Signed-off-by: Mahesh Khanwalkar <maheshkhanwalkar@gmail.com>
---
Changes in v4:
	- Updated MAINTAINERS to reflect the changes

 Documentation/Makefile                                             | 6 +++---
 Documentation/auxdisplay/Makefile                                  | 7 -------
 Documentation/auxdisplay/cfag12864b                                | 2 +-
 Documentation/blackfin/Makefile                                    | 5 -----
 Documentation/mic/Makefile                                         | 1 -
 Documentation/pcmcia/Makefile                                      | 7 -------
 Documentation/pcmcia/devicetable.txt                               | 2 +-
 Documentation/timers/Makefile                                      | 5 -----
 Documentation/timers/hpet.txt                                      | 2 +-
 Documentation/watchdog/Makefile                                    | 1 -
 Documentation/watchdog/pcwd-watchdog.txt                           | 2 +-
 Documentation/watchdog/src/Makefile                                | 5 -----
 Documentation/watchdog/watchdog-api.txt                            | 2 +-
 MAINTAINERS                                                        | 5 +++++
 samples/Makefile                                                   | 3 ++-
 samples/auxdisplay/.gitignore                                      | 1 +
 samples/auxdisplay/Makefile                                        | 4 ++++
 {Documentation => samples}/auxdisplay/cfag12864b-example.c         | 0
 samples/blackfin/Makefile                                          | 1 +
 {Documentation => samples}/blackfin/gptimers-example.c             | 0
 samples/hpet/.gitignore                                            | 1 +
 samples/hpet/Makefile                                              | 7 +++++++
 {Documentation/timers => samples/hpet}/hpet_example.c              | 0
 {Documentation/mic => samples}/mpssd/.gitignore                    | 0
 {Documentation/mic => samples}/mpssd/Makefile                      | 0
 {Documentation/mic => samples}/mpssd/micctrl                       | 0
 {Documentation/mic => samples}/mpssd/mpss                          | 0
 {Documentation/mic => samples}/mpssd/mpssd.c                       | 0
 {Documentation/mic => samples}/mpssd/mpssd.h                       | 0
 {Documentation/mic => samples}/mpssd/sysfs.c                       | 0
 samples/pcmcia/.gitignore                                          | 1 +
 samples/pcmcia/Makefile                                            | 4 ++++
 {Documentation => samples}/pcmcia/crc32hash.c                      | 0
 samples/prctl/.gitignore                                           | 3 +++
 {Documentation => samples}/prctl/Makefile                          | 5 +----
 {Documentation => samples}/prctl/disable-tsc-ctxt-sw-stress-test.c | 0
 {Documentation => samples}/prctl/disable-tsc-on-off-stress-test.c  | 0
 {Documentation => samples}/prctl/disable-tsc-test.c                | 0
 {Documentation/watchdog/src => samples/watchdog}/.gitignore        | 0
 samples/watchdog/Makefile                                          | 3 +++
 {Documentation/watchdog/src => samples/watchdog}/watchdog-simple.c | 0
 {Documentation/watchdog/src => samples/watchdog}/watchdog-test.c   | 0
 42 files changed, 41 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/auxdisplay/Makefile
 delete mode 100644 Documentation/blackfin/Makefile
 delete mode 100644 Documentation/mic/Makefile
 delete mode 100644 Documentation/pcmcia/Makefile
 delete mode 100644 Documentation/timers/Makefile
 delete mode 100644 Documentation/watchdog/Makefile
 delete mode 100644 Documentation/watchdog/src/Makefile
 create mode 100644 samples/auxdisplay/.gitignore
 create mode 100644 samples/auxdisplay/Makefile
 rename {Documentation => samples}/auxdisplay/cfag12864b-example.c (100%)
 create mode 100644 samples/blackfin/Makefile
 rename {Documentation => samples}/blackfin/gptimers-example.c (100%)
 create mode 100644 samples/hpet/.gitignore
 create mode 100644 samples/hpet/Makefile
 rename {Documentation/timers => samples/hpet}/hpet_example.c (100%)
 rename {Documentation/mic => samples}/mpssd/.gitignore (100%)
 rename {Documentation/mic => samples}/mpssd/Makefile (100%)
 rename {Documentation/mic => samples}/mpssd/micctrl (100%)
 rename {Documentation/mic => samples}/mpssd/mpss (100%)
 rename {Documentation/mic => samples}/mpssd/mpssd.c (100%)
 rename {Documentation/mic => samples}/mpssd/mpssd.h (100%)
 rename {Documentation/mic => samples}/mpssd/sysfs.c (100%)
 create mode 100644 samples/pcmcia/.gitignore
 create mode 100644 samples/pcmcia/Makefile
 rename {Documentation => samples}/pcmcia/crc32hash.c (100%)
 create mode 100644 samples/prctl/.gitignore
 rename {Documentation => samples}/prctl/Makefile (53%)
 rename {Documentation => samples}/prctl/disable-tsc-ctxt-sw-stress-test.c (100%)
 rename {Documentation => samples}/prctl/disable-tsc-on-off-stress-test.c (100%)
 rename {Documentation => samples}/prctl/disable-tsc-test.c (100%)
 rename {Documentation/watchdog/src => samples/watchdog}/.gitignore (100%)
 create mode 100644 samples/watchdog/Makefile
 rename {Documentation/watchdog/src => samples/watchdog}/watchdog-simple.c (100%)
 rename {Documentation/watchdog/src => samples/watchdog}/watchdog-test.c (100%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index de955e1..667cdd2 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,3 +1,3 @@
-subdir-y := accounting auxdisplay blackfin \
-	filesystems filesystems ia64 laptops mic misc-devices \
-	networking pcmcia prctl ptp timers vDSO watchdog
+subdir-y := accounting filesystems ia64 \
+	laptops misc-devices networking ptp \
+	vDSO
diff --git a/Documentation/auxdisplay/Makefile b/Documentation/auxdisplay/Makefile
deleted file mode 100644
index ada4dac..0000000
--- a/Documentation/auxdisplay/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# List of programs to build
-hostprogs-y := cfag12864b-example
-
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
-
-HOSTCFLAGS_cfag12864b-example.o += -I$(objtree)/usr/include
diff --git a/Documentation/auxdisplay/cfag12864b b/Documentation/auxdisplay/cfag12864b
index eb7be39..12fd51b 100644
--- a/Documentation/auxdisplay/cfag12864b
+++ b/Documentation/auxdisplay/cfag12864b
@@ -101,5 +101,5 @@ Although the LCD won't get updated until the next refresh time arrives.
 Also, you can mmap the framebuffer: open & mmap, munmap & close...
 which is the best option for most uses.
 
-Check Documentation/auxdisplay/cfag12864b-example.c
+Check samples/auxdisplay/cfag12864b-example.c
 for a real working userspace complete program with usage examples.
diff --git a/Documentation/blackfin/Makefile b/Documentation/blackfin/Makefile
deleted file mode 100644
index 6782c58..0000000
--- a/Documentation/blackfin/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-ifneq ($(CONFIG_BLACKFIN),)
-ifneq ($(CONFIG_BFIN_GPTIMERS),)
-obj-m := gptimers-example.o
-endif
-endif
diff --git a/Documentation/mic/Makefile b/Documentation/mic/Makefile
deleted file mode 100644
index a191d45..0000000
--- a/Documentation/mic/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-subdir-y := mpssd
diff --git a/Documentation/pcmcia/Makefile b/Documentation/pcmcia/Makefile
deleted file mode 100644
index 47a8fa1..0000000
--- a/Documentation/pcmcia/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# List of programs to build
-hostprogs-y := crc32hash
-
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
-
-HOSTCFLAGS_crc32hash.o += -I$(objtree)/usr/include
diff --git a/Documentation/pcmcia/devicetable.txt b/Documentation/pcmcia/devicetable.txt
index 199afd1..af217b9 100644
--- a/Documentation/pcmcia/devicetable.txt
+++ b/Documentation/pcmcia/devicetable.txt
@@ -27,7 +27,7 @@ pcmcia:m0149cC1ABf06pfn00fn00pa725B842DpbF1EFEE84pc0877B627pd00000000
 The hex value after "pa" is the hash of product ID string 1, after "pb" for
 string 2 and so on.
 
-Alternatively, you can use crc32hash (see Documentation/pcmcia/crc32hash.c)
+Alternatively, you can use crc32hash (see samples/pcmcia/crc32hash.c)
 to determine the crc32 hash.  Simply pass the string you want to evaluate
 as argument to this program, e.g.:
 $ ./crc32hash "Dual Speed"
diff --git a/Documentation/timers/Makefile b/Documentation/timers/Makefile
deleted file mode 100644
index 6c09ee6..0000000
--- a/Documentation/timers/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# List of programs to build
-hostprogs-$(CONFIG_X86) := hpet_example
-
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
diff --git a/Documentation/timers/hpet.txt b/Documentation/timers/hpet.txt
index a484d2c..5edd798 100644
--- a/Documentation/timers/hpet.txt
+++ b/Documentation/timers/hpet.txt
@@ -25,4 +25,4 @@ arch/x86/kernel/hpet.c.
 
 The driver provides a userspace API which resembles the API found in the
 RTC driver framework.  An example user space program is provided in
-file:Documentation/timers/hpet_example.c
+file:samples/hpet/hpet_example.c
diff --git a/Documentation/watchdog/Makefile b/Documentation/watchdog/Makefile
deleted file mode 100644
index 6018f45..0000000
--- a/Documentation/watchdog/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-subdir-y := src
diff --git a/Documentation/watchdog/pcwd-watchdog.txt b/Documentation/watchdog/pcwd-watchdog.txt
index 4f68052..8903b92 100644
--- a/Documentation/watchdog/pcwd-watchdog.txt
+++ b/Documentation/watchdog/pcwd-watchdog.txt
@@ -25,7 +25,7 @@ Last reviewed: 10/05/2007
 
  If you want to write a program to be compatible with the PC Watchdog
  driver, simply use of modify the watchdog test program:
- Documentation/watchdog/src/watchdog-test.c
+ samples/watchdog/watchdog-test.c
 
 
  Other IOCTL functions include:
diff --git a/Documentation/watchdog/src/Makefile b/Documentation/watchdog/src/Makefile
deleted file mode 100644
index 4a892c3..0000000
--- a/Documentation/watchdog/src/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# List of programs to build
-hostprogs-y := watchdog-simple watchdog-test
-
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
diff --git a/Documentation/watchdog/watchdog-api.txt b/Documentation/watchdog/watchdog-api.txt
index b3a701f..0e62ba3 100644
--- a/Documentation/watchdog/watchdog-api.txt
+++ b/Documentation/watchdog/watchdog-api.txt
@@ -37,7 +37,7 @@ activates as soon as /dev/watchdog is opened and will reboot unless
 the watchdog is pinged within a certain time, this time is called the
 timeout or margin.  The simplest way to ping the watchdog is to write
 some data to the device.  So a very simple watchdog daemon would look
-like this source file:  see Documentation/watchdog/src/watchdog-simple.c
+like this source file:  see samples/watchdog/watchdog-simple.c
 
 A more advanced driver could for example check that a HTTP server is
 still responding before doing the write call to ping the watchdog.
diff --git a/MAINTAINERS b/MAINTAINERS
index 1d74837..a801e9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5393,6 +5393,7 @@ L:	linux-kernel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 S:	Maintained
 F:	Documentation/timers/
+F:	samples/hpet/
 F:	kernel/time/hrtimer.c
 F:	kernel/time/clockevents.c
 F:	kernel/time/tick*.*
@@ -6103,6 +6104,7 @@ F:	drivers/misc/mic/
 F:	drivers/dma/mic_x100_dma.c
 F:	drivers/dma/mic_x100_dma.h
 F:	Documentation/mic/
+F:	samples/mpssd/
 
 INTEL PMC/P-Unit IPC DRIVER
 M:	Zha Qipeng<qipeng.zha@intel.com>
@@ -6676,6 +6678,7 @@ W:	http://miguelojeda.es/auxdisplay.htm
 W:	http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
 S:	Maintained
 F:	Documentation/auxdisplay/ks0108
+F:	samples/auxdisplay
 F:	drivers/auxdisplay/ks0108.c
 F:	include/linux/ks0108.h
 
@@ -8871,6 +8874,7 @@ W:	http://lists.infradead.org/mailman/listinfo/linux-pcmcia
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia.git
 S:	Maintained
 F:	Documentation/pcmcia/
+F:	samples/pcmcia/
 F:	drivers/pcmcia/
 F:	include/pcmcia/
 
@@ -12390,6 +12394,7 @@ T:	git git://www.linux-watchdog.org/linux-watchdog.git
 S:	Maintained
 F:	Documentation/devicetree/bindings/watchdog/
 F:	Documentation/watchdog/
+F:	samples/watchdog/
 F:	drivers/watchdog/
 F:	include/linux/watchdog.h
 F:	include/uapi/linux/watchdog.h
diff --git a/samples/Makefile b/samples/Makefile
index 2e3b523..a04f62a 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
-			   configfs/ connector/ v4l/
+			   configfs/ connector/ v4l/ hpet/ prctl/ auxdisplay/ \
+			   blackfin/ pcmcia/ watchdog/
diff --git a/samples/auxdisplay/.gitignore b/samples/auxdisplay/.gitignore
new file mode 100644
index 0000000..7af2228
--- /dev/null
+++ b/samples/auxdisplay/.gitignore
@@ -0,0 +1 @@
+cfag12864b-example
diff --git a/samples/auxdisplay/Makefile b/samples/auxdisplay/Makefile
new file mode 100644
index 0000000..47912a2
--- /dev/null
+++ b/samples/auxdisplay/Makefile
@@ -0,0 +1,4 @@
+# List of programs to build
+obj-$(CONFIG_SAMPLES_AUXDISPLAY) := cfag12864b-example
+
+HOSTCFLAGS_cfag12864b-example.o += -I$(objtree)/usr/include
diff --git a/Documentation/auxdisplay/cfag12864b-example.c b/samples/auxdisplay/cfag12864b-example.c
similarity index 100%
rename from Documentation/auxdisplay/cfag12864b-example.c
rename to samples/auxdisplay/cfag12864b-example.c
diff --git a/samples/blackfin/Makefile b/samples/blackfin/Makefile
new file mode 100644
index 0000000..9190930
--- /dev/null
+++ b/samples/blackfin/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SAMPLES_BLACKFIN) := gptimers-example.o
diff --git a/Documentation/blackfin/gptimers-example.c b/samples/blackfin/gptimers-example.c
similarity index 100%
rename from Documentation/blackfin/gptimers-example.c
rename to samples/blackfin/gptimers-example.c
diff --git a/samples/hpet/.gitignore b/samples/hpet/.gitignore
new file mode 100644
index 0000000..c5c45d7
--- /dev/null
+++ b/samples/hpet/.gitignore
@@ -0,0 +1 @@
+hpet_example
diff --git a/samples/hpet/Makefile b/samples/hpet/Makefile
new file mode 100644
index 0000000..0b00476
--- /dev/null
+++ b/samples/hpet/Makefile
@@ -0,0 +1,7 @@
+# List of programs to build
+#hostprogs-$(CONFIG_X86) := hpet_example
+
+obj-$(CONFIG_SAMPLE_HPET) := hpet_example.o
+
+# Tell kbuild to always build the programs
+#always := $(hostprogs-y)
diff --git a/Documentation/timers/hpet_example.c b/samples/hpet/hpet_example.c
similarity index 100%
rename from Documentation/timers/hpet_example.c
rename to samples/hpet/hpet_example.c
diff --git a/Documentation/mic/mpssd/.gitignore b/samples/mpssd/.gitignore
similarity index 100%
rename from Documentation/mic/mpssd/.gitignore
rename to samples/mpssd/.gitignore
diff --git a/Documentation/mic/mpssd/Makefile b/samples/mpssd/Makefile
similarity index 100%
rename from Documentation/mic/mpssd/Makefile
rename to samples/mpssd/Makefile
diff --git a/Documentation/mic/mpssd/micctrl b/samples/mpssd/micctrl
similarity index 100%
rename from Documentation/mic/mpssd/micctrl
rename to samples/mpssd/micctrl
diff --git a/Documentation/mic/mpssd/mpss b/samples/mpssd/mpss
similarity index 100%
rename from Documentation/mic/mpssd/mpss
rename to samples/mpssd/mpss
diff --git a/Documentation/mic/mpssd/mpssd.c b/samples/mpssd/mpssd.c
similarity index 100%
rename from Documentation/mic/mpssd/mpssd.c
rename to samples/mpssd/mpssd.c
diff --git a/Documentation/mic/mpssd/mpssd.h b/samples/mpssd/mpssd.h
similarity index 100%
rename from Documentation/mic/mpssd/mpssd.h
rename to samples/mpssd/mpssd.h
diff --git a/Documentation/mic/mpssd/sysfs.c b/samples/mpssd/sysfs.c
similarity index 100%
rename from Documentation/mic/mpssd/sysfs.c
rename to samples/mpssd/sysfs.c
diff --git a/samples/pcmcia/.gitignore b/samples/pcmcia/.gitignore
new file mode 100644
index 0000000..53d0813
--- /dev/null
+++ b/samples/pcmcia/.gitignore
@@ -0,0 +1 @@
+crc32hash
diff --git a/samples/pcmcia/Makefile b/samples/pcmcia/Makefile
new file mode 100644
index 0000000..992ec88
--- /dev/null
+++ b/samples/pcmcia/Makefile
@@ -0,0 +1,4 @@
+# List of programs to build
+obj-$(CONFIG_SAMPLES_PCMCIA) := crc32hash
+
+HOSTCFLAGS_crc32hash.o += -I$(objtree)/usr/include
diff --git a/Documentation/pcmcia/crc32hash.c b/samples/pcmcia/crc32hash.c
similarity index 100%
rename from Documentation/pcmcia/crc32hash.c
rename to samples/pcmcia/crc32hash.c
diff --git a/samples/prctl/.gitignore b/samples/prctl/.gitignore
new file mode 100644
index 0000000..0b5c274
--- /dev/null
+++ b/samples/prctl/.gitignore
@@ -0,0 +1,3 @@
+disable-tsc-ctxt-sw-stress-test
+disable-tsc-on-off-stress-test
+disable-tsc-test
diff --git a/Documentation/prctl/Makefile b/samples/prctl/Makefile
similarity index 53%
rename from Documentation/prctl/Makefile
rename to samples/prctl/Makefile
index 44de308..d7cb76f 100644
--- a/Documentation/prctl/Makefile
+++ b/samples/prctl/Makefile
@@ -1,8 +1,5 @@
 ifndef CROSS_COMPILE
-# List of programs to build
-hostprogs-$(CONFIG_X86) := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test disable-tsc-test
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
+obj-$(CONFIG_SAMPLES_PRCTL) := disable-tsc-ctxt-sw-stress-test.o disable-tsc-on-off-stress-test.o disable-tsc-test.o
 
 HOSTCFLAGS_disable-tsc-ctxt-sw-stress-test.o += -I$(objtree)/usr/include
 HOSTCFLAGS_disable-tsc-on-off-stress-test.o += -I$(objtree)/usr/include
diff --git a/Documentation/prctl/disable-tsc-ctxt-sw-stress-test.c b/samples/prctl/disable-tsc-ctxt-sw-stress-test.c
similarity index 100%
rename from Documentation/prctl/disable-tsc-ctxt-sw-stress-test.c
rename to samples/prctl/disable-tsc-ctxt-sw-stress-test.c
diff --git a/Documentation/prctl/disable-tsc-on-off-stress-test.c b/samples/prctl/disable-tsc-on-off-stress-test.c
similarity index 100%
rename from Documentation/prctl/disable-tsc-on-off-stress-test.c
rename to samples/prctl/disable-tsc-on-off-stress-test.c
diff --git a/Documentation/prctl/disable-tsc-test.c b/samples/prctl/disable-tsc-test.c
similarity index 100%
rename from Documentation/prctl/disable-tsc-test.c
rename to samples/prctl/disable-tsc-test.c
diff --git a/Documentation/watchdog/src/.gitignore b/samples/watchdog/.gitignore
similarity index 100%
rename from Documentation/watchdog/src/.gitignore
rename to samples/watchdog/.gitignore
diff --git a/samples/watchdog/Makefile b/samples/watchdog/Makefile
new file mode 100644
index 0000000..94f33e5
--- /dev/null
+++ b/samples/watchdog/Makefile
@@ -0,0 +1,3 @@
+# List of programs to build
+obj-$(CONFIG_SAMPLES_WATCHDOG) := watchdog-simple watchdog-test
+
diff --git a/Documentation/watchdog/src/watchdog-simple.c b/samples/watchdog/watchdog-simple.c
similarity index 100%
rename from Documentation/watchdog/src/watchdog-simple.c
rename to samples/watchdog/watchdog-simple.c
diff --git a/Documentation/watchdog/src/watchdog-test.c b/samples/watchdog/watchdog-test.c
similarity index 100%
rename from Documentation/watchdog/src/watchdog-test.c
rename to samples/watchdog/watchdog-test.c
-- 
2.7.4
