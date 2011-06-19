Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57037 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752369Ab1FSKBP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 19 Jun 2011 06:01:15 -0400
Date: Sun, 19 Jun 2011 11:03:28 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 7/10 v2] Generic Watchdog Timer Driver
Message-ID: <20110619110328.39c0f5e1@lxorguk.ukuu.org.uk>
In-Reply-To: <201106182107.45682.arnd@arndb.de>
References: <20110618172537.GH3441@infomag.iguana.be>
	<201106182107.45682.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> >         /* Register the watchdog timer device */
> >         res = watchdog_register_device(&wdt_dev);
> 
> Why is this a feature of the individual drivers and not of the core?

It's a hardware dependant feature - some watchdogs cannot be stopped once
initialized.

> Maybe it can be in both, so existing drivers don't need to change the user
> interface, but new drivers don't have to provide the option individually
> when you can simply set it for the base module.

Then you'd need an additional interface to specify which watchdog as soon
as we support multiple watchdogs.

Alan
