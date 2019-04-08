Return-Path: <SRS0=d+ns=SK=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5AEC10F13
	for <linux-watchdog@archiver.kernel.org>; Mon,  8 Apr 2019 19:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F19A20863
	for <linux-watchdog@archiver.kernel.org>; Mon,  8 Apr 2019 19:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8/ezIO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbfDHTmI (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:42:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41626 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfDHTmH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 8 Apr 2019 15:42:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so8210582pfd.8
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Apr 2019 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8YAxdK92GZBQ0ZxjM5dhBfP64vYKxGrey7G85fhS+eE=;
        b=c8/ezIO3NlXG1AMqFEe0cNYlJ9SqeYkiJbCnfP3yx3DuCmnakWFndjmKp+1DtQk3rU
         JJaxz8lIgTpwIjoCDn/dlxBzbEfe2hSVp1KlB/jb7VI+Yl31Whjb/ncZQ9BNkaXcZQpy
         R+8pc/H36EFObpsyQHpkj00adew5/9jFZx3X9bqoBdPFuyRS4QbdI1GRGK6WvKq+U7xI
         SYTs7SSL6JINB4Drq6nZzgKY2hXQoWVhOXsg/Y2VzGSstAvsaLJp+7op6UMJXFjY38eU
         icmrOhuj9CCKx8S/BuQJcg5lxewHIEiLM7KqlcpB59XQAxUsKLDik4cjSOooslHap3oz
         Jq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8YAxdK92GZBQ0ZxjM5dhBfP64vYKxGrey7G85fhS+eE=;
        b=jBxsvxu9EuG36jy/64rK7PSH/Z+8/pMsy71d2XHhcSkxZEtJgTgOWGEtBP9aKA+36p
         frdzk1TTA+Xz54uIAiE8dKhbPvzq577dr7trNzEdvFj1efDCN8d9NlRe0/7fPnKcO7ni
         yeD8uyqahaIZmDXuiTSFHyooTZ3ZWihEyR/ZshsErlquY3bmjU+Mn+r3faj2sTUiL1rU
         SS2SVT6wx3OzBs/wTEt/0D6qy32qn+YYw7lU2cvqqKaAEKCGExeMzJDUhKN/MTs6RNuO
         y8hPnrjqmFmw4GO9tkQPhuddyLKEGrYIda4rD6xE6IXXcXM4f0a1dK0TWaksr42j4sUx
         Y/iA==
X-Gm-Message-State: APjAAAVTStyw3YSaeuPy+29dxY+cMsDAjuryNPLlwk0+G1FwqjbslTfo
        rJ7mx9yhTZkGXniZJsLvLIk=
X-Google-Smtp-Source: APXvYqzAvMgtAcUH2SryTBhVVipHnOOtvbPGzWZn0qrsf9AspmMmUxg+uFwNzajU57eFG+ULPmqy9A==
X-Received: by 2002:a63:ad4b:: with SMTP id y11mr28957704pgo.405.1554752527100;
        Mon, 08 Apr 2019 12:42:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v7sm42271351pgh.53.2019.04.08.12.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:42:06 -0700 (PDT)
Date:   Mon, 8 Apr 2019 12:42:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Georg Hofmann <georg@hofmannsweb.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: imx2_wdt: Fix set_timeout for big timeout
 values
Message-ID: <20190408194205.GA27076@roeck-us.net>
References: <66814249.3190.1554751554223.JavaMail.zimbra@hofmannsweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66814249.3190.1554751554223.JavaMail.zimbra@hofmannsweb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Mon, Apr 08, 2019 at 09:25:54PM +0200, Georg Hofmann wrote:
> The documentated behavior is: if max_hw_heartbeat_ms is implemented, the
> minimum of the set_timeout argument and max_hw_heartbeat_ms should be used.
> This patch implements this behavior.
> Previously only the first 7bits were used and the input argument was
> returned.
> 
> Signed-off-by: Georg Hofmann <georg@hofmannsweb.com>

This time it applied, thanks.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  drivers/watchdog/imx2_wdt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 2b52514..7e7bdcb 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -178,8 +178,10 @@ static void __imx2_wdt_set_timeout(struct watchdog_device *wdog,
>  static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
>  				unsigned int new_timeout)
>  {
> -	__imx2_wdt_set_timeout(wdog, new_timeout);
> +	unsigned int actual;
>  
> +	actual = min(new_timeout, wdog->max_hw_heartbeat_ms * 1000);
> +	__imx2_wdt_set_timeout(wdog, actual);
>  	wdog->timeout = new_timeout;
>  	return 0;
>  }
