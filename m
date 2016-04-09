Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:46332 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbcDIM7c (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 9 Apr 2016 08:59:32 -0400
Date: Sat, 9 Apr 2016 13:58:14 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, gregkh@linuxfoundation.org,
	tglx@linutronix.de, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, wim@iguana.be,
	linus.walleij@linaro.org, gnurou@gmail.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 04/10] iio: stx104: Change STX104 dependency to ISA_BUS
Message-ID: <20160409135814.359e24d6@lxorguk.ukuu.org.uk>
In-Reply-To: <20160408192723.GA31687@sophia>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
	<783be62acf68b35f3fe4785a2cedfe017624688b.1460040201.git.vilhelm.gray@gmail.com>
	<20160408004503.GB10211@roeck-us.net>
	<20160408123158.GB18202@sophia>
	<5707AF91.5010704@roeck-us.net>
	<20160408150922.GA28058@sophia>
	<20160408182801.GB7083@roeck-us.net>
	<20160408192723.GA31687@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> I believe this is the source of the issues I encountered on my initial
> attempt to decouple the X86_32 dependency from the ISA option. I suspect
> if I add an explicit X86_32 dependency to the PNPBIOS driver, I will be
> able to remove the X86_32 dependency from the ISA option without
> incident from the other drivers.

That would be correct. PnPBIOS is obsoleted by ACPI so a 64bit x86
platform shouldn't be using PnPBIOS nor anything non x86. Strictly
speaking PnpBIOS is not ISA, it's onboard devices.

ISA devices that can be enumerated are usually enumerated via ISAPnP
which is platform independent.

Quite a few of the ISA drivers if you review them more carefully have
other endian and size assumptions, IRQ assumptions and probably fun bugs
because they've simply never been run on anything else even when it is
possible.

Alan
