Return-Path: <SRS0=4JeI=XO=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A465C3A5A6
	for <linux-watchdog@archiver.kernel.org>; Thu, 19 Sep 2019 08:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC3221848
	for <linux-watchdog@archiver.kernel.org>; Thu, 19 Sep 2019 08:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568882310;
	bh=2kMQjkBCXiGr7zLm10MBY4u/X31OBc1OC6oW8iKd0eE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KF9oWKV26VWVVIT3FiM/bc7oIPyeTc7++jwnSTd8ufNgYwLsR+XXamlib/xUGfy7H
	 8TXsFw6qRKI34wWLsuEkFtiQ0xBPK4XRSWa0MCZSeoK/246s1Y6ZWfFE4TH8LeK8wB
	 paeCNFCWtqAlRxL1pWji7Mst7bJ/CZ6eAn0SITZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbfISIi3 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 19 Sep 2019 04:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388008AbfISIi3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 19 Sep 2019 04:38:29 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 766D721929;
        Thu, 19 Sep 2019 08:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568882308;
        bh=2kMQjkBCXiGr7zLm10MBY4u/X31OBc1OC6oW8iKd0eE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sA3sBnKQGqzg+ubD8iSs+ztKByxO3DIHTr6Z9wBdDqOl/IKu1ZHQAED4bZ1H9Bbd0
         er4BYaIVgDZIDxbh2HgG1Nq1nI718PSxexf2MxrSHpORGAENrPVuK/88OLbK/xHjye
         sU4c1KV18gjWvafWuwXoUxMuVmQO/lq15FwygDCg=
Received: by mail-oi1-f179.google.com with SMTP id k20so2061739oih.3;
        Thu, 19 Sep 2019 01:38:28 -0700 (PDT)
X-Gm-Message-State: APjAAAUE1WRPN4PpLcroUh9La6/M6CY7mgcsdHEETNgsieycamsS4rJY
        d8SO4YY7KaBxNDogvthki3+4JYHz9DD983kGMAc=
X-Google-Smtp-Source: APXvYqz1uxaw6PlvQFNdn6YP+5sz8W3DiASgyOVcPdZm5Rv2MDPDn3yyHDmh2NLkY4h2z9nCsIF1CtIHabLfLYKYuiY=
X-Received: by 2002:aca:5045:: with SMTP id e66mr1286622oib.7.1568882307737;
 Thu, 19 Sep 2019 01:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <652bf0b2-3681-47f2-3b50-40edff52a7b5@techveda.org>
In-Reply-To: <652bf0b2-3681-47f2-3b50-40edff52a7b5@techveda.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 19 Sep 2019 10:38:16 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdoYZTr_4ysVxN17bo8FZzQXRJS=ch4BAZzY+bLsLhS9Q@mail.gmail.com>
Message-ID: <CAJKOXPdoYZTr_4ysVxN17bo8FZzQXRJS=ch4BAZzY+bLsLhS9Q@mail.gmail.com>
Subject: Re: Samsung based S3C2440A chipset - watchdog timer issue
To:     Suniel Mahesh <sunil.m@techveda.org>
Cc:     kgene@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        heiko@sntech.de,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Thu, 19 Sep 2019 at 09:40, Suniel Mahesh <sunil.m@techveda.org> wrote:
>
> Hi,
>
> I am working on one of the Samsung based S3C2440A chipset based target .
>
> I have couple of questions and I request someone to shed some light on these: (Thank you)
>
> The watchdog driver in linux, looks like, it just configured WDT but didn't start it (code snippet included below).
>
> May i know the reasson why WDT is not started ? Is it because u-boot already started WDT, implies it is not required to do the
> same once we jump into linux ? or is there any specific reason ?
>
> drivers/watchdog/s3c2410_wdt.c (line 53 and lines 616 - 625)
>
> #define S3C2410_WATCHDOG_ATBOOT         (0)
> ....
> static int tmr_atboot   = S3C2410_WATCHDOG_ATBOOT;
> ...
> ...
> if (tmr_atboot && started == 0) {
>                 dev_info(dev, "starting watchdog timer\n");
>                 s3c2410wdt_start(&wdt->wdt_device);
>         } else if (!tmr_atboot) {
>                 /* if we're not enabling the watchdog, then ensure it is
>                  * disabled if it has been left running from the bootloader
>                  * or other source */
>
>                 s3c2410wdt_stop(&wdt->wdt_device);
>         }
> ...
> ...
>
> Tried to start WDT in linux by assigning value 1 to S3C2410_WATCHDOG_ATBOOT. The target resets.
>
> please comment.

I think watchdog should not start during boot before user-space is
brought up. Otherwise who will ping it? Usually watchdog is started by
opening the watchdog device by user-space. If you need it to be
running without user-space, there are special flags for this (see
WDOG_HW_RUNNING and others).

Best regards,
Krzysztof
