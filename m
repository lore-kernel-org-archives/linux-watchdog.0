Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:36712 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752589AbbEEJIA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 May 2015 05:08:00 -0400
Message-ID: <5548886A.4040905@offcode.fi>
Date: Tue, 05 May 2015 12:07:54 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
CC: Wenyou.Yang@atmel.com
Subject: Re: [PATCHv7 6/8] watchdog: imx2_wdt: Convert to use new core extensions
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi> <1429701102-22320-7-git-send-email-timo.kokkonen@offcode.fi> <55487B1D.1060108@pengutronix.de> <55487FDB.6060708@pengutronix.de>
In-Reply-To: <55487FDB.6060708@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Marc,

On 05.05.2015 11:31, Marc Kleine-Budde wrote:
> On 05/05/2015 10:11 AM, Marc Kleine-Budde wrote:
>> On 04/22/2015 01:11 PM, Timo Kokkonen wrote:
>>> Fill in the HW capabilities in watchdog_device structure and call
>>> watchdgog_init_params() to let watchdog core to init itself
>>> properly. The watchdog core can then ping stopped watchdog and the
>>> timer code in the driver can be removed.
>>>
>>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>>
>> This patch changes the default behaviour of the imx watchdog. Without
>> the patch: If the system boot with watchdog enabled (by the bootloader),
>> the driver sets up a threads to pet the watchdog. With the patch,
>> imx2_wdt_ping() is called once during probe but the thread is not
>> started. There are no timeout or early_timeout paremters in the DT or in
>> the kernel command line.
>>
>> I don't like the old behaviour, but I think there are some setups that
>> rely on this feature.
>
> BTW: the start-thread-if-wd-is-active feature was added in:
>
>      faad5de0b104 watchdog: imx2_wdt: convert to watchdog core api
>

Yes, thanks for pointing this out. I didn't realize this was in place. 
So what we need to do is to tell the watchdog core the actual status of 
the watchdog HW, whether it is running or not. The core can then start 
the worker thread to ping the HW if needed.

I will fix this for the next patch version.

Thanks!
-Timo

