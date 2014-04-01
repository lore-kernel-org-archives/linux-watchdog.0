Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34840 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbaDAAOD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 31 Mar 2014 20:14:03 -0400
Date: Mon, 31 Mar 2014 17:13:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: linux-watchdog@vger.kernel.org,
	Alexander Shiyan <shc_work@mail.ru>,
	Florian Fainelli <florian@openwrt.org>,
	devicetree@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Grant Likely <grant.likely@linaro.org>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: Extending wdt-gpio to be used on non-of (no DT) platforms
Message-ID: <20140401001353.GB30453@roeck-us.net>
References: <CACna6rwRzw1fo2_DyV3T4fa4+cA3=LTcFHRpRsfZWwR2ugQn_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6rwRzw1fo2_DyV3T4fa4+cA3=LTcFHRpRsfZWwR2ugQn_w@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Mar 29, 2014 at 12:54:40PM +0100, Rafał Miłecki wrote:
> Hi guys,
> 
> I've noticed gpio_wdt was added to the kernel to support some devices
> based on devicetree.
> We used to have our own (not mainlined) gpio_wdt in OpenWrt project:
> http://git.openwrt.org/?p=openwrt.git;a=blob;f=target/linux/generic/patches-3.10/990-gpio_wdt.patch;hb=HEAD
> 
> The main difference is that the mainlined one uses OF, while OpenWrt's
> one uses plain platform API (with struct gpio_wdt_platform_data).
> 
> I wanted to bring a topic of mainlining OpenWrt's solution. We
> definitely need that and at the same time our device(s) don't use OF /
> DT.
> 
> Do you think we should extend wdt-gpio to handle that? Or do you think
> this driver is so small, it's not worth it and we should submit a
> separated one?
> 
> Apart from API being used, one other difference I see is OpenWrt
> supports different values for "first tick" and "interval". But that
> could be easily handled.
> 
If you can sort out those differences, I would suggest to add platform data
support to the existing upstream driver.

Guenter
