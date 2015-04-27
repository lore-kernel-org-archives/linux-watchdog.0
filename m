Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:51158 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219AbbD0Ncs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Apr 2015 09:32:48 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org,
	Eric Anholt <eric@anholt.net>, linux-watchdog@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	linux-rpi-kernel@lists.infradead.org,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to the WDT driver.
Date: Mon, 27 Apr 2015 15:32:08 +0200
Message-ID: <17452307.kZG5bCi4C8@wuerfel>
In-Reply-To: <553E398E.7060305@roeck-us.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net> <2465337.STuvDNQht6@wuerfel> <553E398E.7060305@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Monday 27 April 2015 06:28:46 Guenter Roeck wrote:
> >
> 
> The pointer to the power-off handler is removed in the device remove callback,
> and thus won't be called after the device is unbound.
> 
> Ultimately this is similar the the current code, which assumes that the
> call to of_find_device_by_node(np) never fails.
> 

Ok, I missed that part. Yes, that works just as well.

	Arnd
