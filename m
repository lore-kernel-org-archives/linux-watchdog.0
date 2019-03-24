Return-Path: <SRS0=B6xV=R3=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C2DC43381
	for <linux-watchdog@archiver.kernel.org>; Sun, 24 Mar 2019 15:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2337B2075C
	for <linux-watchdog@archiver.kernel.org>; Sun, 24 Mar 2019 15:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mQUHe/2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfCXPS5 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:18:57 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40073 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfCXPS5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 24 Mar 2019 11:18:57 -0400
Received: by mail-it1-f194.google.com with SMTP id y63so10373342itb.5
        for <linux-watchdog@vger.kernel.org>; Sun, 24 Mar 2019 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LA6GXUCgoW4lEEmR/LMufysHJYXyTKx9RuJsaqKLxUA=;
        b=mQUHe/2T27VeYzPtkFZWO1opnsxSqurAU0juAhv8EYg793y8UFMp/YczASj+Er6Z3r
         e85zNaO4H+71QAWIfcCYz9gh+g0W9X1kULySVZDNKRZaI1YDpVgkgR8dXUxaqWkBbwCA
         b35aoGlfuXQBqmOsZNDNvK4+SjOE6mzMHAA8iFANLLbsDkfFqmPmQFJNuAcYbqcHVxKW
         xglcSytksG3tFjvpVEh/g05uCObI7wJhkJasPFgnE2sKeGtJKZ+jBe78z3xlUTRDKpX3
         P8ubfmY3jOhP2iixXc7eyPmcN+N1D0dq2Jge/QydJky8x8i4g52kQPlD7baUo7XgyeAx
         FCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LA6GXUCgoW4lEEmR/LMufysHJYXyTKx9RuJsaqKLxUA=;
        b=Hn/dlQYvtxs5LJIfpENGAqhM6080QjFKOOdSpHjDBFutefS/3Tohh5EdFokbP82B/G
         No5trD89ABWpkWF0/V0hxHAuLejIvCmsQZ6gpIZLk9PFkc9604hHTSOO8MWlv9kemLN3
         MS1iXDLV56xk8OJVXLu31/xU0aLKZSSvCZjGPPj2Rq/u6gWEuPRvCmhXglPb5EkbO7LC
         HkcJCyGdu865aD5/TJRTdzB0jojtnV9/L4Y2HmSC44OT/ZT+bSm32qx/3L9uq5xfUKHV
         XT95tT8Z6UpwxfvVJB1fuiQI8synEJxtflcekPG+9VhxNH3gqG/WdzV3L65oNAJBftlS
         NuYA==
X-Gm-Message-State: APjAAAXbj34VNQOd7lPX/gTOs+mRK75orID/LKnUguLD75xC2p1hxQId
        I9lmPQNsGmthcJWoIcDIgjBwjamWI0A2fEjGJ9ctEg==
X-Google-Smtp-Source: APXvYqw8WMiyqKB6zM8rvKiZfNagZNLvEHPd2d2+gxclGYL+TMCJXc47XLd0mHezierdMyacId2wPEUkNlQ/mF1nTnc=
X-Received: by 2002:a24:3c4c:: with SMTP id m73mr8815805ita.23.1553440736289;
 Sun, 24 Mar 2019 08:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-10-fparent@baylibre.com>
 <1553398466.26628.0.camel@mtksdaap41>
In-Reply-To: <1553398466.26628.0.camel@mtksdaap41>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Sun, 24 Mar 2019 16:18:45 +0100
Message-ID: <CAOwMV_zkHMZv8y_8C9kRCUsPtSbm+vPkJUNzU-_LK5=OhTkiPw@mail.gmail.com>
Subject: Re: [PATCH 09/24] mmc: mtk-sd: check for valid optional memory resource
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, ryder.lee@mediatek.com,
        linux-watchdog@vger.kernel.org, jjian.zhou@mediatek.com,
        wenzhen.yu@mediatek.com,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        sean.wang@kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, yong.mao@mediatek.com,
        linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org, hsin-hsiung.wang@mediatek.com,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Sun, Mar 24, 2019 at 4:34 AM Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
>
> On Sat, 2019-03-23 at 22:15 +0100, Fabien Parent wrote:
> > 'top_base' memory region is optional. Check that the resource is valid
> > before using it. This avoid getting a "invalid resource" error message
> > printed by the kernel.
> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 833ef0590af8..573aa127d00b 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -2123,9 +2123,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
> >       }
> >
> >       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > -     host->top_base = devm_ioremap_resource(&pdev->dev, res);
> > -     if (IS_ERR(host->top_base))
> > -             host->top_base = NULL;
> > +     if (ret) {
>
> This should be res?

Indeed. Thanks, I will fix it in v2.

> > +             host->top_base = devm_ioremap_resource(&pdev->dev, res);
> > +             if (IS_ERR(host->top_base))
> > +                     host->top_base = NULL;
> > +     }
> >
> >       ret = mmc_regulator_get_supply(mmc);
> >       if (ret)
>
>
