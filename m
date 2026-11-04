Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758539;
	b=rWKHFMYHuo56eUUED1BMiYmJbFraZttN68FZH1Peu8buWMwR2S2Ooo9mmnHOa5w1W39n
	 zCCAYPpyvsodBjHb8/R/ui+h7rf76F8Mas3vBGCJtuV86OPDOAyw6KCwKbP5ZvsHcXH6s
	 ZpiStGoFHtaw2iXjd3U+a+mSZkGVk4aQoq2m1UzkVyWH5pi089wzAVp5X4dDgILpy3IVX
	 M4epq7H5mltykdLOEjRzGWbVt5CR9VRXUDfaX0kiZ/PEgBqAS2UfoaY9lyyJyDadR+k0y
	 RUbAeN6970vYNZNFIGZRWM61ddfc0BXX3fSUpSmJgwZ9sLrdEzy9WuV7aZUE9H9Ntqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758539;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=obeZdIY+m64VfhKX+PXbxWPk/2EFDPOwR8JQP9rCoqE=;
	b=Fl9Ko4xDKYNY33yn40aJDPXKQ1mafcu2V0mfnvvP2q+Xjysa8T6bwi4r999QNy2IqvsO
	 zoHeMvPa6no4azOI5s9Sb3v1w9c0p4ewqQ8nDZXov9ToQmh+NsOfKmq8SLGo6+dOWrfOY
	 60EMvaHBEU5cqygDrBdoVjBzXUqXiQqXplzuMm4jxUuZFYLzNHW9YaxKA1ttu8/E/AoD9
	 a+dqCoMYrjkpmx+Yi1sVVLQI7UQY2zTK0BHbaq1KA7bdnpBYDeqVZmLrQimbQ5orPalGt
	 /xLrQE1DM3I6IdO4MwHXUI1t/vcb8CLjVBVrdYv9Tnxo3YLkXK9UYpBWKxRrTp7xiKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8D606A326
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 02:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BE8D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABXgvxIlepqWng+AA--.9658S2;
	Wed, 04 Nov 2026 10:15:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: nv_tco: drop the PCI device reference on failure and teardown
Date: Wed,  4 Nov 2026 02:15:45 +0000
Message-Id: <20261104021545.1468838-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXgvxIlepqWng+AA--.9658S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGry5Zry5JrWDWr4DWw47twb_yoW5AF18pw
	40yFZ0yrW0gr4kAF47Zw1kuFyrCrWay34fCw48J343Cw1Yy343X3ykKa409F47JrZ5Ka45
	Xr1vyFyfCr4jqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
	6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5EQ6tUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMBA2rqY+S7TAAAs9

nv_tco_getdevice() walks the PCI bus with for_each_pci_dev() and keeps
the reference taken by pci_get_device() for the matching device in the
global tco_pci pointer.  The driver never calls pci_dev_put(), so the
reference is leaked when nv_tco_getdevice() bails out after the device
was found, when nv_tco_init() fails to register the misc device, and
when the driver is removed.

Put the reference on those paths and clear tco_pci so that it is not
used after it was dropped.

Fixes: 456c730153fe ("watchdog: Add TCO support for nVidia chipsets")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/watchdog/nv_tco.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
index 0d671b8bb391..8d56081b6e00 100644
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -325,14 +325,14 @@ static unsigned char nv_tco_getdevice(void)
 	if (val == 0x0001 || val == 0x0000) {
 		/* Something is wrong here, bar isn't setup */
 		pr_err("failed to get tcobase address\n");
-		return 0;
+		goto out_put_dev;
 	}
 	val &= 0xff00;
 	tcobase = val + 0x40;
 
 	if (!request_region(tcobase, 0x10, "NV TCO")) {
 		pr_err("I/O address 0x%04x already in use\n", tcobase);
-		return 0;
+		goto out_put_dev;
 	}
 
 	/* Set a reasonable heartbeat before we stop the timer */
@@ -349,7 +349,7 @@ static unsigned char nv_tco_getdevice(void)
 	if (!request_region(MCP51_SMI_EN(tcobase), 4, "NV TCO")) {
 		pr_err("I/O address 0x%04x already in use\n",
 		       MCP51_SMI_EN(tcobase));
-		goto out;
+		goto out_release_region;
 	}
 	val = inl(MCP51_SMI_EN(tcobase));
 	val &= ~MCP51_SMI_EN_TCO;
@@ -358,7 +358,7 @@ static unsigned char nv_tco_getdevice(void)
 	release_region(MCP51_SMI_EN(tcobase), 4);
 	if (val & MCP51_SMI_EN_TCO) {
 		pr_err("Could not disable SMI caused by TCO\n");
-		goto out;
+		goto out_release_region;
 	}
 
 	/* Check chipset's NO_REBOOT bit */
@@ -368,12 +368,15 @@ static unsigned char nv_tco_getdevice(void)
 	pci_read_config_dword(tco_pci, MCP51_SMBUS_SETUP_B, &val);
 	if (!(val & MCP51_SMBUS_SETUP_B_TCO_REBOOT)) {
 		pr_err("failed to reset NO_REBOOT flag, reboot disabled by hardware\n");
-		goto out;
+		goto out_release_region;
 	}
 
 	return 1;
-out:
+out_release_region:
 	release_region(tcobase, 0x10);
+out_put_dev:
+	pci_dev_put(tco_pci);
+	tco_pci = NULL;
 	return 0;
 }
 
@@ -421,6 +424,8 @@ static int nv_tco_init(struct platform_device *dev)
 
 unreg_region:
 	release_region(tcobase, 0x10);
+	pci_dev_put(tco_pci);
+	tco_pci = NULL;
 	return ret;
 }
 
@@ -444,6 +449,8 @@ static void nv_tco_cleanup(void)
 	/* Deregister */
 	misc_deregister(&nv_tco_miscdev);
 	release_region(tcobase, 0x10);
+	pci_dev_put(tco_pci);
+	tco_pci = NULL;
 }
 
 static void nv_tco_remove(struct platform_device *dev)
-- 
2.34.1

