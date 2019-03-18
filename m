Return-Path: <SRS0=lwmN=RV=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0350C43381
	for <linux-watchdog@archiver.kernel.org>; Mon, 18 Mar 2019 02:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C15E20857
	for <linux-watchdog@archiver.kernel.org>; Mon, 18 Mar 2019 02:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTYikOiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfCRCxf (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 17 Mar 2019 22:53:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43329 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfCRCxf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 17 Mar 2019 22:53:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so3578245pfd.10
        for <linux-watchdog@vger.kernel.org>; Sun, 17 Mar 2019 19:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oIGXl+pyat9fxGPpvrnPev2NhfTsPPCBxMQLtBy718I=;
        b=tTYikOiDw2r7yAZjjhq9QnbPBVGeEqeONsjqSJL5+zU3/IK749tXd6FE2zBH4ruqho
         ZmHuRZnlgMyhmQESq82FM3NmUdrNAXf186+VMK2AefdFOpdTZHAzAo1/euWxT4s9t5wA
         UrubCpV0+O4MQe9zV95biVdziwK7oUOCFdeQ7z3QN8u7SkB5c3FOYx1BsNLjLZcY0VDo
         Qv3lYnLRluejFO38p+agjJkbtYAJjAG6sGjLm6NXe1audX1h5fP7lqdI21kMlRRkyb6n
         gfWq8Zi6RWmta5KgA7hfaRCviWsSIEHAB7P7dRQN86nbwZEO7aaf6jgSiMOSxqrm1eA7
         UW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oIGXl+pyat9fxGPpvrnPev2NhfTsPPCBxMQLtBy718I=;
        b=Uqxl7cdCpbuURps4xk19i5aPkakuZmiZSERAJO7kzVTSfrx6cyH/PuFkPINTOw08Vi
         +k7JZuu+CMvkhRCaLV1wXASkhjF+oO8LLIbnUvhxjy369oy3TmTKEbzFtpwrvv4gZdFD
         Z+VK8FGY7GKXPr6MIlIg/1kJ29SafEN14dnvAPWcugiCBkyumG7tSZ5AgdjSYsvjj7zX
         7FEYT5I9oGKhLxzju+tbQn6r4ZsszFfHz24Ij8k3Br49zetXuEgOCaWeYauOawH/IdnU
         7EyvWJTb+ue2d/LlxRChwNE3qrsCXj1KQ0YD3g2P8nSugu3Y277EEAgAaqkMbVJc4IGH
         sSpg==
X-Gm-Message-State: APjAAAX8yoWWWPMR0ipL9cjsiLIokLGD08YqGzXbM3ex7gzEc56LSz3E
        K1lYJWd3JKP9CP5zeOeqWDE=
X-Google-Smtp-Source: APXvYqzYm2tpE82uvV8BXXC1cIWwQcpif4azNgsRqP9C6ZZG2h34i1kkQTxq1XhsKCGbVgPuTWFWmg==
X-Received: by 2002:a63:5149:: with SMTP id r9mr15661966pgl.142.1552877614280;
        Sun, 17 Mar 2019 19:53:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m17sm13003269pff.170.2019.03.17.19.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 19:53:33 -0700 (PDT)
Subject: Re: [PATCH] watchdog: i6300esb: stop printing kernel addresses
To:     Matteo Croce <mcroce@redhat.com>, linux-watchdog@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>
References: <20190318011915.32442-1-mcroce@redhat.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5998d284-c714-0f46-ea3b-53cc8bf32a9b@roeck-us.net>
Date:   Sun, 17 Mar 2019 19:53:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318011915.32442-1-mcroce@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 3/17/19 6:19 PM, Matteo Croce wrote:
> Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
> i6300esb prints "____ptrval____" instead of actual addresses:
> 
>      i6300ESB timer 0000:00:03.0: initialized (0x(____ptrval____)). heartbeat=30 sec (nowayout=1)
> 
> Instead of changing the print to "%px", and leaking kernel addresses,
> just remove the print completely, cfr. e.g. commit 071929dbdd865f77
> ("arm64: Stop printing the virtual memory layout").
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/i6300esb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
> index 950c71a8bb22..e312a2aeecad 100644
> --- a/drivers/watchdog/i6300esb.c
> +++ b/drivers/watchdog/i6300esb.c
> @@ -328,8 +328,8 @@ static int esb_probe(struct pci_dev *pdev,
>   		goto err_unmap;
>   	}
>   	dev_info(&pdev->dev,
> -		"initialized (0x%p). heartbeat=%d sec (nowayout=%d)\n",
> -		edev->base, edev->wdd.timeout, nowayout);
> +		"initialized. heartbeat=%d sec (nowayout=%d)\n",
> +		edev->wdd.timeout, nowayout);
>   	return 0;
>   
>   err_unmap:
> 

