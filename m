Return-Path: <SRS0=tn89=SG=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3043CC3E8A3
	for <linux-watchdog@archiver.kernel.org>; Thu,  4 Apr 2019 02:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EE92133D
	for <linux-watchdog@archiver.kernel.org>; Thu,  4 Apr 2019 02:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VPcIK+aV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDDCwx (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:52:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39518 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfDDCwp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 3 Apr 2019 22:52:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so454355pga.6
        for <linux-watchdog@vger.kernel.org>; Wed, 03 Apr 2019 19:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VRIJ8X5WvK/kgKb9Km3bq8sEPdqzpTtDdrdaKOlk/p8=;
        b=VPcIK+aV5kEiQAzjoyH9V/iDlUlXEotSxwXG2abEA+4Zhg7NjB8A6mL3kb06+Q/xUE
         WaB4eZ4IMj+XIcDM3/iaUCDgGuyIsC/jBX+uJsFMtHrBcSgwIW2Fj/iPFO7Qzjk1+sY3
         /frq2DjUTR2S1o80f0i01iEr6dC7/6iQ00zuXY5tedJJN40VC8vK93F0Kc0/Fzi/pH3R
         r8Xatj1DCa8960aPfdU6W4m1iqkZuv2oLSauwaJd3wINsAtl1g5TusOTQP+4T0wEg20U
         f+0RoolXkfx941pgmwh+zPVsqjkAS++2TOWJ2j9P3NzFwDEsHdIl/U0guDTJiakHJHXr
         QjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VRIJ8X5WvK/kgKb9Km3bq8sEPdqzpTtDdrdaKOlk/p8=;
        b=I2r6iv1is75JfwC+IMt+alfpJ3T/FO8VsShaor5P+sL2YAAHlArm7MUZ9dcZ3XJjDZ
         bpLbc4P0Vv+KN3fDRF08zMYYEVoSusQm49SwuI2MVyGEMMSBPX98q7AqR5J8U8qdPBJe
         WfeLM0tXr4UbPnIbYl2fkexFT8UDdP/xXOcNoEDZ+lxyTnaV/h3roFCfjtqZb8p53wRe
         oO1Ev+LrXnpibVyxJSu4c+ClwmeSbMai/hYpAtcL3vRSA8xfSyK7/zpKPVrRKYPseYyL
         zRiPjPlRzrcmduMDPwyANmjynGa+w704tofQCx/bknvHWRJ4BJjTYEZJPfS0XCKGPeUd
         yhJw==
X-Gm-Message-State: APjAAAX0KqAvnOi1q9QhiNZ/bGnoAhj1XSu0zO0C2x3JY8hFAf58HIPb
        0HoIMmeMvvi4BIQ+65P9MXDeQw==
X-Google-Smtp-Source: APXvYqzkONlxJ9q1lOATqMHzdwfTmyw4XCKq/MyaZPLUW9fHiK1uCRuxY6q5Fs/8DDKZIYBGo6LADQ==
X-Received: by 2002:a62:6985:: with SMTP id e127mr3200910pfc.188.1554346364181;
        Wed, 03 Apr 2019 19:52:44 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id g67sm27027290pfg.94.2019.04.03.19.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 19:52:43 -0700 (PDT)
Date:   Thu, 4 Apr 2019 03:52:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Message-ID: <20190404025234.GB6830@dell>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <39efebe0396dd42de30d37c6f3c1ef2926c90210.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <20190403073152.GM4187@dell>
 <20190403084732.GA3493@localhost.localdomain>
 <20190403093015.GJ11301@dell>
 <20190403101003.GC3493@localhost.localdomain>
 <20190403112559.GP11301@dell>
 <85b20828bb4fb51e6df1d5d9d1c1f667db3a7c48.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85b20828bb4fb51e6df1d5d9d1c1f667db3a7c48.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Wed, 03 Apr 2019, Vaittinen, Matti wrote:

> On Wed, 2019-04-03 at 12:25 +0100, Lee Jones wrote:
> > On Wed, 03 Apr 2019, Matti Vaittinen wrote:
> > 
> > > On Wed, Apr 03, 2019 at 10:30:15AM +0100, Lee Jones wrote:
> > > > On Wed, 03 Apr 2019, Matti Vaittinen wrote:
> > > > 
> > > > > Hello Lee,
> > > > > 
> > > > > Thanks for taking a look on this again =) I agree with most of
> > > > > the
> > > > > comments and correct them at next version.
> > > > > 
> > > > > On Wed, Apr 03, 2019 at 08:31:52AM +0100, Lee Jones wrote:
> > > > > > On Mon, 25 Mar 2019, Matti Vaittinen wrote:
> > > > > > 
> > > > > > > ROHM BD70528MWV is an ultra-low quiescent current general
> > > > > > > purpose single-chip power management IC for battery-powered
> > > > > > > portable devices.
> > > > > > > 
> > > > > > > Add MFD core which enables chip access for following
> > > > > > > subdevices:
> > > > > > > 	- regulators/LED drivers
> > > > > > > 	- battery-charger
> > > > > > > 	- gpios
> > > > > > > 	- 32.768kHz clk
> > > > > > > 	- RTC
> > > > > > > 	- watchdog
> > > > > > > 
> > > > > > > Signed-off-by: Matti Vaittinen <
> > > > > > > matti.vaittinen@fi.rohmeurope.com>
> > > > > > > + * Mapping of main IRQ register bits to sub irq register
> > > > > > > offsets so
> > > > > > 
> > > > > > "sub-IRQ"
> > > > > > 
> > > > > > > + * that we can access corect sub IRQ registers based on
> > > > > > > bits that
> > > > > > 
> > > > > > "sub IRQ" is also fine, but please standardise.
> > > > > > 
> > > > > > I do prefer "sub-IRQ" though.
> > > > > 
> > > > > I'll go with "sub-IRQ" then
> > > > > 
> > > > > > > +
> > > > > > > +#define WD_CTRL_MAGIC1 0x55
> > > > > > > +#define WD_CTRL_MAGIC2 0xAA
> > > > > > > +/**
> > > > > > > + * bd70528_wdt_set - arm or disarm watchdog timer
> > > > > > > + *
> > > > > > > + * @data:	device data for the PMIC instance we want to
> > > > > > > operate on
> > > > > > > + * @enable:	new state of WDT. zero to disable, non
> > > > > > > zero to enable
> > > > > > > + * @old_state:	previous state of WDT will be filled
> > > > > > > here
> > > > > > > + *
> > > > > > > + * Arm or disarm WDT on BD70528 PMIC. Expected to be
> > > > > > > called only by
> > > > > > > + * BD70528 RTC and BD70528 WDT drivers. The rtc_timer_lock
> > > > > > > must be taken
> > > > > > > + * by calling bd70528_wdt_lock before calling
> > > > > > > bd70528_wdt_set.
> > > > > > > + */
> > > > > > > +int bd70528_wdt_set(struct rohm_regmap_dev *data, int
> > > > > > > enable, int *old_state)
> > > > > > 
> > > > > > Why doesn't this reside in the watchdog driver?
> > > > > 
> > > > > If my memory serves me right we shortly discussed this already
> > > > > during v8
> > > > > review ;) Cant blame you though as I have seen some of the mail
> > > > > traffic
> > > > > going through your inbox :D
> > > > > 
> > > > > The motivation to have the functions exported from MFD is to
> > > > > not create
> > > > > sirect dependency between RTC and WDT. There may be cases where
> > > > > we want
> > > > > to leave either RTC or WDT out of compilation. MFD is always
> > > > > needed so
> > > > > the dependency from MFD to RTC/WDT does not harm.
> > > > > 
> > > > > (Here's some discussion necromancy if you are interested in re-
> > > > > reading
> > > > > how we did end up with this implementation:
> > > > > https://lore.kernel.org/lkml/20190212091723.GZ20638@dell/)
> > > > > 
> > > > > I hope you are still Ok with having the WDT control functions
> > > > > in MFD.
> > > > 
> > > > OOI, why does the RTC need to control the WDT?
> > > 
> > > I thought I had a comment about this somewhere in code... O_o Must
> > > have
> > > been in some development branch I had :/
> > > 
> > > Anyways, setting the RTC counter may cause watchdog to trigger. It
> > > is not
> > > further explained why but I would guess watchdog uses RTC counter
> > > to check
> > > if it should've been pinged already. So RTC needs to disable watch
> > > dog for
> > > the duration of hwclock setting and enable it again after the new
> > > time is
> > > set. I can add a comment about this to MFD driver if it helps :)
> > 
> > How does the user select between using the RTC and the WDT?
> > 
> > Or are the generally both enabled at the same time?
> > 
> 
> Both RTC and WDT can be enabled at the same time. But they are not
> required to be used. When WDT is enabled, it uses current RTC time as
> 'base' (and RTC time is running no matter if we have the RTC driver
> here or not) - and time-out gets scheduled to specified amount of time
> into future. (Same setting timeout into the future happens when WDT is
> pinged).
> 
> When we set RTC, we disable WDT (if it was enabled), set clock and re-
> enable WDT. This causes the previously used time-out value to be set to
> WDT again. This works Ok because BD70528 does not support 'short ping
> detection'. Only side-effect will be one 'prolonged' WDT feeding period
> when RTC is set. (absolute time when RTC was set minus absolute time
> when previous WD ping or enable was done) longer than reqular period.
> 
> So user should not need to care about this 'dependency'. Basically the
> only possible problem I see is that someone could accidentally hang the
> system with something that keeps setting the RTC time - this would then
> prevent watch dog from doing the reset. This, I believe, is a corner
> case which I don't consider now - and if this is considered to be an
> issue then such a system may disable the RTC driver and do RTC setting
> in a what-ever-manner sees practical.
> 
> I'm not sure if I answered to question you asked though =)

I think you answered it just fine.

So my suggestion is to have the RTC depend on the WRT via Kconfig, and
place this WRT code in the WRT driver where it belongs.  These
functions can be exported from the WRT driver and the RTC can call
into them in the same way it calls into the MFD driver currently.

Avoiding a dependency on the WRT would seem strange, because there is
one.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
