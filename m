Return-Path: <SRS0=e47x=6L=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9BEC81901
	for <linux-watchdog@archiver.kernel.org>; Mon, 27 Apr 2020 17:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D94721707
	for <linux-watchdog@archiver.kernel.org>; Mon, 27 Apr 2020 17:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="daZ1yQbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgD0Rt1 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:49:27 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:58467 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbgD0Rt1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 27 Apr 2020 13:49:27 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AAEB72305C;
        Mon, 27 Apr 2020 19:49:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1588009761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uIPaAmEQWo9UFG1wdCdYNeEuiFocSYDqyKIO62bAJso=;
        b=daZ1yQbt+ly5oR4B23djB/+U8nDAtnXWozzanckjgsxqNTdrrDaqv34hlVayGoqj6wvrCn
        lZ7cJuj41ddvRap8LThkKzVCsf0BhUEWdgnuLK7CWaxscOMUAMPxKJGTC7MHCqeoDAmplb
        t/DjgF9AP9YXkde3zaURA5KQJxay3oM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Apr 2020 19:49:21 +0200
From:   Michael Walle <michael@walle.cc>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 09/16] gpiolib: Introduce gpiochip_irqchip_add_domain()
In-Reply-To: <87mu6xqhny.fsf@nanos.tec.linutronix.de>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-10-michael@walle.cc>
 <87mu6xqhny.fsf@nanos.tec.linutronix.de>
Message-ID: <43af0bff6fee64687ac4e0d1ded14c4d@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: AAEB72305C
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[24];
         NEURAL_HAM(-0.00)[-0.777];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux.intel.com,vger.kernel.org,lists.infradead.org,linaro.org,baylibre.com,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,lakedaemon.net,linuxfoundation.org];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Am 2020-04-27 13:42, schrieb Thomas Gleixner:
> Michael Walle <michael@walle.cc> writes:
>> This connects an IRQ domain to a gpiochip and reuses
>> gpiochip_to_irq().
> 
> A little bit more context and explanation why this function is useful
> would be appreciated.

Ok I'll try to be a bit more elaborate the in the next version, (if
this function is still there).

For now:

gpiochip_irqchip_add_domain() allows to use reqmap-irq, which exports
an irqdomain, with gpiolib while reusing gpiochip_to_irq(). Both
gpiochip_irqchip_* and regmap_irq partially provides the same
functionality. The new function will help to connect just the
minimal functionality of the gpiochip_irqchip which is needed to
work together with regmap-irq.

> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/gpio/gpiolib.c      | 20 ++++++++++++++++++++
>>  include/linux/gpio/driver.h |  3 +++
>>  2 files changed, 23 insertions(+)
>> 
>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>> index 40f2d7f69be2..7b3d7f496b9a 100644
>> --- a/drivers/gpio/gpiolib.c
>> +++ b/drivers/gpio/gpiolib.c
>> @@ -2722,6 +2722,26 @@ int gpiochip_irqchip_add_key(struct gpio_chip 
>> *gc,
>>  }
>>  EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_key);
>> 
>> +/**
>> + * gpiochip_irqchip_add_key() - adds an irqdomain to a gpiochip
> 
> Copy & paste is wonderful

whoops.

-michael

> 
>> + * @gc: the gpiochip to add the irqchip to
>> + * @domain: the irqdomain to add to the gpiochip
>> + *
>> + * This function adds an IRQ domain to the gpiochip.
>> + */
>> +int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
>> +				struct irq_domain *domain)
>> +{
>> +	if (!domain)
>> +		return -EINVAL;
>> +
>> +	gc->to_irq = gpiochip_to_irq;
>> +	gc->irq.domain = domain;
>> +
>> +	return 0;
>> +}
> 
> Thanks,
> 
>         tglx
