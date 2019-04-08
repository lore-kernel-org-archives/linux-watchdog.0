Return-Path: <SRS0=d+ns=SK=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0614CC10F13
	for <linux-watchdog@archiver.kernel.org>; Mon,  8 Apr 2019 18:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11022084C
	for <linux-watchdog@archiver.kernel.org>; Mon,  8 Apr 2019 18:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpeBjUl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDHSPM (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:15:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33094 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfDHSPM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 8 Apr 2019 14:15:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id h5so3478366pfo.0
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Apr 2019 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HxNR1qZVhq5GhaZ4TfPc/gm3szHYqKoMnr7aZIdKM58=;
        b=ZpeBjUl/B7eFdwPNSm6NJe3ljBOuQab3FaynJ0Wkst9Ll4uSfUPpbWUzx6LcfJSPLy
         MfGVbwxilU4QaZ9eTz1OmvzHWA8SKY2RGSDUxPmm7Bv7k8BSfO9a97OXaIvx4J6C2yPp
         sQhJOI8yT+6VC/aFd+nP37etv5zhRrmNpZxVeG5HdaiO0KWtYo4ZW0KuyFjnVXcwksqA
         zKLPrKhKcAvH8VBG3oTPzRUaZlaryc1Jlf/2HFGS1gxqagw+yyEvsjiqYSxBQpEbBHfX
         oPCPhZQAwDuItCGZfLW7uBmpzGbz1OfJ7KEVAxY1hcCphWDzeXkOScN6StoAGnshhwei
         01Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HxNR1qZVhq5GhaZ4TfPc/gm3szHYqKoMnr7aZIdKM58=;
        b=Oe7g0sABNbzYKndIuEjPKxtWkVVpGrvyCLSwaKOmVotUzmTwEvExys19Bbkp0HFmxu
         PDjzj6IBcALtroHWkDBT3PEsRECdYRw94O4MYTCb39wdM0kwqppa53VMbhy7Zw2AUBEz
         hdbyCr8N6mn/3ubDAxAbha967Y6aH09JsJEKXHaZjcCHWmBLD3xkyv60G1/4K11BiA60
         JbQyHXChyqUwmFRM23EtT6yrBNE51sGbB98XSChrA6NyF+dusH9gmst83xX77s5xQB89
         YbUXoynJac3z7/r22FVW/rwUUDxwFT5DQHUNJZsGnHfss/nJLW9bt8jZZ8Fghiw3A06W
         nVCQ==
X-Gm-Message-State: APjAAAWvyLP19rYfaLmMfhebW9yjDaWHAz0LOKf+3U7HW8vbaSHsybNF
        Og50IOpueovjuzNeRIGiu0RhAR50
X-Google-Smtp-Source: APXvYqxAhS4ExC9hoRWr4DtxdeLvKY3N3PQOJo7rdtcMjs09X7YkOt8wmixJW1SVUiB2T9NQd72Z+w==
X-Received: by 2002:a62:ab13:: with SMTP id p19mr31907222pff.131.1554747311633;
        Mon, 08 Apr 2019 11:15:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z8sm38139010pgz.3.2019.04.08.11.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 11:15:11 -0700 (PDT)
Date:   Mon, 8 Apr 2019 11:15:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Georg Hofmann <georg@hofmannsweb.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] Fix set_timeout for big timeout values
Message-ID: <20190408181510.GA7049@roeck-us.net>
References: <869353809.2803.1554710736950.JavaMail.zimbra@hofmannsweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <869353809.2803.1554710736950.JavaMail.zimbra@hofmannsweb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Mon, Apr 08, 2019 at 10:05:36AM +0200, Georg Hofmann wrote:
> This patch implements the documented behavior: if max_hw_heartbeat_ms is
> implemented, the minimum of the set_timeout argument and
> max_hw_heartbeat_ms should be used.
> Previously only the first 7 bits were used and the input argument was
> returned.
> 
> Signed-off-by: Georg Hofmann <georg@hofmannsweb.com>

The patch below is corrupted (tabs replaced with spaces). Please resend.
Also, when doing so, please add "watchdog: imx2_wdt:" to the subject line.

Thanks,
Guenter

> ---
>  drivers/watchdog/imx2_wdt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 2b52514..3c13adc 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -178,9 +178,11 @@ static void __imx2_wdt_set_timeout(struct watchdog_device *wdog,
>  static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
>                                  unsigned int new_timeout)
>  {
> -        __imx2_wdt_set_timeout(wdog, new_timeout);
> +        unsigned int actual;
>  
> -        wdog->timeout = new_timeout;
> +        actual = min(new_timeout, wdog->max_hw_heartbeat_ms * 1000);
> +        __imx2_wdt_set_timeout(wdog, actual);
> 
> +        wdog->timeout = new_timeout;
>          return 0;
>  }
>  
> -- 
> 2.7.4
