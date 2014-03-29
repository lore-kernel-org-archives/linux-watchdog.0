Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:52986 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbaC2Lyl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 29 Mar 2014 07:54:41 -0400
MIME-Version: 1.0
Date: Sat, 29 Mar 2014 12:54:40 +0100
Message-ID: <CACna6rwRzw1fo2_DyV3T4fa4+cA3=LTcFHRpRsfZWwR2ugQn_w@mail.gmail.com>
Subject: Extending wdt-gpio to be used on non-of (no DT) platforms
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: linux-watchdog@vger.kernel.org,
	Alexander Shiyan <shc_work@mail.ru>,
	Florian Fainelli <florian@openwrt.org>
Cc: devicetree@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Grant Likely <grant.likely@linaro.org>,
	Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi guys,

I've noticed gpio_wdt was added to the kernel to support some devices
based on devicetree.
We used to have our own (not mainlined) gpio_wdt in OpenWrt project:
http://git.openwrt.org/?p=openwrt.git;a=blob;f=target/linux/generic/patches-3.10/990-gpio_wdt.patch;hb=HEAD

The main difference is that the mainlined one uses OF, while OpenWrt's
one uses plain platform API (with struct gpio_wdt_platform_data).

I wanted to bring a topic of mainlining OpenWrt's solution. We
definitely need that and at the same time our device(s) don't use OF /
DT.

Do you think we should extend wdt-gpio to handle that? Or do you think
this driver is so small, it's not worth it and we should submit a
separated one?

Apart from API being used, one other difference I see is OpenWrt
supports different values for "first tick" and "interval". But that
could be easily handled.

-- 
Rafał
