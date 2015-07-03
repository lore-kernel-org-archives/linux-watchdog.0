Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38110 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755676AbbGCO4P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 Jul 2015 10:56:15 -0400
Received: by wibdq8 with SMTP id dq8so102522853wib.1
        for <linux-watchdog@vger.kernel.org>; Fri, 03 Jul 2015 07:56:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGhQ9VzLX_hy2Z=jUH6on0_sOZBp_mg5cC0JXkHntWxxrr2K6A@mail.gmail.com>
References: <1435783930-20184-1-git-send-email-ariel@vanguardiasur.com.ar>
	<1435783930-20184-2-git-send-email-ariel@vanguardiasur.com.ar>
	<CAGhQ9VzLX_hy2Z=jUH6on0_sOZBp_mg5cC0JXkHntWxxrr2K6A@mail.gmail.com>
Date: Fri, 3 Jul 2015 11:56:14 -0300
Message-ID: <CAAEAJfDo9QNK5kNV8kHxmnwhfUm__xn3XuDyOBeCnLZQZy6OJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] watchdog: NXP LPC18xx Watchdog Timer Driver
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To: Joachim Eastwood <manabian@gmail.com>
Cc: "Ariel D'Alessandro" <ariel@vanguardiasur.com.ar>,
	linux-watchdog@vger.kernel.org, wim@iguana.be,
	Guenter Roeck <linux@roeck-us.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Joachim,

On 1 July 2015 at 20:04, Joachim  Eastwood <manabian@gmail.com> wrote:
[..]
>> +static int lpc18xx_wdt_start(struct watchdog_device *wdt_dev)
>> +{
>> +       struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
>> +       unsigned int val;
>> +
>> +       if (timer_pending(&lpc18xx_wdt->timer))
>> +               del_timer(&lpc18xx_wdt->timer);
>> +
>> +       val = readl(lpc18xx_wdt->base + LPC18XX_WDT_MOD);
>> +       val |= LPC18XX_WDT_MOD_WDEN;
>> +       val |= LPC18XX_WDT_MOD_WDRESET;
>> +       writel(val, lpc18xx_wdt->base + LPC18XX_WDT_MOD);
>
> R-M-W sequence should probably be protect with a lock.
>

Notice the watchdog framework serializes this access (see the mutex in
watchdog_dev.c). So we only need protection for the registers
accessed in the timer and the restart handler.

-- 
Ezequiel García, VanguardiaSur
www.vanguardiasur.com.ar
