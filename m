Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42781 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbcASHLR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jan 2016 02:11:17 -0500
Subject: Re: [PATCH 1/1] watchdog: sp805: ping fails to abort wdt reset
To: Viresh Kumar <viresh.kumar@linaro.org>,
	Sandeep Tripathy <tripathy@broadcom.com>
References: <1453183462-27577-1-git-send-email-tripathy@broadcom.com>
 <20160119065313.GA22443@vireshk>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <569DE192.5060406@roeck-us.net>
Date: Mon, 18 Jan 2016 23:11:14 -0800
MIME-Version: 1.0
In-Reply-To: <20160119065313.GA22443@vireshk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/18/2016 10:53 PM, Viresh Kumar wrote:
> On 19-01-16, 11:34, Sandeep Tripathy wrote:
>>   sp805 wdt asserts interrupt for the first expiry and
>
> Why an extra space before sp805 ?
>
>> reloads the counter. If wdt interrupt is set and count
>> reaches zero then wdt reset event is generated.To get
>
> Add space after full-stop.
>
>> wdt reset at t timeout the driver loads wdt counter
>
> Keep t and t/2 in single quotes, its hardly readable otherwise.
>
>> with t/2. A ping before t second *should* prevent wdt
>> reset. Currently if ping is done after t/2 sec then
>> wdt interrupt condition gets set. On the next countdown
>> of loadval wdt reset event occurs eventhough wdt was
>> reloaded before the set timeout t.
>>
>>   This patch clears the interrupt condition on ping.
>
> Why extra spaces before 'This'?
>
>>
>> Signed-off-by: Sandeep Tripathy <tripathy@broadcom.com>
>> ---
>>   drivers/watchdog/sp805_wdt.c |    5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>> index 01d8162..e7a715e 100644
>> --- a/drivers/watchdog/sp805_wdt.c
>> +++ b/drivers/watchdog/sp805_wdt.c
>> @@ -139,12 +139,11 @@ static int wdt_config(struct watchdog_device *wdd, bool ping)
>>
>>   	writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
>>   	writel_relaxed(wdt->load_val, wdt->base + WDTLOAD);
>> +	writel_relaxed(INT_MASK, wdt->base + WDTINTCLR);
>>
>> -	if (!ping) {
>> -		writel_relaxed(INT_MASK, wdt->base + WDTINTCLR);
>> +	if (!ping)
>>   		writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base +
>>   				WDTCONTROL);
>> -	}
>>
>>   	writel_relaxed(LOCK, wdt->base + WDTLOCK);
>
> If I read the TRM properly, then you don't need to load the WDTLOAD
> register on ping and so your change can be written as:
>
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 01d816251302..42e1ec86532d 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -138,10 +138,10 @@ static int wdt_config(struct watchdog_device *wdd, bool ping)
>          spin_lock(&wdt->lock);
>
>          writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
> -       writel_relaxed(wdt->load_val, wdt->base + WDTLOAD);
> +       writel_relaxed(INT_MASK, wdt->base + WDTINTCLR);
>
>          if (!ping) {
> -               writel_relaxed(INT_MASK, wdt->base + WDTINTCLR);
> +               writel_relaxed(wdt->load_val, wdt->base + WDTLOAD);
>                  writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base +
>                                  WDTCONTROL);
>          }
>

That would require additional changes. Reason is that the load value is not immediately
written after a timeout change, but only with the next ping (which happens immediately
afterwards). With your proposed change, the load value would never be updated.

Besides, that would be a separate change, and would require a separate patch.

Guenter

