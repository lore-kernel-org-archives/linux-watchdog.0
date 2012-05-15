Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:42472 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756770Ab2EOHS7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 15 May 2012 03:18:59 -0400
Date: Tue, 15 May 2012 08:55:59 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Marcos Souza <marcos.souza.org@gmail.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: Error in register iTCO_wdt
Message-ID: <20120515065559.GO3074@spo001.leaseweb.com>
References: <CAH0vN5+4ZOJiZitwFt_Y7ARCiuko96ZfOQ9jX6vnbxngKx20eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH0vN5+4ZOJiZitwFt_Y7ARCiuko96ZfOQ9jX6vnbxngKx20eQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Marcos,

> Hi Wim!
> 
> I'm sending this email because I've seem a strange error messages
> about iTCO_wdt in the boot:
> 
> [   15.503489] iTCO_vendor_support: vendor-support=0
> [   15.512447] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.07
> [   15.513535] iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=2,
> TCOBASE=0x0460)
> [   15.513548] iTCO_wdt: cannot register miscdev on minor=130 (err=-16)
> [   15.513774] iTCO_wdt: probe of iTCO_wdt failed with error -16
> 
> I don't know exactly how many time this warning appers, but I'm here
> to report this!

This is because you either have no /dev/watchdog file (major 10 minor 130)
or because another watchdog device is allready loaded.

> So, while finding what can be these warning, I saw a document writted
> by Wolfram talking about rework watchdog device drivers with watchdog
> framework. So, iTCO_wdt is outdated and needs these changes.
> 
> I'm doing some work(I'm not a kernel hacker yet, but I'm trying to be
> =D), and based in the Wolfram's documentation, and your documentation
> about watchdog kernel api, I have some changes.
> 
> The full diff is attached. This diff cause a lot of build errors, but,
> do you think I'm in the right direction? If you agree with the
> direction that this is going, I will continue to change this.
> 
> As I have this device, and I can test my changes, I believe this is a
> nice work to learn more about the kernel.
> 
> I will be very happy if I could, with you help, rework this driver.

I allready have a reworked/converted driver, but there are some other
dependancies to fix first. So no need to put time in doing a conversion
on iTCO_wdt.c

Kind regards,
Wim.
