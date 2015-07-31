Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56327 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbbGaQDo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 31 Jul 2015 12:03:44 -0400
Message-ID: <55BB9C5B.1030407@roeck-us.net>
Date: Fri, 31 Jul 2015 09:03:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Felipe Balbi <balbi@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
	kernel@pengutronix.de, Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH v2 0/4] watchdog: omap: several cleanups
References: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de> <20150508073502.GL12671@pengutronix.de> <20150522175923.GK24769@pengutronix.de> <20150522191810.GA23701@roeck-us.net> <20150731093310.GU15360@pengutronix.de> <55BB482C.90801@roeck-us.net> <20150731145210.GX15360@pengutronix.de>
In-Reply-To: <20150731145210.GX15360@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 07/31/2015 07:52 AM, Uwe Kleine-König wrote:
> Hello Guenter,
>
> On Fri, Jul 31, 2015 at 03:04:28AM -0700, Guenter Roeck wrote:
>> On 07/31/2015 02:33 AM, Uwe Kleine-König wrote:
>>> Hello,
>>>
>>> On Fri, May 22, 2015 at 12:18:10PM -0700, Guenter Roeck wrote:
>>>> On Fri, May 22, 2015 at 07:59:23PM +0200, Uwe Kleine-König wrote:
>>>>> On Fri, May 08, 2015 at 09:35:02AM +0200, Uwe Kleine-König wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On Mon, Apr 27, 2015 at 11:22:57AM +0200, Uwe Kleine-König wrote:
>>>>>>> this is v2 of the series I sent on Friday. The changes to the patches
>>>>>>> are documented in the respective mails. Thanks to Felipe Balbi and
>>>>>>> Guenter Roeck for the feedback. I added Reviewed-by tags for Guenter who
>>>>>>> didn't even saw these patches up to now (but who gave a carte blanche).
>>>>>>> I assume that's ok and as intended, Guenter?
>>>>>> Patches 1 to 5 got positive feedback, Wim, do you intend to take them
>>>>>> for the next merge window?
>>>>> gentle ping!
>>>>>
>>>> The patches have been in my watchdog-next branch for a while.
>>>> I sent a pull request to Wim a minute ago, to help him decide.
>>>
>>> I didn't hear anything back since this pull request and in the meantime
>>> other patches entered, with b2102eb36e7909c779e46f66595fda75aa219f4c
>>> being conceptual similar to my patch 6. Also I think adding
>>> omap_wdt_start directly after pm_runtime_put_sync is suboptimal?!
>>>
>>
>> I see five of your patches upstream. The only one missing is patch #6,
>> which should be addressed (at least for the most part) with the patch
>> referenced above. Is there anything else missing ?
> You're right. I cannot reconstruct which command convinced me before
> that the whole series is missing. I guess PEBKAC. Thanks.
>
>> Not sure I can follow your comment regarding omap_wdt_start() and pm_runtime_put_sync().
>> Do you think the watchdog should be enabled earlier ? If so, feel free to submit
>> a patch. You'd have to be careful with pm handling, though, since omap_wdt_start()
>> calls pm_runtime_get_sync().
> I admit I'm not fluent with that runtime pm stuff. But it looks wrong to
> me to have:
>
> 	omap_wdt_disable(wdev);
>
> 	[...]
>
> 	pm_runtime_put_sync(wdev->dev);
>
> 	if (early_enable)
> 		omap_wdt_start(&wdev->wdog);
>
> And AFAIU pm_runtime_get and .._put are like references, so moving the
> omap_wdt_start shouldn't hurt?! The only (positive!) effect is that the
> call to pm_runtime_idle isn't done just to be reversed by
> pm_runtime_resume as triggered by pm_runtime_get_sync.
>

I would agree, but I must admit that I have no idea how the runtime code
works. What happens if pm_runtime_get_sync() is called twice ?
It seems to be doing much more than just incrementing a reference count.
If you think it is ok, feel free to submit a patch to change the call order.

There is a few other things I don't understand about the driver, such as
why it needs a separate lock "to avoid races with PM". It would be useful
to understand why this is needed and what exactly the race condition is,
because it might apply to other drivers and ask for an infrastructure
solution.

Anyway, help me remember - isn't this the chip where it is impossible
to find out if it is running or not ? If so, maybe it would make sense
to simply always enable it in probe and let the infrastructure handle
keepalives while the device is closed (I am working on a simplified version
of that infrastructure code).

Thanks,
Guenter

