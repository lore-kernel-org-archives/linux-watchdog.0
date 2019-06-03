Return-Path: <SRS0=2BDg=UC=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0306C46470
	for <linux-watchdog@archiver.kernel.org>; Mon,  3 Jun 2019 09:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A9E28055
	for <linux-watchdog@archiver.kernel.org>; Mon,  3 Jun 2019 09:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfFCJ64 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:58:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43272 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfFCJ6x (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Jun 2019 05:58:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so1973310ljv.10;
        Mon, 03 Jun 2019 02:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+8iFUYMRf82laSy70rtphYPR3+h4zBYoCxM1Yh2xGE=;
        b=DoblRd0L1mqL9KLbMvJb/odd/5JPt807iCzVTpvrR9GsvodURD9Vl9eNOEpz6TELH/
         iSn12MI9X+X7t9e+EUr3DbpXSzsxR5IeEYYwYO/lYab3E/zvz8OR6foildw/iWKUWDDG
         9LE9M/M7QZKp0+/hAUlCkH6VU8JuYJYgNd0DcqMnCMb936ZRbuBlfooP/VIbDqceWmMm
         w9DXFQLckkUNoIZnia6N6lg87S0bedNAthtH3m0RTbaKCf6e1ur8iRplEn30kDDVdD1v
         KYtJYowXvLEEhs9Xc93a4TWeGuUuw736y4a5dfzBfAs7w/d0slDMGYXaFObEQ3K257RX
         Vl6g==
X-Gm-Message-State: APjAAAVPd0hk9n9qh1R0S6k3LS/UUdpcSqCXz25ztjo2J075MfnvvAeE
        GP5gvB3Vnqfk0dytx1xh03mOZwGvgpl6pIo5fiw=
X-Google-Smtp-Source: APXvYqyhGZgt4CxDyLu0p2YMv/9RZPaRVwZQgWnDFl64lEC2bKLoljxhY3ZyTl60SE+L7JLJlSpceEFAAsMGOTkxaac=
X-Received: by 2002:a2e:960e:: with SMTP id v14mr13394862ljh.31.1559555931071;
 Mon, 03 Jun 2019 02:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <1559553957-5764-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1559553957-5764-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Jun 2019 11:58:38 +0200
Message-ID: <CAMuHMdWGBr+kwY18o657J_SCTONSJLZMUs2qMBvBU84p-UNfYA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: renesas_wdt: Add a few cycles delay
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi Shimoda-san,

On Mon, Jun 3, 2019 at 11:31 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> According to the hardware manual of R-Car Gen2 and Gen3,
> software should wait a few RLCK cycles as following:
>  - Delay 2 cycles before setting watchdog counter.
>  - Delay 3 cycles before disabling module clock.
>
> So, this patch adds such delays.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c

> @@ -70,6 +71,16 @@ static int rwdt_init_timeout(struct watchdog_device *wdev)
>         return 0;
>  }
>
> +static void rwdt_wait(struct rwdt_priv *priv, unsigned long cycles)

"unsigned int" should be sufficiently large.

> +{
> +       unsigned long periods, delays;
> +
> +       periods = DIV_ROUND_UP(priv->clk_rate, cycles);

Shouldn't the above be a division with rounding down (i.e. a plain C
division), instead of a division with rounding up?

> +       delays = DIV_ROUND_UP(1000000UL, periods);

Given cycles is always a small number, accuracy can be improved, and one
division can be avoided, by calculation this as:

    delays = DIV_ROUND_UP(cycles * 1000000 /  priv->clk_rate);

> +
> +       usleep_range(delays, 2 * delays);
> +}

The rest looks good to me, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
