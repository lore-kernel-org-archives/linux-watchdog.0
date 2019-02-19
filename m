Return-Path: <SRS0=TBvV=Q2=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3659AC10F00
	for <linux-watchdog@archiver.kernel.org>; Tue, 19 Feb 2019 17:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4CD20838
	for <linux-watchdog@archiver.kernel.org>; Tue, 19 Feb 2019 17:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTaRfyKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfBSRqh (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:46:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33119 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfBSRqh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 19 Feb 2019 12:46:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id y10so10793238plp.0;
        Tue, 19 Feb 2019 09:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ryMwAWm8LyrSWXCP5T0aLlO+Y2S7Lv7DdbmvhwBk2+A=;
        b=YTaRfyKl/T2liUukYz9eJ1Mo2T+EAy6CelM9vEQ9idXGSVlwuIT9s9pjatk1tNMeH6
         C1O6zY2Ls1gYmLmgWGUHUDgUlKajbnNfSUyKYe2sS2fXo7AQaoCiMAh569C1Qs4r1g1X
         3Mk8r6nXI7Uu3HEuEZav/cvdDNoYCuuUQ+WIJT8rBH2iP7yIArmxEvX7YgPtsPRGHaEJ
         zkquzO5le4R7YCTI9xvWzafOOIbAFoGzHbYCRGCGnlkevjY8bV5AVW8VldaQO+5vmAYL
         JEdUkqGwO+tL49a9Fp1z6/a4p/47xBTdnCr+Qp2ryr5IIAIofHW5PWuFTNZWEeFsvfoj
         5ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ryMwAWm8LyrSWXCP5T0aLlO+Y2S7Lv7DdbmvhwBk2+A=;
        b=Xh+Yxu0u3fBvhgsh+nt3fSZuTWGA8ATah1+qKnZWw/kyZ0Q28ufh17gDN1NCdqG5pG
         FpZzfM9Zbgj449bw6lQbcMuMut2adk3ZxpLuYnQvg5NKBUjqiaSYtRYPf+O+iNOKGipl
         hbOj56uq9oXLE04NAriIg2sggoQbkk2NDRAOApFZIDRfc0GDNcnEcSFNyQM57liu77d5
         F5qEFSDfOEa0YnSScTk5R2xqKFHQxxjd10lOBU4RcI7e+u8psXuCWQX12KD0P+Bgo/8q
         JbLlbvep918fTRqR7ffEawRYnBryZsdlrUEwgi7mZp/jTTsz5WAXr7qv6fNjQHXKL/z6
         6yMg==
X-Gm-Message-State: AHQUAubIrjJ/pDii7iA0+7D4Yefibvv9dj2niWe1gxd4Nb7mSf0Sjlbj
        AXJ76WTHJiCmicS6rcPZHmc=
X-Google-Smtp-Source: AHgI3IbH76+XPy2R6bVov4mBN64TgiDDyTbOEt578Es6+xZnsgE5ooET61w8JCUSRLjhqz8XquozTw==
X-Received: by 2002:a17:902:b102:: with SMTP id q2mr16004728plr.266.1550598396530;
        Tue, 19 Feb 2019 09:46:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 20sm11918021pfs.182.2019.02.19.09.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 09:46:35 -0800 (PST)
Subject: Re: [PATCH v2 2/3] watchdog: mlx-wdt: introduce watchdog driver for
 Mellanox systems.
To:     Michael Shych <michaelsh@mellanox.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Cc:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>
References: <20190207211053.10766-1-michaelsh@mellanox.com>
 <20190207211053.10766-3-michaelsh@mellanox.com>
 <92fff89b-7ea0-4ca1-730a-782696a453bd@roeck-us.net>
 <AM6PR05MB616801B974FE6C9057C75518D97C0@AM6PR05MB6168.eurprd05.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7f84cf2d-ebf2-3c39-635f-beb0da0ee092@roeck-us.net>
Date:   Tue, 19 Feb 2019 09:46:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <AM6PR05MB616801B974FE6C9057C75518D97C0@AM6PR05MB6168.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 2/19/19 9:00 AM, Michael Shych wrote:

>>> +	watchdog_stop_on_reboot(&wdt->wdd);
>>> +	watchdog_stop_on_unregister(&wdt->wdd);
>>> +	watchdog_set_drvdata(&wdt->wdd, wdt);
>>> +	rc = mlxreg_wdt_init_timeout(wdt, pdata);
>>> +	if (rc)
>>> +		goto register_error;
>>> +
>>> +	if ((pdata->features &
>> MLXREG_CORE_WD_FEATURE_START_AT_BOOT)) {
>>> +		rc = mlxreg_wdt_start(&wdt->wdd);
>>> +		if (rc)
>>> +			goto register_error;
>>
>> You do have to set HW_RUNNING here to inform the watchdog core that
>> the watchdog is running.
> 
> I understood from watchdog-kernel-api.txt document that this is not required
> In our case.
> " * WDOG_HW_RUNNING: Set by the watchdog driver if the hardware watchdog is
>    running. The bit must be set if the watchdog timer hardware can not be
>    stopped. The bit may also be set if the watchdog timer is running after
>    booting, before the watchdog device is opened. If set, the watchdog
>    infrastructure will send keepalives to the watchdog hardware while
>    WDOG_ACTIVE is not set."
> The 2nd and 3rd sentences from this quotation aren't true for our watchdog.
> Does it required anyway in spite that these cases are false?
> I added set of WDOG_HW_RUNNING  but I'm not sure that it's required.
> 

So you want the watchdog to time out and cause a reboot after the initial
watchdog period has expired and the watchdog device has not been opened ?
Fine with me, just please add a respective comment into the driver.

Thanks,
Guenter
