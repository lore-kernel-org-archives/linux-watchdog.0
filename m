Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B15CC10F13
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 15:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27CA20896
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 15:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vE5z42NC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfDNPlr (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 11:41:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40219 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNPlr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 11:41:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so7359133plr.7;
        Sun, 14 Apr 2019 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o12BXweLlummd5+x5XEfgvflbZnlQyiPVbINBVnkwpk=;
        b=vE5z42NCdk7wQX7YyRX7f/3CwCEHfVjxVlnlh7NZoTp7Ywx8+3qRAyHfVrTUaxdMuP
         1b9xssmJBt6AyEex3vnFfmalPE3xvOUCxltiNBd23jYN1grE6xjSEDw04l1dc0RnkAjs
         O6fNewPV4BClpye1RZ2k98qOkYZBr6W9jdwtG01js5vpvX/Bpqod3KT+BvYmv2xm4TOx
         pOf1WP+otRhIUHrfJPQBH4FA3Fr5kLk1DAWlotFH29/vxTGg8WTQQMtz9/DoAQ4Jc5aR
         yXivBoj842sRvWwDtcgNNSJs0UKU2dRZLnDjbje2MXUcqXPJne/rclt7lxWIWp166i/l
         A7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o12BXweLlummd5+x5XEfgvflbZnlQyiPVbINBVnkwpk=;
        b=frPgTSzT3ZgsIbXmJuLoeXlk6BWTh0HYEn9pbWm0tMAFRe9GfGuouwhtr5pa9LdWQN
         hjRGn4FrBu7qMx3BBOyDbQeplqQxSq4sZqPmfyq0dKh6AQDFayaZQ5jRHb+d8jtYcspd
         zdYGI6gU0Nt2OUPeHB78GkmIONVmRxebDeKbRKYnamOLHs79lAcJhSZZ6vUSGwTDQ1gv
         9iUbwu5gAgoSYNusudGw5o+Tc2m5SMqhLCZaGRjDrq/eqzdF7eSiWDCCm1PltBoRhxYg
         +iH7iCMnM1XO//OErEonROugdYX8xU6HeVAJsN+iO2Oy3KTheRebR/ciPpd4MdIbtqtB
         0iLg==
X-Gm-Message-State: APjAAAXji4CRhLRhS3JxnfTuRNNBk4rcyzEsGtkgvsiys6NM5D+sialp
        GJeXvvWufB39a2H2GjlU+YvHQ4Iu
X-Google-Smtp-Source: APXvYqwJvygvb/p4lELoMUUQb+1m1mlgBnG1mnzHVcwSdtfz49UAPnrnWrV05kmmDSWFO2EcVNw7Dg==
X-Received: by 2002:a17:902:163:: with SMTP id 90mr40930287plb.34.1555256506223;
        Sun, 14 Apr 2019 08:41:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y191sm16196079pgd.78.2019.04.14.08.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 08:41:45 -0700 (PDT)
Subject: Re: [PATCH 00/16] watchdog: refactor init_timeout and update users
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
References: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <10f8ee1f-347a-127d-1ebb-84a415ec11d3@roeck-us.net>
Date:   Sun, 14 Apr 2019 08:41:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 4/14/19 3:26 AM, Wolfram Sang wrote:
> When trying to add DT support to the DA9063 WDT, I didn't want to add yet
> another error message when watchdog_init_timeout fails. The core could do this
> with more detail, and also much more consistent. So, I refactored this routine
> and removed error strings from its callers. Note that DA9063 support is not
> added here because I still need to think about another issue. But this series
> has been tested using the renesas_wdt driver on a Renesas Salvator-XS board
> (R-Car M3N) and build bot is happy, too.
> 
> Looking forward to comments.
> 

I like the idea. We should probably do the same for [devm_]watchdog_register_device().

For the series, except patch 1:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> Thanks,
> 
>     Wolfram
> 
> Wolfram Sang (16):
>    watchdog: refactor watchdog_init_timeout
>    watchdog: add error messages when initializing timeout fails
>    watchdog: cadence_wdt: drop warning after calling
>      watchdog_init_timeout
>    watchdog: cadence_wdt: still probe if user supplied timeout is invalid
>    watchdog: ebc-c384_wdt: drop warning after calling
>      watchdog_init_timeout
>    watchdog: hpwdt: drop warning after calling watchdog_init_timeout
>    watchdog: i6300esb: drop warning after calling watchdog_init_timeout
>    watchdog: imx_sc_wdt: drop warning after calling watchdog_init_timeout
>    watchdog: ni903x_wdt: drop warning after calling watchdog_init_timeout
>    watchdog: nic7018_wdt: drop warning after calling
>      watchdog_init_timeout
>    watchdog: renesas_wdt: drop warning after calling
>      watchdog_init_timeout
>    watchdog: sp5100_tco: drop warning after calling watchdog_init_timeout
>    watchdog: st_lpc_wdt: drop warning after calling watchdog_init_timeout
>    watchdog: stm32_iwdg: drop warning after calling watchdog_init_timeout
>    watchdog: xen_wdt: drop warning after calling watchdog_init_timeout
>    watchdog: ziirave_wdt: drop warning after calling
>      watchdog_init_timeout
> 
>   drivers/watchdog/cadence_wdt.c   |  7 +------
>   drivers/watchdog/ebc-c384_wdt.c  |  5 +----
>   drivers/watchdog/hpwdt.c         |  3 +--
>   drivers/watchdog/i6300esb.c      |  5 +----
>   drivers/watchdog/imx_sc_wdt.c    |  5 +----
>   drivers/watchdog/ni903x_wdt.c    |  4 +---
>   drivers/watchdog/nic7018_wdt.c   |  5 +----
>   drivers/watchdog/renesas_wdt.c   |  4 +---
>   drivers/watchdog/sp5100_tco.c    |  4 +---
>   drivers/watchdog/st_lpc_wdt.c    |  4 +---
>   drivers/watchdog/stm32_iwdg.c    |  6 +-----
>   drivers/watchdog/watchdog_core.c | 39 ++++++++++++++++++++++++---------------
>   drivers/watchdog/xen_wdt.c       |  4 +---
>   drivers/watchdog/ziirave_wdt.c   |  6 +-----
>   14 files changed, 37 insertions(+), 64 deletions(-)
> 

