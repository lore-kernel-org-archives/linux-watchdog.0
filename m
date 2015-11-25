Return-path: <simon@fire.lp0.eu>
Message-ID: <726719450643bb69683224d731b582b0df27fe1f@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
In-Reply-To: <56552099.7070709@roeck-us.net>
References: <5650BFD6.5030700@simon.arlott.org.uk>
    <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
    <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
    <5651CB13.4090704@simon.arlott.org.uk>
    <5651CBF0.30904@simon.arlott.org.uk> <56552099.7070709@roeck-us.net>
Date: Wed, 25 Nov 2015 13:02:10 -0000
Subject: Re: [PATCH 5/10] watchdog: bcm63xx_wdt: Use WATCHDOG_CORE
From: "Simon Arlott" <simon@fire.lp0.eu>
To: "Guenter Roeck" <linux@roeck-us.net>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "Ralf Baechle" <ralf@linux-mips.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Jason Cooper" <jason@lakedaemon.net>,
 "Marc Zyngier" <marc.zyngier@arm.com>,
 "Kevin Cernekee" <cernekee@gmail.com>,
 "Florian Fainelli" <f.fainelli@gmail.com>,
 "Wim Van Sebroeck" <wim@iguana.be>,
 "Maxime Bizon" <mbizon@freebox.fr>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-mips@linux-mips.org,
 linux-watchdog@vger.kernel.org,
 "Rob Herring" <robh+dt@kernel.org>,
 "Pawel Moll" <pawel.moll@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Ian Campbell" <ijc+devicetree@hellion.org.uk>,
 "Kumar Gala" <galak@codeaurora.org>,
 "Jonas Gorski" <jogo@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, November 25, 2015 02:44, Guenter Roeck wrote:
> The "running" flag should no longer be needed. watchdog_active()
> should provide that information.

I'm going to need to keep that because I need to know if it's running
in the interrupt handler, and wdd->lock is a mutex.

>> @@ -306,17 +202,18 @@ unregister_timer:
>>
>>   static int bcm63xx_wdt_remove(struct platform_device *pdev)
>>   {
>> -	if (!nowayout)
>> -		bcm63xx_wdt_hw_stop();
>> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
>>
>> -	misc_deregister(&bcm63xx_wdt_miscdev);
>>   	bcm63xx_timer_unregister(TIMER_WDT_ID);
>> +	watchdog_unregister_device(wdd);
>
> Shouldn't that come first, before unregistering the timer ?

No, because wdd->dev is used in the interrupt handler. I will have to
move registration of the interrupt to after creating the watchdog
because it could currently be used before wdd->dev is set.

-- 
Simon Arlott
