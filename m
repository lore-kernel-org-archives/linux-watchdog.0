Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qg0-f67.google.com ([209.85.192.67]:34895 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbcERGvT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 May 2016 02:51:19 -0400
Received: by mail-qg0-f67.google.com with SMTP id b14so3425908qge.2
        for <linux-watchdog@vger.kernel.org>; Tue, 17 May 2016 23:51:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <573799FA.7090207@roeck-us.net>
References: <1462797277-14969-1-git-send-email-joel@jms.id.au>
 <1463062631-16432-1-git-send-email-joel@jms.id.au> <1463062631-16432-3-git-send-email-joel@jms.id.au>
 <573799FA.7090207@roeck-us.net>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 18 May 2016 16:20:58 +0930
Message-ID: <CACPK8XedReKGdEjb=b0ik=wKpCOPCjqFpDGjU-WtNH-sEzzeLA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] watchdog: Add Aspeed watchdog driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Jeremy Kerr <jk@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, May 15, 2016 at 7:04 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> +
>> +struct aspeed_wdt {
>> +       struct watchdog_device  wdd;
>> +       unsigned long           rate;
>
> I still don't see why you need this variable. Why not just use
> WDT_1MHZ_CLOCK directly ?

Yes, I can. It's left over from when the driver ran the device from pclk.

>> +static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
>> +                                 unsigned int timeout)
>> +{
>> +       wdd->timeout = timeout;
>> +
>> +       return aspeed_wdt_start(wdd);
>
> The watchdog can be stopped here (with WDIOC_SETOPTIONS/WDIOS_DISABLECARD).
> An implicit enable is not really a good idea; neither the infrastructure
> nor user space would in this case be aware that the watchdog is running.

Okay, good to know. The documentation does not mention this.

I will change it to write the value but not change the running state.

>> +}
>> +
>> +static int aspeed_wdt_restart(struct watchdog_device *wdd,
>> +                             unsigned long action, void *data)
>> +{
>> +       struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
>> +
>> +       aspeed_wdt_enable(wdt, 128 * wdt->rate / 1000);
>> +
>
>
> Is that the smallest accepted value, or is there some other reason
> not to make it smaller ?

It's what the vendor BSP was using, and it's what we've been using
since I wrote this code (which happens to be one year ago today!).

>
> It is also quite common to wait here to let the reset 'catch'
> before returning. This would ensure that the system doesn't trigger
> a lower priority reset.

Okay. I will add a mdelay(1000) here.

>> +       ret = watchdog_register_device(&wdt->wdd);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "failed to register\n");
>> +               return ret;
>> +       }
>> +
>> +       dev_info(&pdev->dev, "rate %lu, max timeout %u, timeout %d\n",
>> +                wdt->rate, wdt->wdd.max_timeout, wdt->wdd.timeout);
>> +
>
> 'rate 1000000' doesn't seem very informative. All it does is to expose
> an implementation detail which no one really cares about. Even if you
> were to add 'Hz', I would argue that no one will even understand
> what it means without looking into the driver, but then it will be
> understood without the message.

Okay. I will remove the dev_info all together.

Cheers,

Joel
