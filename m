Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42168 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbbKYOKW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Nov 2015 09:10:22 -0500
Subject: Re: [PATCH 5/10] watchdog: bcm63xx_wdt: Use WATCHDOG_CORE
To: Simon Arlott <simon@fire.lp0.eu>
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CBF0.30904@simon.arlott.org.uk>
 <56552099.7070709@roeck-us.net>
 <726719450643bb69683224d731b582b0df27fe1f@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Maxime Bizon <mbizon@freebox.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonas Gorski <jogo@openwrt.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5655C149.5010008@roeck-us.net>
Date: Wed, 25 Nov 2015 06:10:17 -0800
MIME-Version: 1.0
In-Reply-To: <726719450643bb69683224d731b582b0df27fe1f@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/25/2015 05:02 AM, Simon Arlott wrote:
> On Wed, November 25, 2015 02:44, Guenter Roeck wrote:
>> The "running" flag should no longer be needed. watchdog_active()
>> should provide that information.
>
> I'm going to need to keep that because I need to know if it's running
> in the interrupt handler, and wdd->lock is a mutex.
>
>>> @@ -306,17 +202,18 @@ unregister_timer:
>>>
>>>    static int bcm63xx_wdt_remove(struct platform_device *pdev)
>>>    {
>>> -	if (!nowayout)
>>> -		bcm63xx_wdt_hw_stop();
>>> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
>>>
>>> -	misc_deregister(&bcm63xx_wdt_miscdev);
>>>    	bcm63xx_timer_unregister(TIMER_WDT_ID);
>>> +	watchdog_unregister_device(wdd);
>>
>> Shouldn't that come first, before unregistering the timer ?
>
> No, because wdd->dev is used in the interrupt handler. I will have to
> move registration of the interrupt to after creating the watchdog
> because it could currently be used before wdd->dev is set.
>

Does unregistering the timer disable the interrupt ?

Thanks,
Guenter

