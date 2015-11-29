Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:43422 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbbK2KlZ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 29 Nov 2015 05:41:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Sun, 29 Nov 2015 11:41:22 +0100
From: Harald Geyer <harald@ccbib.org>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	<linux-watchdog@vger.kernel.org>, <rtc-linux@googlegroups.com>,
	Wolfram Sang <wsa@the-dreams.de>, <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
In-Reply-To: <20151127104402.GT19888@pengutronix.de>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org>
 <1444220352-20548-2-git-send-email-harald@ccbib.org>
 <20151126092526.GM19888@pengutronix.de>
 <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at>
 <20151127100254.GR19888@pengutronix.de>
 <20151127104402.GT19888@pengutronix.de>
Message-ID: <b09608aa29195b41fc114a414d67af0f@ccbib.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe!

On 27.11.2015 11:44, Uwe Kleine-König wrote:
> Hello Harald,
>
> On Fri, Nov 27, 2015 at 11:02:54AM +0100, Uwe Kleine-König wrote:
>> On Thu, Nov 26, 2015 at 02:39:45PM +0100, Harald Geyer wrote:
>> > Uwe Kleine-König writes:
>> > > On Wed, Oct 07, 2015 at 12:19:12PM +0000, Harald Geyer wrote:
>> > > > This device doesn't provide any information about boot status.
>> > > > As workaround we use a persitent bit to track watchdog 
>> activity.
>> > >
>> > > Hmm, so you set a bit in a persistent register iff the watchdog 
>> is
>> > > running.  And if that bit is set during probe you assume the 
>> watchdog
>> > > reset the machine. But this also happens, when the user presses 
>> the
>> > > reset button which makes the detection unreliable.
>> >
>> > Yes, kind of. I'm using this driver on an imx233-olinuxino, where 
>> the
>> > reset button causes the device to power cycle and thus clears the
>> > persitent bit. So I can't test your case, but surely there are 
>> some paths
>> > into reset, that don't clear the bit and cause false positives.
>>
>> OK, I found a i.MX28 machine in our repository:
>>
>> 	barebox# mw 0x80056080 0xbabecafe
>> 	barebox# boot
>> 	...
>> 	linux# reboot
>> 	barebox# md 0x80056080+4
>> 	80056080: babecafe
>>
>> After a power cycle the value disappears (I didn't check the 
>> details, if
>> there is a battery it might be empty).

Are there any concerns left on your side? Ie do you want me to do
any additional tests before sending v4 of this patch with the
whitespace changes and added URL to the freescale kernel?

>> > I have considered gathering some additional information from the
>> > power subsystem to refine the result, but decided that it's not
>> > worth the complexity. Since the power system is a different 
>> silicon
>> > block, we can't rely on it being available and would need to 
>> provide
>> > a fall back implementation anyway.
>>
>> It would be really nice to get some details about boot rom usage of 
>> the
>> persistent flags in use. I'd expect that these allow to determine 
>> the
>> boot source.
>
> A colleague just hinted me to
>
> 
> 	http://git.pengutronix.de/?p=barebox.git;a=blob;f=drivers/watchdog/im28wd.c;h=3510776a3afc8aaf113eee995900b099c12c2be9;hb=HEAD
>
> which contains a few bit definitions for the i.MX28. Maybe they can 
> help
> you to understand your machine better?! At a quick glance there is
> nothing that helps you to determine the boot reason, but still it 
> might
> contain a few interesting things.

Thanks. Unfortunately about the bit that we set in mainline kernel for
unknown reasons, it also only says:
/* dubious meaning from inside the SoC's firmware ROM */
# define MXS_RTC_PERSISTENT1_FORCE_UPDATER (1 << 31)

best regards,
Harald
