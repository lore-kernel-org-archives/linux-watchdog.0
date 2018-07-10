Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42939 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933410AbeGJNTr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jul 2018 09:19:47 -0400
Subject: Re: [PATCH] rtc: stmp3xxx: Don't reset the rtc in .probe() when
 watchdog is running
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>,
        Wolfram Sang <wsa@the-dreams.de>
References: <20180609064313.18763-1-u.kleine-koenig@pengutronix.de>
 <20180709083041.m3h3smfaahl4awq4@pengutronix.de>
 <20180709161924.GA4595@roeck-us.net>
 <20180710070643.gyxk2oc6qvo7fnk3@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1c09be7e-ba04-4d01-4c91-3ccaeb66fc01@roeck-us.net>
Date: Tue, 10 Jul 2018 06:19:43 -0700
MIME-Version: 1.0
In-Reply-To: <20180710070643.gyxk2oc6qvo7fnk3@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/10/2018 12:06 AM, Uwe Kleine-König wrote:
> Hello,
> 
> adding Wolfram to Cc who authored the watchdog bits in the rtc driver.
> 
> On Mon, Jul 09, 2018 at 09:19:24AM -0700, Guenter Roeck wrote:
>> On Mon, Jul 09, 2018 at 10:30:41AM +0200, Uwe Kleine-König wrote:
>>> Hello,
>>>
>>> On Sat, Jun 09, 2018 at 08:43:13AM +0200, Uwe Kleine-König wrote:
>>>> As pointed out in the added comment resetting the rtc also stops the
>>>> included watchdog. This is bad if the bootloader started the watchdog to
>>>> secure the boot process. So don't reset if the watchdog is running.
>>>
>>> I didn't get any feedback for this patch yet. Assuming my patch is
>>> considered ok, my expectation would be that the watchdog people ack it
>>> and that then it goes in via the rtc tree.
>>>
>>
>> Guess there was a good reason for not passing an accessor via regmap ?
> 
> I don't know the details, but maybe this concept wasn't picked because
> just passing a single function for setting the timeout was considered
> simpler. Also given that the registers for wdg and rtc are not separated
> cleanly giving the wdg driver a regmap isn't "nice" IMHO.
> 
> Last time I worked on this driver I wondered if it would be cleaner to
> merge both drivers into drivers/rtc as the relevant functionality
> (stmp3xxx_wdt_set_timeout()) is in that driver anyhow and
> drivers/watchdog/stmp3xxx_rtc_wdt.c mostly contains stuff to handle the

I would agree on this one. It is an example where separation doesn't really
add any value.

> separation. Oh, and there is a reboot notifier that looks strange where
> I wonder if it is really needed.
> 

Calling watchdog_stop_on_reboot() would indeed have been more straightforward,
but that may not have existed when the driver was implemented.

>> Either case, stmp_reset_block() is also called from resume, meaning the
>> watchdog, if running, will likely be disabled by a suspend/resume cycle.
> 
> Yeah, that's right. The watchdog driver has the corresponding callbacks
> and restarts the timer on resume though.
> 
.. assuming the watchdog driver's resume call happens after the rtc driver's
resume call. Maybe that is guaranteed in a parent/child situation.

Guenter

>> I have no idea why the rtc block is reset in the first place;
>> one would assume that there was a reason for that.
> 
> The usual reason is to ensure a clean hardware state. I wouldn't expect
> a deeper reason here. (And if there is one, and removing it really
> breaks something, the right way forward is to reintroduce the reset with
> an explaining comment and think about how to fix the watchdog issue I
> fixed in another way.)
> 
>> The associated watchdog driver does not support telling the watchdog
>> core that the watchdog is running. As such, a watchdog running at boot
>> will only be handled if the watchdog daemon is started before the
>> watchdog times out. I assume this is understood and acceptable.
> 
> Yeah, that's the use case we have.
> 
>> Given all that, and taking no responsibility for the actual impact
>> of the changes, I can only confirm that the patch looks syntactically
>> correct.
>>
>> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks
> Uwe
> 

