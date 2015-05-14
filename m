Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37280 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbbENNaK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 May 2015 09:30:10 -0400
Message-ID: <5554A35D.5040702@roeck-us.net>
Date: Thu, 14 May 2015 06:30:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Andreas Werner <andy@wernerandy.de>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Window watchdog driver design
References: <20150514115626.GA13621@wernerandy.de>
In-Reply-To: <20150514115626.GA13621@wernerandy.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/14/2015 04:56 AM, Andreas Werner wrote:
> Hi,
> in the next few weeks I need to write a driver for a window wachtdog
> implemented in a CPLD. I have some questions about the design
> of the driver and the best way to write this driver to also be able
> to submit it.
>
> The triggering and configuration of the Watchdog is done by several GPIOs which
> are connected to the CPLD watchdog device. The correct GPIOs are configurable
> using the Device Tree.
>
> 1. Timeout
> 	The timeout values are defined in ms and start from 20ms to 2560ms.
> 	The timout is set by 3 GPIOs this means we have only 8 different
> 	timout values. It is also possible that a future Watchdog CPLD device
> 	does have different timeout values.
>
> 	Is it possible to set ms timeouts? It seems that the WDT API does
> 	only support a resolution of 1sec.
>
> 	One idea would be to use the API timeout as something like a timeout
> 	index to set the different values. Of course this needs to be documented.
>
> 	e.g.
> 	timeout	(API)	timeout in device
> 	1 		20ms
> 	2		100ms
> 	3		500ms
> 	...		...		
>
> 2. Upper/Lower Window
> 	There is currently no support for a windowed watchdog in the wdt core.
> 	The lower window can be activated by a gpio and its timeout is defined
> 	as "upper windows timeout/4"	
>
> 	What is the best way to implement those additional settings? Adding additional
> 	ioctl or export these in sysfs?
> --

Sorry for the maybe dumb question, but what is a window watchdog,
and what is the lower window timeout for (assuming the upper window
timeout causes the watchdog to expire) ?

Guenter

