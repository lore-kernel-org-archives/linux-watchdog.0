Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47338 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbbFLMXX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 12 Jun 2015 08:23:23 -0400
Message-ID: <557ACF39.2060108@roeck-us.net>
Date: Fri, 12 Jun 2015 05:23:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf@tronnes.org>,
	linux-arm-kernel@lists.infradead.org
CC: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog: bcm2835: Add poweroff code for the Raspberry
 Pi
References: <1433845305-17329-1-git-send-email-noralf@tronnes.org> <1433845305-17329-2-git-send-email-noralf@tronnes.org>
In-Reply-To: <1433845305-17329-2-git-send-email-noralf@tronnes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/09/2015 03:21 AM, Noralf Trønnes wrote:
> This adds a new poweroff function to the watchdog driver for the
> Raspberry Pi. Currently poweroff/halt results in a reboot.
>
> The Raspberry Pi firmware uses the RSTS register to know which
> partiton to boot from. The partiton value is spread into bits
> 0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
> the firmware to indicate halt.
>
> The firmware made this change in 19 Aug 2013 and was matched
> by the downstream commit:
> Changes for new NOOBS multi partition booting from gsh
>
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>

This poweroff handler stuff is getting really messy :-(.

Nothing we can do about that here, so

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

