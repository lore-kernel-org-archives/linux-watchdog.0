Received: from e3i439.smtp2go.com (e3i439.smtp2go.com [158.120.85.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41E1DED63
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271348; cv=none; b=oTS4NtX9G+ubcYn0cn7+lnZauT+r6dYLvUeYQR34I/snC8bsydZy4PnGewgwaUlgqE81kfh35V7Fdl1Jh/01iYxdUyiS/UIItlr0qlQz6WSTyJjj0bfmwSJymUs+BLyw10rGG6tLYl4+k5KvN0wwQkGS3Zwi1HxUSBlSIst4+s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271348; c=relaxed/simple;
	bh=P/lu/Ao5pU/yoSpmWhO7NakoxdVgf01ByR2wObgWmnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jEuTlwNwx9diPJfZqek2uu1JuUCTzpaopayZqMDXAtMqB6yXn9I24NuxnHIDBlFTUzmfxmW7Q8lvx9wc82Ev8zz2eMvaL9LlLrixDIQCZf9oD+rE1mSZHL81nBkx4Un8s/uVms2D/I0SqYWZ7XtOlsAYou5oeTd5tVx20AN7Y2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=IdoWn30o; arc=none smtp.client-ip=158.120.85.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="IdoWn30o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1774270436; h=from : subject : to
 : message-id : date; bh=D8btCQ3WkBaZ6rjODEATncJOSVjO+dt1eF0zVp8Z20E=;
 b=IdoWn30o2h087GMuvpFvgKBawml6JIwxgr/WpZDVV0b+K1G83YGgpKDKkN2UYmL41Kxi6
 K/hpN2e5AZNckkAd5GpxkwCNOE/pR7X5mK1RlQAaeuCbuZtjNm4R9OyfUaSu+0ZtDVGmQNk
 npZ4paoHSoaxnSuSCuQ8+SmNV9fjbDUQNiIo3kzp2rYZYA7PrRYp3f0NSvHuuhpIdLXBO8f
 N6oJ9FJjunOubLZsGUgzEwBh5xephPen2R9dXPQK76VmtnV2dLywsHmt8gitfc3BK/wadY1
 1aX2ugAv9Ck7GjclqrT+5BWXStYvj41b8rLPR09Jy8EmE38t0AD2ZspPQhkw==
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.99.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1w4en2-AIkwcC8uYhl-2HS0;
	Mon, 23 Mar 2026 12:53:52 +0000
Received: from flavio-x.asem.intra ([172.16.23.77]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Mon, 23 Mar 2026 13:52:29 +0100
From: Flavio Suligoi <f.suligoi@asem.it>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 0/1] watchdog: gpio_wdt: add ACPI support
Date: Mon, 23 Mar 2026 13:52:03 +0100
Message-ID: <20260323125204.164785-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Mar 2026 12:52:29.0467 (UTC) FILETIME=[E86626B0:01DCBAC3]
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1174574m:1174574aXfMg4B:1174574saggEFJmIW
X-smtpcorp-track: cNvGpnEFYq95.G59DT5ybT8DM.4_Tqtgwlamw

The gpio_wdt driver was already converted to be property provider agnostic
in the following commit:

'7e5bca6e5561 (watchdog: gpio_wdt: Make use of device properties)'

So it can be used on both OF and non-OF platform (ACPI).
The problem is that this driver, to be enabled, require the Device Tree,
as we can see in Kconfig:

config GPIO_WATCHDOG
	tristate "Watchdog device controlled through GPIO-line"
	depends on OF_GPIO
	select WATCHDOG_CORE
	help
	  If you say yes here you get support for watchdog device
	  controlled through GPIO-line.

This dependency prevents its use in other environments, such as ACPI.
To be able to use it with ACPI as well, and therefore with x86
architectures, we have to add the dependency from ACPI and GPIOLIB.

After this change, I tested the driver in one of our x88 boards, adding in
the SSDT the following device:

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

So, in this way, the gpio_wdt driver can be also used in x86 boards.

Flavio Suligoi (1):
  watchdog: gpio_wdt: add ACPI support

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0

