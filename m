Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D44C10F13
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 13:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8195820870
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 13:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMAH4qBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfDNNZk (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:25:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42028 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfDNNZj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 09:25:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id cv12so7287231plb.9;
        Sun, 14 Apr 2019 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LCk3KN7WIULVyevSFhTQl1lhoIq7hUo5mmkcPuBAs3Q=;
        b=ZMAH4qBCSbBJBOkv9wI83lOGkmZ/+Z6tEUYz1QGuCIcdnlypUtj1vK/CTx94plAmTO
         6FT2VjWVEDXY+R05nfnD4UdJF8vY4dqWxTPoo+koOrs+12JnZMVKVLv5cNA91FKSI7Cs
         pUFyzo9UruGSAV+cZTtScVYGUwsbXGcAvMw5NXsph/Irt67pkCxVlECZDw9mmtO7KQpl
         dTaUkIriR5Qa/OzOfzjrH/P+SHjpUsrh8tFUxBnH+/JRPRgMIGq6Lm3mUJ4ZOYvyf0A5
         BLDxGoMe88P3fSDpZrBBMCjaisJpiV8fic2izqh3xcJ0e0u74npMyO6VjbzJNfw9qDOa
         I4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LCk3KN7WIULVyevSFhTQl1lhoIq7hUo5mmkcPuBAs3Q=;
        b=QS7Y1EQ3Z7OyKJ+TntTU4LrX1p5FYkkDsjfQBf8x+Xio90XIfxO/wCQy6/vRbpf/sd
         1ybywmVjx+ZYjDsEbeIb2P8Dx6BKP+5hIsYw5G34wUpEzsnH7nRDGdo6WMR32guBv+aw
         KssQsvNxZCy7raGXyonbKUTaP6ShBwZJ4gI6W+moxkHRritqeURqI6ouPpdFa1rCjhZL
         tfkZmFq/T30ZQmjqlxVDMd4OJHsCKYYbnvDwlGk2b+CuN/eETH7cVzv4c//CYxfTe9Al
         s7419hArgi+Cazey8017j1gtvju6tJXp/TFrrE4awvYqmnENMmrbv7tFp9sQ4ftD+kQZ
         N44w==
X-Gm-Message-State: APjAAAW3SKTZZlOoLqKNsT65kM3fBQvnnEZ4ea3J9/OA18KPvVBYMKjV
        GNdhXcczZ0MItnLHCL6dOueLNRko
X-Google-Smtp-Source: APXvYqwA6oi6CCSNOkvd4T2DSA8fb00f9q88f8s3Gz91cvwIeb6eeXIyS+7n2GO8+Bs8wETG95zWrQ==
X-Received: by 2002:a17:902:e101:: with SMTP id cc1mr70008609plb.129.1555248338898;
        Sun, 14 Apr 2019 06:25:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2sm62533680pfb.80.2019.04.14.06.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 06:25:37 -0700 (PDT)
Subject: Re: [PATCH 01/16] watchdog: refactor watchdog_init_timeout
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
References: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
 <20190414102627.5564-2-wsa+renesas@sang-engineering.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <64e8adf0-cf87-3d54-4513-fd531ab7b7f2@roeck-us.net>
Date:   Sun, 14 Apr 2019 06:25:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190414102627.5564-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 4/14/19 3:26 AM, Wolfram Sang wrote:
> The function is not easy to read and has two problems: a) -EINVAL is
> returned when the module parameter is invalid but the DT parameter is
> OK, and b) for the module parameter, zero is a valid value but for DT it
> is invalid.
> 

That was on purpose: A module parameter of 0 reflects that no module parameter
was provided, which is not an error. An explicit DT property with value 0 _is_
an error and does not make sense. "use the default", in the DT case, can and
should be expressed by providing no property, not by providing a property with
value 0.

Guenter

> Refactor the code to have a the same pattern of checks for the module
> parameter and DT. Further ones can be easily added in the future if the
> need arises. The above mentioned problems are fixed, too.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   drivers/watchdog/watchdog_core.c | 33 ++++++++++++++++++---------------
>   1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index eb8fa25f8eb2..85c136acc0e9 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -104,10 +104,11 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
>    * Initialize the timeout field of the watchdog_device struct with either the
>    * timeout module parameter (if it is valid value) or the timeout-sec property
>    * (only if it is a valid value and the timeout_parm is out of bounds).
> - * If none of them are valid then we keep the old value (which should normally
> - * be the default timeout value).
> + * If none of them are valid or all of them are zero ("don't care") then we keep
> + * the old value (which should normally be the default timeout value).
>    *
> - * A zero is returned on success and -EINVAL for failure.
> + * A zero is returned on success or -EINVAL if all provided values are out of
> + * bounds.
>    */
>   int watchdog_init_timeout(struct watchdog_device *wdd,
>   				unsigned int timeout_parm, struct device *dev)
> @@ -117,22 +118,24 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
>   
>   	watchdog_check_min_max_timeout(wdd);
>   
> -	/* try to get the timeout module parameter first */
> -	if (!watchdog_timeout_invalid(wdd, timeout_parm) && timeout_parm) {
> -		wdd->timeout = timeout_parm;
> -		return ret;
> -	}
> -	if (timeout_parm)
> +	/* check the driver supplied value (likely a module parameter) first */
> +	if (timeout_parm) {
> +		if (!watchdog_timeout_invalid(wdd, timeout_parm)) {
> +			wdd->timeout = timeout_parm;
> +			return 0;
> +		}
>   		ret = -EINVAL;
> +	}
>   
>   	/* try to get the timeout_sec property */
> -	if (dev == NULL || dev->of_node == NULL)
> -		return ret;
> -	of_property_read_u32(dev->of_node, "timeout-sec", &t);
> -	if (!watchdog_timeout_invalid(wdd, t) && t)
> -		wdd->timeout = t;
> -	else
> +	if (dev && dev->of_node &&
> +	    of_property_read_u32(dev->of_node, "timeout-sec", &t) == 0 && t) {
> +		if (!watchdog_timeout_invalid(wdd, t)) {
> +			wdd->timeout = t;
> +			return 0;
> +		}
>   		ret = -EINVAL;
> +	}
>   
>   	return ret;
>   }
> 

