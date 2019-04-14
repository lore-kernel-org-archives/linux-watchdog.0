Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2673C10F14
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 14:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDE12148E
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 14:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5eR3iWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfDNOPI (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 10:15:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40845 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfDNOPI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 10:15:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so7334896pgl.7;
        Sun, 14 Apr 2019 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=47G3khZfLT5cqVkO4QSozfWy25QpSZ4zSaMramt9qr0=;
        b=i5eR3iWB3AFVHIaZxSkjIGU/dtfG5JayZ6Gr96gMx9lNw3e2TrVyNpZPR+/iLlr7Y6
         QukmUBwmyMo9t70K9Ums2ol2Oyrpm+VSthwNaHjnio9bPEjo3RmBVKkGTxIZ8W7llaku
         j6/h2D+9rGhIQMsfGMIW9H9kYCY4M6dOqXZxISatPlZ4sh9MtuDPIx4IKBPzk9zxSlNK
         TMxguf8yNzp4yT8DW0Usu8F6ZiAnO8AHhGBOTFRyReMeBiK7yrQ8T3qJKhkrjMfu0x+J
         QDl0ocVrF0vldkuAsMy0vltTzF6HE7NAVRkqIZlPJJeC1/ncF6U+rMLKcH21jeoFYeUr
         31Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=47G3khZfLT5cqVkO4QSozfWy25QpSZ4zSaMramt9qr0=;
        b=F2X8iI735OAwnx5fYztVtelH4ep5Hhk1wqZonsZ9PA240B+gyBihbLaap0j1QE0pbb
         Pt+mM42TzCJ1pVl6PUI8f4Nsm3JBg8G7oqXnkhi2RTbH3Qhj4MkQhlEglWyqEI/gMdx2
         ejcLfFXqIK2UjtxnqldRnmPERZf7LdFPrZNHN8vF1tXgPPr2q9V4bY9t5KHTow18FeyC
         RvOWAwWdo4RSoiUKf3y1bpjDQW38AcRRug/Fi+He5fBiBKUMgNpCYxCGrdDYW6gAAYw0
         w3kZgGejuKfn4XFFK0loTnf0FsKbqHaZlIJQhJR/QKi34H871VksgbqfuFMVZ/A4eiuM
         +ucg==
X-Gm-Message-State: APjAAAU4jxECRGFv6+EPneG/JcszcsIBmElyfqcNPwjerTbMOSzSBHOY
        6BMI4iCpxj8PLB/sl1KNuwDDepcg
X-Google-Smtp-Source: APXvYqxtKluaewtDQ8gF7vf27nPGKMNc/h9Sbi9vpu9inTrO9lB2S7ra0ot3y0H9guTiT7zpGtH9JQ==
X-Received: by 2002:a65:4343:: with SMTP id k3mr64404656pgq.384.1555251307787;
        Sun, 14 Apr 2019 07:15:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s19sm64845789pfe.74.2019.04.14.07.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 07:15:07 -0700 (PDT)
Date:   Sun, 14 Apr 2019 07:15:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] watchdog: renesas_wdt: drop superfluous glob pattern
Message-ID: <20190414141506.GA20689@roeck-us.net>
References: <20190414100306.1221-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414100306.1221-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Sun, Apr 14, 2019 at 12:03:06PM +0200, Wolfram Sang wrote:
> If we want to match all revisions, it is enough to leave the field
> empty.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Only build tested, no HW. Found by code review.
> 
>  drivers/watchdog/renesas_wdt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index 94cd8830ba9a..565dbc1ec638 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -151,7 +151,6 @@ static const struct soc_device_attribute rwdt_quirks_match[] = {
>  		.data = (void *)1,	/* needs single CPU */
>  	}, {
>  		.soc_id = "r8a7792",
> -		.revision = "*",
>  		.data = (void *)0,	/* needs SMP disabled */
>  	},
>  	{ /* sentinel */ }
> -- 
> 2.11.0
> 
