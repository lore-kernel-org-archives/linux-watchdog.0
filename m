Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:38772 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbbENLrm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 May 2015 07:47:42 -0400
Date: Thu, 14 May 2015 13:56:26 +0200
From: Andreas Werner <andy@wernerandy.de>
To: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Window watchdog driver design
Message-ID: <20150514115626.GA13621@wernerandy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,
in the next few weeks I need to write a driver for a window wachtdog
implemented in a CPLD. I have some questions about the design
of the driver and the best way to write this driver to also be able
to submit it.

The triggering and configuration of the Watchdog is done by several GPIOs which
are connected to the CPLD watchdog device. The correct GPIOs are configurable
using the Device Tree.

1. Timeout
	The timeout values are defined in ms and start from 20ms to 2560ms.
	The timout is set by 3 GPIOs this means we have only 8 different
	timout values. It is also possible that a future Watchdog CPLD device
	does have different timeout values.

	Is it possible to set ms timeouts? It seems that the WDT API does
	only support a resolution of 1sec.

	One idea would be to use the API timeout as something like a timeout
	index to set the different values. Of course this needs to be documented.

	e.g.
	timeout	(API)	timeout in device
	1 		20ms
	2		100ms
	3		500ms
	...		...		

2. Upper/Lower Window
	There is currently no support for a windowed watchdog in the wdt core.
	The lower window can be activated by a gpio and its timeout is defined
	as "upper windows timeout/4"	

	What is the best way to implement those additional settings? Adding additional
	ioctl or export these in sysfs?
