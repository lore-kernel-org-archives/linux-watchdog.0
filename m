Received: from e3i439.smtp2go.com (e3i439.smtp2go.com [158.120.85.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962EA1E2614
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271348; cv=none; b=Cnr39FcAlKg56ch3i3dyqP8vrWm02gUAMFATxMI3sHICTAgulW4tzdcwtr0qsbJJg7t+xCkPlWrzjZwPeGtMsFeW1xwUPpO0y5FLcNeRfvFXFoIN2NPwc2LKjpsz5KbKioji/Uff9+5qd75d7VIaIhmevxEaE6xAO8Y2CrRecg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271348; c=relaxed/simple;
	bh=KV72GsbRh9JFDpo+i9INOsu4ipzJdew53jV+HCgNrM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzTL7J4wM5ESyixQ6XVobraxxwKOdTRTy+1BVQSHvzDFN91CeQNHlY9vsdSwoFbbhXkVtnunzzifeH3MZiLStHy9p5ZXVVzmY7r4DM/76nM6woChz7CqeEkIKCQsApzt4IIVbaClq0g8gjC8CwVQ8D5PVuddw6AY9wDCLYQyNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=Uhqv1EYX; arc=none smtp.client-ip=158.120.85.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="Uhqv1EYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1774270438; h=from : subject : to
 : message-id : date; bh=sAiIE3fA7CMpWLBOFUmCaq8hbg3E4RnoFmWIdk9aVLw=;
 b=Uhqv1EYXOVTJ0rimUkItdcSGgKK/LyhMnvxIz2x6QcxWLNVVyHUW8ndQmHv+fnHnKJlmO
 SWjqqfFEkxfdItEnZcdelVu0WzoLpm/W4tlFn2ijB1AJQvlp13MVeqXlKJ0oByjaKDAlgYh
 0K+tRE0Ti9lwvgNpTkrKq1W7MKpa2yghXh3a2No5S2dQ/OMnkYjQM+FTV1IyFX4xs5uY/0D
 3C4JF5zJ61wlgFqbDeuIaQmbogsH5ARV1PBHChtGhflAzY8+sbvlR5rTAQlLEDxZ+E2rx5T
 UJW9sKwScD++/8u4kUDuxJk+IaW9nx6EVg4wT5tR+oWpyoq8ICoWkctOcILQ==
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.99.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1w4en4-AIkwcC8uYhl-0PLM;
	Mon, 23 Mar 2026 12:53:54 +0000
Received: from flavio-x.asem.intra ([172.16.23.77]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Mon, 23 Mar 2026 13:52:29 +0100
From: Flavio Suligoi <f.suligoi@asem.it>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 1/1] watchdog: gpio_wdt: add ACPI support
Date: Mon, 23 Mar 2026 13:52:04 +0100
Message-ID: <20260323125204.164785-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323125204.164785-1-f.suligoi@asem.it>
References: <20260323125204.164785-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Mar 2026 12:52:29.0482 (UTC) FILETIME=[E86870A0:01DCBAC3]
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1174574m:1174574aXfMg4B:1174574stADfvfCBj
X-smtpcorp-track: nyQt6IMSHDVx.GWLD22Ox7w_N.kKhB_w_h-qh

The gpio_wdt device driver uses the device property APIs, so it is
firmware agnostic. For this reason we can now add the ACPI support in
Kconfig.
In this way it can be used seamlessly in ACPI and DT systems.

For example, a typical GPIO watchdog device configuration, in an ACPI
SSDT table, could be:

Device (WDOG) {
    Name (_HID, "WDOG0001")
    Name (_CID, "PRP0001")
    Name (_UID, One)
    Name (_CRS, ResourceTemplate () {
        GpioIo (Exclusive, PullNone, 0, 0, IoRestrictionOutputOnly,
                "\\_SB.GPI0", 0, ResourceConsumer, ,) { 3 }
    })
    Method (_STA, 0, NotSerialized) {
        Return (0x0F)
    }
    Name (_DSD, Package (2)
    {
        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package (5)
        {
            Package () { "compatible", Package() { "linux,wdt-gpio" } },
            Package () { "hw_algo", "toggle" },
            Package () { "gpios", Package () { ^WDOG, 0, 0, 0 } },
            Package () { "hw_margin_ms", 2000 },
            Package () { "always-running", 1 },
        },
    })
}

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dc78729ba2a5..966489fe8c8d 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -250,7 +250,7 @@ config DA9062_WATCHDOG
 
 config GPIO_WATCHDOG
 	tristate "Watchdog device controlled through GPIO-line"
-	depends on OF_GPIO
+	depends on (ACPI && GPIOLIB) || OF_GPIO
 	select WATCHDOG_CORE
 	help
 	  If you say yes here you get support for watchdog device
-- 
2.43.0

