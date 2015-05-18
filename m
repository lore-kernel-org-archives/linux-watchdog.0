Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35741 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbbERKuN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 May 2015 06:50:13 -0400
Received: by igbyr2 with SMTP id yr2so44452476igb.0
        for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2015 03:50:13 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 18 May 2015 13:50:13 +0300
Message-ID: <CANxHX8_A+v0wBt8aQPTB1mae7mnMFmULE-DuoP8kAxL3DdaNeg@mail.gmail.com>
Subject: [PATCH] watchdog: via_wdt: Partial fix for programming error and
 support additional southbridges
From: "Nick & John" <levelwol@gmail.com>
To: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

    This patch fixes a programming error by limiting WDT_TIMEOUT_MAX to 255.
    That is done to avoid invalid settings. Putting a value bigger than 255
    results in non working watchdog and reset is not performed. We are trying
    to fit a 10bit value to an 8bit area! To support 1023 seconds MMIO addr+5
    bit1:0 must be used to store the last(higher) two bits of count number.
    Strangely no error was logged at the system when using values bigger than
    255, the driver just ignores the time count.

    Also it adds support for VT8235 and VT8237 series southbridges. Tested with
    VT8235M, VT8237 and VT8237S boards.

    Sending patch to stable too since it seems like an overflow error if big
    timeout values are chosen and because those chipsets were very popular in
    x86 boards supporting processors from all vendors (AMD, intel and VIA).

    Signed-off-by: Ioannis Barkas <risc4all@yahoo.com>
    Signed-off-by: Nikos Barkas <levelwol@gmail.com>
    Cc: <stable@vger.kernel.org>

---

Hello we are Ioannis Barkas (risc4all@yahoo.com) and Nikos Barkas
(levelwol@gmail.com).

 We have been poking with the watchdog subsystem. We tested sp5100_tco
on our AMD boards
with various results. On one of those boards MMIO was disabled.
Opening the MMIO space
results in system freeze!! As a result we continued with the remaining
drivers. A quick
search at our datasheets proved that some of our VIA boards have
watchdog timer but none
was supported yet by the linux driver. Reading the via_wdt code to add
missing southbridge
pointed out another error! A patch(see above) was created to fix it
and add what was missing.
The patch was tested with 3.18.13 but will apply to the latest kernel
since this driver has
not changed for quite some time.
 After creating and testing the patch, we remembered an old kernel
patch at PCI quirks
enabling HPET on VIA chipsets. That patch was targeted on chipsets
where HPET support
was undocumented.  With that in mind, we will test our sole VT8233
board for watchdog
even though the datasheet does not mention watchdog support! Maybe an
early version of
the IP used in next southbridges is present and possibly functional.
 This driver should also support power off support using VIA_WDT_PWROFF.

 In our ASRock 8235M board, ACPI had to be disabled to avoid IO ports
address conflict that
prevented the driver from enabling the device. Without ACPI the driver
was functional. The
ACPI issue is caused by poor consumer grade generic ASL code in AMI
BIOS. The value of
PBlockAddress(810) at processor name scope having length of 6 is used
again at an IO Port
Descriptor(800) having length 80. As a result 810 to 815 is claimed twice!


--- linux-3.18.13/drivers/watchdog/Kconfig    2015-05-05
19:39:05.000000000 +0300
+++ linux-3.18.13-via-dog/drivers/watchdog/Kconfig    2015-05-13
14:41:05.858355595 +0300
@@ -982,7 +982,9 @@ config VIA_WDT
     select WATCHDOG_CORE
     ---help---
     This is the driver for the hardware watchdog timer on VIA
-    southbridge chipset CX700, VX800/VX820 or VX855/VX875.
+    single chip chipsets: CX700, VX800/VX820, VX855/VX875 and
+    on VIA southbridges: VT8235 series, VT8237 series and
+        VT8237S.

     To compile this driver as a module, choose M here; the module
     will be called via_wdt.
diff -upr linux-3.18.13/drivers/watchdog/via_wdt.c
linux-3.18.13-via-dog/drivers/watchdog/via_wdt.c
--- linux-3.18.13/drivers/watchdog/via_wdt.c    2015-05-05
19:39:05.000000000 +0300
+++ linux-3.18.13-via-dog/drivers/watchdog/via_wdt.c    2015-05-13
14:34:02.602339475 +0300
@@ -51,11 +51,15 @@
 #define WDT_HEARTBEAT    (HZ/2)    /* should be <= ((WDT_HW_HEARTBEAT*HZ)/2) */

 /* User space timeout in seconds */
-#define WDT_TIMEOUT_MAX    1023    /* approx. 17 min. */
+#define WDT_TIMEOUT_MAX    255    /* approx. 4 min.(255 sec) */
+/*
+ * Hardware can support up to 17 minutes(1023 seconds) but MMIO addr+5
+ * bits 1:0 must be used too.
+ */
 #define WDT_TIMEOUT    60
 static int timeout = WDT_TIMEOUT;
 module_param(timeout, int, 0);
-MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds, between 1 and 1023 "
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds, between 1 and 255 "
     "(default = " __MODULE_STRING(WDT_TIMEOUT) ")");

 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -240,6 +244,10 @@ static void wdt_remove(struct pci_dev *p
 }

 static const struct pci_device_id wdt_pci_table[] = {
+    { PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8235) },
+    { PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237) },
+    { PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237A) },
+    { PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237S) },
     { PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_CX700) },
     { PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX800) },
     { PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX855) },
