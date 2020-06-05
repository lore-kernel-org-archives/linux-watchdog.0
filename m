Return-Path: <SRS0=QFI+=7S=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD10C433E1
	for <linux-watchdog@archiver.kernel.org>; Fri,  5 Jun 2020 09:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4D42089D
	for <linux-watchdog@archiver.kernel.org>; Fri,  5 Jun 2020 09:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY5yU3cQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFEJdP (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgFEJdO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 5 Jun 2020 05:33:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19645C08C5C2;
        Fri,  5 Jun 2020 02:33:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b5so4647711pfp.9;
        Fri, 05 Jun 2020 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXcPHC51fCcVubrTICi/8ebQ3LHbBGFqVc4ZlvkcGy8=;
        b=YY5yU3cQ7x2nYhcyU6Irjiwac0T1X3r4FA1BzcjEXvTmKD8XF7ewfdDBsQMHyN6KxU
         cFdoRSQTl6THjHaN6iKdCqC0BT18oxYCTH1YobDoSbpGlkOC//8qTUR/rPRRlZVdI64f
         OsHkkqSlteKDL1f350r6Fe5Pb++laI5jkOJrF1Unn+FgfPyT5Gjit60bsEK9pPRGQ5DE
         DWn0f7KJp4ITvNVp9DaJtvu9QE8n38UOX22FxiXTySRqmj0VfkLbLpPs32+gcJm8HHyK
         TYxEPno36gqsfr6zFF1meSgq4MVTmwMPfHKo8WGVimW9hJWAdQTht0tModHLZnQB7XHA
         UroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXcPHC51fCcVubrTICi/8ebQ3LHbBGFqVc4ZlvkcGy8=;
        b=Go1XidAWBIijkRcRnR6QBYrpGiP5DvAfeukzAucLYVunsHVzXk8CFUBwTfX/QqTJQo
         J1Mc0b1lFdfYotrE0yI57A2KpiUsfjFgEAv2nTx1Og38iT/TKUhgYeTsIf8WAXHjOD0q
         QcwEs538z5T+16HL5JTFT9IJFSWzCcMOrt/fzoCgENUnQ40GI3cJa0PE56Irxlh8/g+p
         fEPxqfZwGsXZUXGR2rkTDARgr8Mi0g8Pp7iA59FVB5KjG5Swuj41cln+IvoHH4dt3Edy
         KxumhRInQnTo2a+jsWJD+7N7dp/tE/ukyr/KxCuXyGuv75jbxzJb21Og91RIVj1/Essr
         lu4A==
X-Gm-Message-State: AOAM530l7+2paPoE7M5nyy6Iq/BXN+6TSTtjDdHLwjpPX1bZcY+rmrOt
        kmASl5aIzyfgGYx4+xysO5LxLK9SjClUkywiJBc=
X-Google-Smtp-Source: ABdhPJxCu8hwG7M1JMYjjsO26eVAr+iHUb43Qkau67/BBHaGfF/MkvOzKWjclyCpz87HPx9T6XGE3cH7uyJ1d2IAzAk=
X-Received: by 2002:a63:305:: with SMTP id 5mr8367725pgd.74.1591349593472;
 Fri, 05 Jun 2020 02:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-6-michael@walle.cc>
 <20200605084915.GE3714@dell>
In-Reply-To: <20200605084915.GE3714@dell>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Jun 2020 12:33:01 +0300
Message-ID: <CAHp75VfTAasC319uXz82dDufdnTGFhTnzJPXknk2+w-rnFfXTg@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] pwm: add support for sl28cpld PWM controller
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Fri, Jun 5, 2020 at 11:51 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 04 Jun 2020, Michael Walle wrote:

...

> > +     cycle = state->duty_cycle * config->max_duty_cycle;
> > +     do_div(cycle, state->period);
>
> Forgive my ignorance (I'm new here!), but what are these 2 lines
> doing?  Here we are multiplying the current duty_cycle with the
> maximum value, then dividing by the period.
>
> So in the case of PWM_MODE_1KHZ with a 50% duty cycle, you'd have:
>
>    (500000 * 0x20[16]) / 1000000 = [0x10]16
>
> Thus, the above gives as a proportional representation of the maximum
> valid value for placement into the cycle control register(s), right?
>
> Either way (whether I'm correct or not), I think it would be nice to
> mention this in a comment.  Maybe even clarify with a simple example.

IIRC PWM has a helper for that (to calc period based on PWM state and
new duty cycle %).

-- 
With Best Regards,
Andy Shevchenko
