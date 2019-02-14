Return-Path: <SRS0=mhZ9=QV=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6FFC4360F
	for <linux-watchdog@archiver.kernel.org>; Thu, 14 Feb 2019 08:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF22206BA
	for <linux-watchdog@archiver.kernel.org>; Thu, 14 Feb 2019 08:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NuS8j7v+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfBNIS5 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:18:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38023 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436592AbfBNISx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 14 Feb 2019 03:18:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so5102941wmh.3
        for <linux-watchdog@vger.kernel.org>; Thu, 14 Feb 2019 00:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ixX/PDpcTxenERxwkg3DyWFDNS2U2E9Ldlr6A9QbJ2Q=;
        b=NuS8j7v+BHN3UD/EZM8VtaKOHz61V1rl1os0UB/lTmzkuqcSsEgNYl0dCjyozcnPg7
         U5DI0QhKpUu0Kdl7ZBz4P8V5pgIyr6tRH5h/TckGXarSJogrEseSuZDIBnhuM1vJ2Z75
         lP3sXu7fa9yElV8mj6OYlXFCwRwaTp07/B4Dr/pMOMX+92rVyAO1Lk/SMv/va61e6EfB
         PDvrAkIayTGhe8h40kMB7lA05SenXl80wcqWFTmRy0lt+3BqGQwcvXgTPK9GiRG+NCnX
         q4wp8+dif4wb/k6pc+4S/1+LcNa4RVDjeqEWmxJHi8JtnayPfT5kaL7XkD5jJfW3lVFF
         QDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ixX/PDpcTxenERxwkg3DyWFDNS2U2E9Ldlr6A9QbJ2Q=;
        b=nSO/PFBZXxqi5W72dnN7tQKnnnVPE8o/ZaGebiKl9Qpg8ycptaCU0vFgU/v/NnPr38
         v5Vy0ifjMdCA7Nrkgc6zuqGOlOQ2VUCOJ2mmrxlbgzleJ++h/W/fVzsr0gX1ACORYRCT
         bB3FE6SFWSxN+Hqd5YpaagAbPUhHVRvIngC1n9f1IHh2dSD4Em/hXdHIhsND2pvuKjdK
         vAtRzjq0gLz4HziY3TjoefrOSpZv2Z7FfABoCbBgKIAVHN/baDwhRvwdOEHtwrOJtsKg
         q7j6m0YNoyr6+qVjjp06BuzOUO9n8XN0bXZvB3fF0LsxiSxHyxyZpvg475Xys+zeeAHJ
         /PhQ==
X-Gm-Message-State: AHQUAuaarU7JxTPqpKPxRmUlSRMeKHH5ooGiGWkLhC+oiLin8sOZqnxq
        WrGBVv+xE7l2sDngL+eg9H82tQ==
X-Google-Smtp-Source: AHgI3IZLOUKeaulLyY9Iu1vsUxmAGdkLyduufym7KqLBiNJjMXwnEDoE7Z2bbry2pPw3VyT92NoViw==
X-Received: by 2002:a1c:6c10:: with SMTP id h16mr1596997wmc.84.1550132331487;
        Thu, 14 Feb 2019 00:18:51 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id x18sm1102574wrw.61.2019.02.14.00.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 00:18:50 -0800 (PST)
Date:   Thu, 14 Feb 2019 08:18:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, robh+dt@kernel.org,
        mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
Subject: Re: [PATCH v9 8/8] watchdog: bd70528: Initial support for ROHM
 BD70528 watchdog block
Message-ID: <20190214081849.GI1863@dell>
References: <cover.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <5aab97a1d68d131d0c5d37e0a78d3c8147a52e9e.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <f11554b9-1842-13bc-7ceb-ca7589eb4518@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f11554b9-1842-13bc-7ceb-ca7589eb4518@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Wed, 13 Feb 2019, Guenter Roeck wrote:

> On 2/13/19 5:37 AM, Matti Vaittinen wrote:
> > Initial support for watchdog block included in ROHM BD70528
> > power management IC.
> > 
> > Configurations for low power states are still to be checked.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > 
> > I maintained the ack from Guenter as only change is to use function
> > exported by MFD instead of pointer to function provided by MFD. Please
> > let me know if this is not Ok.
> > 
> 
> NP. With functions exported by MFD, my choice would have been to handle
> locking there as well with respective locking/unlocking functions exported.
> But that is your call to make, not mine.

FWIW, I agree.

[...]

Lots of superfluous quoting here mate.  Better to snip it off IMHO.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
