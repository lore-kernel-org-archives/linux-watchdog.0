Return-Path: <SRS0=u4aO=TW=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A72C282CE
	for <linux-watchdog@archiver.kernel.org>; Wed, 22 May 2019 16:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB2C20879
	for <linux-watchdog@archiver.kernel.org>; Wed, 22 May 2019 16:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHEmR6eM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfEVQFN (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 22 May 2019 12:05:13 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36331 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfEVQFM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 22 May 2019 12:05:12 -0400
Received: by mail-it1-f196.google.com with SMTP id e184so3924390ite.1
        for <linux-watchdog@vger.kernel.org>; Wed, 22 May 2019 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZDtvNEOvSwuMjHI5KzvxkwkCTAXNowd/akXRUiEjPc=;
        b=rHEmR6eMD1fFR3Iqp7ckgLJYdxddyomN+1x9vj5+TKvFxhwZ1nOZ3wUOSfowaN3Tpi
         dMVx9LVneaIzQUDUI9267Tq5N0f5P/s9FR4zlyTV86ZmAmHRgA5nOZsIas9ngIFoyOb1
         z3Zv6nbPBCsC1H8H9+S8zgp14G0OcY/cyU6Re/7yt7um1tGrCkd9MRxsX7ePO/7uN7O/
         go8ZowYF7L6FpjDgc8EZgTytcB3nPYaVcC0cXD1wQwQ4JqFXF3ru28tVz0QzoC2BLD81
         RvTXXvGCYTviDWpIEq3cJBtELL/C1Y8PjiI2r0ezLb0ZkxMt2Z9B2sQn2JXANB2GWqma
         5Jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZDtvNEOvSwuMjHI5KzvxkwkCTAXNowd/akXRUiEjPc=;
        b=l7IMXCyJd5cDdpHCcH2xK8rbxpQuU4Msq1kRfYoZ/fMU4hE8nTv+6/IMAmE9zcaCfB
         WR47ptmqZ9BNq6BtCd7NjY466RW6DcamQ9pnQ4/U0NrC/v42id0ODwTDQUVJbXSgiQ6U
         VNNDzDZqxdqne4lDqVgcRV9tcw/lPSUTtLHMsUTIQ5CH7Jveui+aW0xSg8fX090Rzx8w
         ZbNwFNATBUcoMM0pEzKdRm6HdtkYUoVJ2vcqJdhSt9T+NvuLRruSIuwQTXyMGrbZRZi1
         ssWkyYHHVQCwxOpuezTV6uQx9tYQObGMB8W2WbeuN34HYUmc8IxWP+wETs01ePwCQJET
         vUZA==
X-Gm-Message-State: APjAAAVRjI4PGFi7rLnLHDeaXfLWNzs0Tfhjzs+QNc+ZirrNygCg7dlj
        cEZzHTtJxJsuh1Jxkxvf/ffgEOiJkISrkGGie6oTT3Vu1tY=
X-Google-Smtp-Source: APXvYqyE2jKHhADNgJQhb/SVAG0u6q8dtsvQBM3YEDBGzlHv1eFcHb4nMXvnH8PnPxhLxE0G7CRIwwXQatKivCVVTDQ=
X-Received: by 2002:a02:b47:: with SMTP id 68mr14413329jad.66.1558541112341;
 Wed, 22 May 2019 09:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190518212801.31010-1-wsa+renesas@sang-engineering.com> <20190518212801.31010-33-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190518212801.31010-33-wsa+renesas@sang-engineering.com>
From:   Sylvain Lemieux <slemieux.tyco@gmail.com>
Date:   Wed, 22 May 2019 12:04:59 -0400
Message-ID: <CA+rxa6ofN21fXk0y3=aTJonG1DOBOk0hC_8abSkWVLWWB+5bfw@mail.gmail.com>
Subject: Re: [PATCH 32/46] watchdog: pnx4008_wdt: drop warning after
 registering device
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-watchdog@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

On Sat, May 18, 2019 at 5:28 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The core will print out details now.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/watchdog/pnx4008_wdt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> index d9e03544aeae..124b1c66dc29 100644
> --- a/drivers/watchdog/pnx4008_wdt.c
> +++ b/drivers/watchdog/pnx4008_wdt.c
> @@ -221,10 +221,8 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
>                 set_bit(WDOG_HW_RUNNING, &pnx4008_wdd.status);
>
>         ret = devm_watchdog_register_device(dev, &pnx4008_wdd);
> -       if (ret < 0) {
> -               dev_err(dev, "cannot register watchdog device\n");
> +       if (ret < 0)
>                 return ret;
> -       }
>
>         dev_info(dev, "heartbeat %d sec\n", pnx4008_wdd.timeout);
>
> --
> 2.19.1
>
