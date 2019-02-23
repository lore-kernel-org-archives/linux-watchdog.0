Return-Path: <SRS0=mrOV=Q6=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FABCC43381
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Feb 2019 17:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238B020657
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Feb 2019 17:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTZ0/XvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfBWRNT (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 23 Feb 2019 12:13:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44571 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfBWRNT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 23 Feb 2019 12:13:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id c4so2508238pls.11;
        Sat, 23 Feb 2019 09:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cWlm9ovMe+lSBfjZW7AxbtK+wec1u7GoXFCRkRfP5Xk=;
        b=JTZ0/XvFS/rm950hADhREi2NtCP/u51hDnZGRvVbVSYdj6C1nPvQix7xutK90pwusx
         5Qf6+EPKTwTNE7OfZPh7cHyUeTRcq2s4SMv4Wi69INQEZ/CkZ9287Dn9As1eZ/3xhE+G
         dkOpxfErmAqME4OvLq2guj3Li6Egy/4Azibk+UYJ7R8inWOxNLXeluHBGUqH9vPyT0h+
         9Zuk/w2IOtWpVVhFxs1vL6icTsHUYVt+eXdEDhe2IjbyItbYSOUJ1/51jpefYtdGu7rl
         9oHbfQTF2HmJlRO9VfZrWhNthgEPkUr3MnawkaX6fv5pFfA8otnnztHkHx77kEGBjC8/
         thyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cWlm9ovMe+lSBfjZW7AxbtK+wec1u7GoXFCRkRfP5Xk=;
        b=cBVOgCzVAMhJwD7DtGpHDCd0HRrVmNX3DKKFFzR94y1diQQZID8mpuzINRsPlH8b1y
         1IUkg5YLb6TxK566KAM+zstD/pg3XbJC4/ZnRBziurBOlu5RcXOXbtmhmp0rDJGjXUJg
         BaMlWi+iKCgE1yQBZcSOYrtMEy5nssQEiR8Te+TOsiBMnw7atyJg/yZ77tzxHSPzxVLx
         8MhU5AijTOqmYTmysiJ0y98hGpwLILnOiokim4X0iDmd+1Wslqxs0eZ0bKeJpx2cxyHv
         PEc9/r7uFafamXNS/nzX2L9iKa2u8FAzjaMP9RY+bOW3uYaOjFiPhpRhRX1BtHTkH9rH
         m9JQ==
X-Gm-Message-State: AHQUAuYmCdfnD4q6ggBrCLlesWg1o43UkO4encNkm4bxrWh2CQllTiyX
        c7Bd/SPo7MOFyU7IbEpDBoM=
X-Google-Smtp-Source: AHgI3IaBaYuxY3eZqD3Vv23Ddys5fv1eb6d+7Aqg3kPog/HYFT5Nb/+TJoN/A0V/2ZYF76ccqqX65A==
X-Received: by 2002:a17:902:f095:: with SMTP id go21mr10024060plb.199.1550941998997;
        Sat, 23 Feb 2019 09:13:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p14sm4916349pfn.91.2019.02.23.09.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 09:13:18 -0800 (PST)
Subject: Re: [PATCH v4 3/3] Documentation/watchdog: Add documentation mlx-wdt
 driver
To:     michaelsh@mellanox.com, wim@linux-watchdog.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-watchdog@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, vadimp@mellanox.com
References: <20190220093424.5374-1-michaelsh@mellanox.com>
 <20190220093424.5374-4-michaelsh@mellanox.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <da017855-5cde-97f3-5d5c-7d359adda740@roeck-us.net>
Date:   Sat, 23 Feb 2019 09:13:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220093424.5374-4-michaelsh@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 2/20/19 1:34 AM, michaelsh@mellanox.com wrote:
> From: Michael Shych <michaelsh@mellanox.com>
> 
> Add documentation with details of Mellanox watchdog driver.
> 
> Signed-off-by: Michael Shych <michaelsh@mellanox.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v1->v4
> 1. Remove sentence that now doesn't correspond to code.
> 2. Add explanations about nowayout and start_at_boot options.
> ---
>   Documentation/watchdog/mlx-wdt.txt | 52 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
>   create mode 100644 Documentation/watchdog/mlx-wdt.txt
> 
> diff --git a/Documentation/watchdog/mlx-wdt.txt b/Documentation/watchdog/mlx-wdt.txt
> new file mode 100644
> index 000000000000..434eadece41b
> --- /dev/null
> +++ b/Documentation/watchdog/mlx-wdt.txt
> @@ -0,0 +1,52 @@
> +		Mellanox watchdog drivers
> +		for x86 based system switches
> +
> +This driver provides watchdog functionality for various Mellanox
> +Ethernet and Infiniband switch systems.
> +
> +Mellanox watchdog device is implemented in a programmable logic device.
> +
> +There are 2 types of HW watchdog implementations.
> +
> +Type 1:
> +Actual HW timeout can be defined as a power of 2 msec.
> +e.g. timeout 20 sec will be rounded up to 32768 msec.
> +The maximum timeout period is 32 sec (32768 msec.),
> +Get time-left isn't supported
> +
> +Type 2:
> +Actual HW timeout is defined in sec. and it's the same as
> +a user-defined timeout.
> +Maximum timeout is 255 sec.
> +Get time-left is supported.
> +
> +Type 1 HW watchdog implementation exist in old systems and
> +all new systems have type 2 HW watchdog.
> +Two types of HW implementation have also different register map.
> +
> +Mellanox system can have 2 watchdogs: main and auxiliary.
> +Main and auxiliary watchdog devices can be enabled together
> +on the same system.
> +There are several actions that can be defined in the watchdog:
> +system reset, start fans on full speed and increase register counter.
> +The last 2 actions are performed without a system reset.
> +Actions without reset are provided for auxiliary watchdog device,
> +which is optional.
> +Watchdog can be started during a probe, in this case it will be
> +pinged by watchdog core before watchdog device will be opened by
> +user space application.
> +Watchdog can be initialised in nowayout way, i.e. oncse started
> +it can be stopped.
> +
> +This mlx-wdt driver supports both HW watchdog implementations.
> +
> +Watchdog driver is probed from the common mlx_platform driver.
> +Mlx_platform driver provides an appropriate set of registers for
> +Mellanox watchdog device, identity name (mlx-wdt-main or mlx-wdt-aux),
> +initial timeout, performed action in expiration and configuration flags.
> +watchdog configuration flags: nowayout and start_at_boot, hw watchdog
> +version - type1 or type2.
> +The driver checks during initialization if the previous system reset
> +was done by the watchdog. If yes, it makes a notification about this event.
> +
> +Access to HW registers is performed through a generic regmap interface.
> 

