Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:58435 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbbKYToL (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Nov 2015 14:44:11 -0500
Subject: Re: [PATCH 5/10] watchdog: bcm63xx_wdt: Use WATCHDOG_CORE
To: Guenter Roeck <linux@roeck-us.net>
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CBF0.30904@simon.arlott.org.uk>
 <56552099.7070709@roeck-us.net>
 <726719450643bb69683224d731b582b0df27fe1f@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <5655C149.5010008@roeck-us.net>
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
From: Simon Arlott <simon@fire.lp0.eu>
Message-ID: <56560F76.60000@simon.arlott.org.uk>
Date: Wed, 25 Nov 2015 19:43:50 +0000
MIME-Version: 1.0
In-Reply-To: <5655C149.5010008@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 25/11/15 14:10, Guenter Roeck wrote:
> On 11/25/2015 05:02 AM, Simon Arlott wrote:
>> On Wed, November 25, 2015 02:44, Guenter Roeck wrote:
>>> The "running" flag should no longer be needed. watchdog_active()
>>> should provide that information.
>>
>> I'm going to need to keep that because I need to know if it's running
>> in the interrupt handler, and wdd->lock is a mutex.
>>
>>>> @@ -306,17 +202,18 @@ unregister_timer:
>>>>
>>>>    static int bcm63xx_wdt_remove(struct platform_device *pdev)
>>>>    {
>>>> -	if (!nowayout)
>>>> -		bcm63xx_wdt_hw_stop();
>>>> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
>>>>
>>>> -	misc_deregister(&bcm63xx_wdt_miscdev);
>>>>    	bcm63xx_timer_unregister(TIMER_WDT_ID);
>>>> +	watchdog_unregister_device(wdd);
>>>
>>> Shouldn't that come first, before unregistering the timer ?
>>
>> No, because wdd->dev is used in the interrupt handler. I will have to
>> move registration of the interrupt to after creating the watchdog
>> because it could currently be used before wdd->dev is set.
>>
> 
> Does unregistering the timer disable the interrupt ?

No, it sets the callback for that timer to NULL so that it won't be
called.

-- 
Simon Arlott
