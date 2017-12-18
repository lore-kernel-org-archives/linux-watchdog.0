Return-Path: <zboszor@pr.hu>
Return-path: <zboszor@pr.hu>
From: Zoltan Boszormenyi <zboszor@pr.hu>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: Paul Menzel <paulepanter@users.sourceforge.net>,
	Christian Fetzer <fetzer.ch@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Nehal Shah <nehal-bakulchandra.shah@amd.com>,
	Tim Small <tim@seoss.co.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@ekass.net,
	wim@iguana.be,
	jlayton@poochiereds.net,
	marc.2377@gmail.com,
	cshorler@googlemail.com,
	wsa@the-dreams.de,
	regressions@leemhuis.info,
	Alex Williamson <alex.williamson@redhat.com>,
	lyude@redhat.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jakub Sitnicki <jsitnicki@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Simon Guinot <simon.guinot@sequanux.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Mike Travis <travis@sgi.com>,
	Daeseok Youn <daeseok.youn@gmail.com>,
	Huang Rui <ray.huang@amd.com>,
	Andiry Xu <andiry.xu@amd.com>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	David Howells <dhowells@redhat.com>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Alexandre Desnoyers <alex@qtec.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Wan ZongShun <Vincent.Wan@amd.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Lucas Stach <dev@lynxeye.de>,
	Denis Turischev <denis.turischev@compulab.co.il>,
	=?UTF-8?q?B=C3=B6sz=C3=B6rm=C3=A9nyi=20Zolt=C3=A1n?= <zboszor@pr.hu>
Subject: [PATCH 3/5 v5] usb: pci-quirks: Protect the I/O port pair of SB800
Date: Mon, 18 Dec 2017 09:48:39 +0100
Message-Id: <20171218084841.9979-3-zboszor@pr.hu>
In-Reply-To: <20171218084841.9979-1-zboszor@pr.hu>
References: <20171218084841.9979-1-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

From: Böszörményi Zoltán <zboszor@pr.hu>

This patch uses the previously introduced macro called
request_declared_muxed_region() to synchronize access to
the I/O port pair 0xcd6 / 0xcd7 on SB800.

These I/O ports are also used by i2c-piix4 and sp5100_tco,
so synchronization is necessary. The other drivers will also
be modified to use the new macro in subsequest patched.

v1: Started with a common mutex in a C source file.

v2: Declared the common mutex in drivers/usb/host/pci-quirks.c
    instead of in a common C file.

v3: Switched to using the new request_declared_muxed_region
    macro.

v4: Fixed checkpatch.pl warnings and use the new
    release_declared_region() macro.

v5: Rebased for 4.15-rc4

Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
---
 drivers/usb/host/pci-quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 161536717025..e5b28464006e 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -298,6 +298,8 @@ bool usb_amd_prefetch_quirk(void)
 }
 EXPORT_SYMBOL_GPL(usb_amd_prefetch_quirk);
 
+static struct resource sb800_res = DEFINE_RES_IO_NAMED(0xcd6, 2, "SB800 USB");
+
 /*
  * The hardware normally enables the A-link power management feature, which
  * lets the system lower the power consumption in idle states.
@@ -333,11 +335,13 @@ static void usb_amd_quirk_pll(int disable)
 	if (amd_chipset.sb_type.gen == AMD_CHIPSET_SB800 ||
 			amd_chipset.sb_type.gen == AMD_CHIPSET_HUDSON2 ||
 			amd_chipset.sb_type.gen == AMD_CHIPSET_BOLTON) {
+		request_declared_muxed_region(&sb800_res);
 		outb_p(AB_REG_BAR_LOW, 0xcd6);
 		addr_low = inb_p(0xcd7);
 		outb_p(AB_REG_BAR_HIGH, 0xcd6);
 		addr_high = inb_p(0xcd7);
 		addr = addr_high << 8 | addr_low;
+		release_declared_region(&sb800_res);
 
 		outl_p(0x30, AB_INDX(addr));
 		outl_p(0x40, AB_DATA(addr));
-- 
2.13.6
