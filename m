Return-Path: <SRS0=yPbY=Y2=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE1ACA9EC7
	for <linux-watchdog@archiver.kernel.org>; Sat,  2 Nov 2019 15:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F95C20663
	for <linux-watchdog@archiver.kernel.org>; Sat,  2 Nov 2019 15:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rta+KO9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfKBPjR (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 2 Nov 2019 11:39:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42101 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfKBPjR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 2 Nov 2019 11:39:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id s23so4946997pgo.9
        for <linux-watchdog@vger.kernel.org>; Sat, 02 Nov 2019 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LB796KGJ4jjEWyENPTRi+siqvW6di5fNv0lhbuwjmJA=;
        b=rta+KO9y/FbVHUL1LUzVqt6+D07QTXpguMN8s9Bwe0eu5RO0fqNX+zvYsEU1L7kezp
         9WLhKm5Xr1ytNNU8uOGe64z6X/eqQZrztko6XNHvUL5vTDL7EvWmdxt3GBJgwZAlG+Dd
         t57AUQ6La93KLDoelFoF0mMcjifhkCvgdcfcsMd7yv0mSde6yGz72U103UV4k0ubWRjX
         4Lnj1JOnHJTVFJyiTo+o3EwXIoXC09jhjhjddX0fQT5Sg8WRyGp97BvmWx6EBROctdg8
         ZyKnrHCG7lI6qZd7C0qblv0EwZ2ncasK9d6P85XzMdqPmRxQLeAFrLqIW4+5aIns22qS
         jlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LB796KGJ4jjEWyENPTRi+siqvW6di5fNv0lhbuwjmJA=;
        b=ZO9alcNqUuez3jGeAp5ho3gbqByN39kzLIuLo1bjxv3irJaHzMposnZGj7UsWcmN4r
         MHo1w8hOUwnXEy1iHRgwDBkhUdUcOIRmXS3hO0Fe4iF8owWPxyAqlipwwKCLJzEJFcat
         e6wc2za5TVaixJWwcuZZEOkVRxl/r91bNAi1TalPUWAVXkJFmQNOrbVWT1cdKfpFlvYz
         vXqy7JGguwui05sBYywQMlbQ/HEVJSDXN8OxXo7/FuFY/He8PoMyrx+lZZBH9+AONaz5
         KWFdZbAHoPDyzbRg/zBznIjd58XV3qyiiYleFM9M820h1t+iJK54sXgohdzi1u/DY4o+
         Yw+w==
X-Gm-Message-State: APjAAAVOcNEMuTNHTkJuOaULAwO2RbRHPxTmba/jsBB/qDxdGJlE7FNa
        imZm+/WgtkgUwiOuGCjRLCI5cons
X-Google-Smtp-Source: APXvYqwDVkq/scskHAtrinioqX/bnbwIJmWi93bPbKLJ8YynfJGsXGl/GhL+q7xUH4uJOjFAkJde5w==
X-Received: by 2002:a65:6483:: with SMTP id e3mr20231432pgv.24.1572709156940;
        Sat, 02 Nov 2019 08:39:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j10sm9839294pfn.128.2019.11.02.08.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Nov 2019 08:39:16 -0700 (PDT)
Date:   Sat, 2 Nov 2019 08:39:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        Anson.Huang@nxp.com, shawnguo@kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/5] watchdog: imx7ulp: Remove unused structure member
Message-ID: <20191102153915.GA17203@roeck-us.net>
References: <20191029174037.25381-1-festevam@gmail.com>
 <20191029174037.25381-3-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029174037.25381-3-festevam@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Tue, Oct 29, 2019 at 02:40:35PM -0300, Fabio Estevam wrote:
> The 'notifier_block' structure member is unused, so just remove it.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/imx7ulp_wdt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
> index 670102924bc1..ed4f7d439f2e 100644
> --- a/drivers/watchdog/imx7ulp_wdt.c
> +++ b/drivers/watchdog/imx7ulp_wdt.c
> @@ -41,7 +41,6 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
>  struct imx7ulp_wdt_device {
> -	struct notifier_block restart_handler;
>  	struct watchdog_device wdd;
>  	void __iomem *base;
>  	struct clk *clk;
