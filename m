Return-Path: <SRS0=d+ns=SK=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFABC10F13
	for <linux-watchdog@archiver.kernel.org>; Mon,  8 Apr 2019 18:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1289F2084C
	for <linux-watchdog@archiver.kernel.org>; Mon,  8 Apr 2019 18:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmTJT0pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDHSJk (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:09:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41508 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDHSJk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 8 Apr 2019 14:09:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so7758099pgs.8
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Apr 2019 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4gRytoBlwSeHu/OP+bPRj4Jvw+PuuF+CS2jnOYFoNQA=;
        b=gmTJT0prCaez4w1Ra9PcHTMhEeMCXTFnrNhWT5rULyCiORexQJugNfr5ici/mLV3uk
         nz3OYi3t0StVlBHdqWSWtVP2VTTN3f6xtfv3a6RlxcxvXufsRFnOjWR7iH2VnYqTnG3q
         vXkAhYg6DMTPTutbgZucrpncAolkNZgsxSaMRK+3xCluwv7rVacqIz9qUNRLAinQezqO
         6mWYq7o5z2JSW1Qh3iwVGUvpLSuVL0fPR7E7xqbPB4J3QxbSo2Jbh2MXO6SpBRC5ITMH
         +CdlVAWcz1iY/iXOy2Fb37LdLAXhcrg9HHQjNghr16ahZ2ZSNewCZRwt6mPdx8Y+rltC
         cwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4gRytoBlwSeHu/OP+bPRj4Jvw+PuuF+CS2jnOYFoNQA=;
        b=OJqsYsfn10h6BfmD8FRtD+ySVu4Kc39KkPxYUPAJ6ab4XlCdaDFXXEuYflN6E7uPmk
         iGdQhBpCVeYBPHgaosLheNwFU6htLYBofc221BKYgiDG/4x5pIbSvnb35rK04fT9Du6L
         A/WC5Q3oB7OqDavBzUkW9b2XO57zeWfXFUl6behWm9zA5W19hCIl9LXCLFMiWdCDZN0Z
         hmQnoxuvEiubzM1Zo4g7+rYAf3mMzBpnuKNvPatQJt8dDTNaFO36leztj2PDx2+XOW1t
         qAqJlUGmrXhOk+x3odyxNPxqvilNRO3rpEaleSWzKDTHyMv14TZu1ctr1P9aEcyiLSIf
         T6Wg==
X-Gm-Message-State: APjAAAVwCvmzRZ3J4TbQSATvXMh9cRrFUTEAUVwcyCpy6mzGuR5qE2xB
        eWHGTsj+qMmb/1uz3y9/lORw7ROe
X-Google-Smtp-Source: APXvYqxDlf30v8gRgb4NAE2Nh3qYntKpbDyzLWvEUrkawVB35kL2OGy1VnA/SlkR0o3ThihNjAAd5A==
X-Received: by 2002:a63:4a5a:: with SMTP id j26mr29768119pgl.361.1554746979727;
        Mon, 08 Apr 2019 11:09:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t5sm18079987pfl.106.2019.04.08.11.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 11:09:39 -0700 (PDT)
Date:   Mon, 8 Apr 2019 11:09:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Georg Hofmann <georg@hofmannsweb.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] Fix set_timeout for big timeout values
Message-ID: <20190408180938.GA17574@roeck-us.net>
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

Reviewed-by: Guenetr Roeck <linux@roeck-us.net>

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
