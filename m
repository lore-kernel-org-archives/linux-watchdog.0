Return-Path: <SRS0=A8d8=56=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381F7C352BE
	for <linux-watchdog@archiver.kernel.org>; Tue, 14 Apr 2020 18:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113BD20774
	for <linux-watchdog@archiver.kernel.org>; Tue, 14 Apr 2020 18:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="rtveXxXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504158AbgDNSl6 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:41:58 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:42151 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbgDNSlw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Apr 2020 14:41:52 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 02BB72222E;
        Tue, 14 Apr 2020 20:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1586889706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8iSoKOFISTm7e3WSV4reMrghBve1U8G6s6rKNmMUNA=;
        b=rtveXxXS06F/NYmV9F2bGS5feXtMfE9gJBoboXZn8qEe9Lv/Pdw+PkB3WYbQaCUuxLEI6I
        01s6XbVlOTMD8dnUpTguXYKOq3sSaQOCnztQCPF9doXoASZlztSVASr7gO1ILou1R9B2WC
        mzBh5hFIxbe65adMWQoMX24W8N21isE=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 14 Apr 2020 20:41:45 +0200
From:   Michael Walle <michael@walle.cc>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using
 regmap
In-Reply-To: <CAMpxmJW1x4Orh1BZ4TUoCsYeaAAZ4NBUNvoMG9JgP0iLvXTOtg@mail.gmail.com>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc>
 <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
 <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
 <CAMpxmJW1x4Orh1BZ4TUoCsYeaAAZ4NBUNvoMG9JgP0iLvXTOtg@mail.gmail.com>
Message-ID: <62d157198a75a59ada15c496deeab49b@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 02BB72222E
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         NEURAL_HAM(-0.00)[-1.082];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,linaro.org,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,linuxfoundation.org];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Am 2020-04-14 19:00, schrieb Bartosz Golaszewski:
> wt., 14 kwi 2020 o 12:07 Michael Walle <michael@walle.cc> napisał(a):
>> >>
>> >> So the best from a user perspective I've could come up with was:
>> >>
>> >>    ->base_reg = GPIO_REGMAP_ADDR(addr);
>> >>
>> >> I'm open for suggestions.
>> >>
>> >
>> > Maybe setting the pointer to ERR_PTR(-ENOENT) which will result in
>> > IS_ERR() returning true?
>> 
>> Unfortunatly, its not a pointer, but only a regular unsigned int (ie
>> the type the regmap API has for its "reg" property). It could be a
>> pointer of course but then the user would have to allocate additional
>> memory.
>> 
>> -michael
>> 
> 
> Eek, of course it's not a pointer. If possible I'd like to avoid this
> GPIO_REGMAP_ADDR() macro, so how about having some separate field for
> invalid offsets making every offset 'valid' by default?

IMHO this has the same problems as mentioned in the response to Mark's
idea. Normally, the user sets only some addresses, thus he has to mark
all other as invalid. And if you add another address, you have to touch
all the drivers to mark it as invalid.

We could add some force bits like the "use_ack" flag in the bgpio 
driver,
where you can force the use of the value 0. But I'd really like to find
a better way..

-michael

> 
> Linus: do you have a better idea?
> 
> Bart
