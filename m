Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60124 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbcGQULQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:11:16 -0400
Subject: Re: Implement status function in watchdog core
To: Wim Van Sebroeck <wim@iguana.be>
References: <20160717195916.GD32751@spo001.leaseweb.nl>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <578BE661.9080709@roeck-us.net>
Date: Sun, 17 Jul 2016 13:11:13 -0700
MIME-Version: 1.0
In-Reply-To: <20160717195916.GD32751@spo001.leaseweb.nl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

On 07/17/2016 12:59 PM, Wim Van Sebroeck wrote:
> Hi Guenter,
>
> I didn't find the following patches that are in your tree in my e-mail:
> watchdog: Improve description of min_hw_heartbeat_ms
> watchdog: Implement status function in watchdog core
> watchdog: sbsa: Drop status function
> watchdog: tangox: Mark running watchdog correctly
> watchdog: Eliminate status callback
>

Interesting. I checked my logs ... looks like I never sent those to the list. Oops :-(. Sorry for that; I thought I did.

> I added "watchdog: Improve description of min_hw_heartbeat_ms" and "watchdog: tangox: Mark running watchdog correctly" to the linux-watchdog-next tree.
>

Great, thanks!

> I didn't add the status function implementation. The reason is because there are cards that have means to read certain info life (like pcwd cards and the wdt cards). The implementation doesn't foresee this functionality and thus should be corrected first. (for these cards you want to call the status functions of these cards).

Ok, thanks for letting me know. I'll have another look.

What would be the best approach to use for those drivers ? Overlay the data
from the driver with the data from the watchdog core, or completely rely
on the data from the driver ?

Thanks,
Guenter

