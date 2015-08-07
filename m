Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47103 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639AbbHGPZi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Aug 2015 11:25:38 -0400
Message-ID: <55C4CDEB.9020505@roeck-us.net>
Date: Fri, 07 Aug 2015 08:25:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Wenyou Yang <wenyou.yang@atmel.com>, wim@iguana.be,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
CC: sylvain.rochet@finsecur.com, nicolas.ferre@atmel.com,
	boris.brezillon@free-electrons.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v6 1/2] drivers: watchdog: add a driver to support SAMA5D4
 watchdog timer
References: <1438856146-2459-1-git-send-email-wenyou.yang@atmel.com> <1438856206-2503-1-git-send-email-wenyou.yang@atmel.com>
In-Reply-To: <1438856206-2503-1-git-send-email-wenyou.yang@atmel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/06/2015 03:16 AM, Wenyou Yang wrote:
>>From SAMA5D4, the watchdog timer is upgrated with a new feature,
> which is describled as in the datasheet, "WDT_MR can be written
> until a LOCKMR command is issued in WDT_CR".
> That is to say, as long as the bootstrap and u-boot don't issue
> a LOCKMR command, WDT_MR can be written more than once in the driver.
>
> So the SAMA5D4 watchdog driver's implementation is different from
> the at91sam9260 watchdog driver implemented in file at91sam9_wdt.c.
> The user application open the device file to enable the watchdog timer
> hardware, and close to disable it, and set the watchdog timer timeout
> by seting WDV and WDD fields of WDT_MR register, and ping the watchdog
> by issuing WDRSTT command to WDT_CR register with hard-coded key.
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

