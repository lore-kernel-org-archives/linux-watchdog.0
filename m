Return-Path: <SRS0=aOtl=Q7=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630A5C43381
	for <linux-watchdog@archiver.kernel.org>; Sun, 24 Feb 2019 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BED20663
	for <linux-watchdog@archiver.kernel.org>; Sun, 24 Feb 2019 19:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghy9LAMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfBXTD5 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:03:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46820 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfBXTD5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 24 Feb 2019 14:03:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so3387208pfh.13
        for <linux-watchdog@vger.kernel.org>; Sun, 24 Feb 2019 11:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GuudPhwsCphqyBpsfEy6sHcz5BYS5Gqgf2Ig7dwWzFQ=;
        b=ghy9LAMiXEln9fNMgjfNhqEQEqjwLc5fVMycn2kCQ+tFBlox511Yhql4ArWysKLJIi
         nbqG3Hr1plL8JpLqX4LSs/Wb3xRDiG+rkdh0UO8dVBmGaWkBQi80ToE/F4PESkRV8ZZu
         dE8LZXil0KN+/uV+VIaMQdgN3+T0FVdu/6w+TLu7khQgbQ67jSZ8U4/ExruatgbhRkd7
         nsSET7q8CqegX4jW+yR9zKjMK0yh84ADz9uCwcbgoath5bynhpivR12wDvuXePf/bSFZ
         0etDahe9qNhuPIM/slHeRUB/te7+6y1KzJasc6KuILENZqZnxxXqgHRTe81AbTBCMpU5
         vxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GuudPhwsCphqyBpsfEy6sHcz5BYS5Gqgf2Ig7dwWzFQ=;
        b=EC0WjHdnqosnRJDDzs6f841CyLheXWz2gNe8ut3jcLtcYEREmBmTc7lDHWs8slp0yD
         kKzxCWlVSqo/kT96N4qQyzWmXL4LWhHqni4AwL6gTder5/ab8RTmkcEgBNSlU+IliNcw
         BUSFBeyp21rLEGETy3M6iOeoGLkh0kokRj3vvaQJ+CxRM21nGKWzRdocGTFigV16B71f
         3blqK+SeiQdo9Pp9vjMoXE+lYpOwFQ/25yUHxEi/vOX60jcDUghpJOp/ttE8qpfzo26t
         2RzcLHVxvR+yxbKz3n/Yc0acqxXgrB2p0GmlQBYUO31iBoExJQ7WcF7Vh2ZRG+DvIGU6
         OliQ==
X-Gm-Message-State: AHQUAuac9xnZjeQPNlgrQs2U2MQH/Lud0Vue0C6hLos3zc9pQmLFIu6P
        UOCT7mwri0SqloteDEmnWoY=
X-Google-Smtp-Source: AHgI3IZuUBP/dlRho3Qr4WaykSx+i82xLDaSZx4DX0Xnk4iug1tSyYK+0nWVRgL8qfbx/Wxn5L+xLQ==
X-Received: by 2002:a63:d64:: with SMTP id 36mr14454819pgn.360.1551035036291;
        Sun, 24 Feb 2019 11:03:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d131sm12571968pfd.108.2019.02.24.11.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 11:03:55 -0800 (PST)
Subject: Re: [PATCH v5 1/1] Documentation/watchdog: Add documentation mlx-wdt
 driver
To:     michaelsh@mellanox.com, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, vadimp@mellanox.com
References: <20190224172631.3920-1-michaelsh@mellanox.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <25e4c5dc-7090-f9e9-e0d1-a5404c65e20a@roeck-us.net>
Date:   Sun, 24 Feb 2019 11:03:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190224172631.3920-1-michaelsh@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 2/24/19 9:26 AM, michaelsh@mellanox.com wrote:
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
> v5->v4
> Fix typo in nowayout explanation.
> ---
>   Documentation/watchdog/mlx-wdt.txt | 52 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
>   create mode 100644 Documentation/watchdog/mlx-wdt.txt
> 
> diff --git a/Documentation/watchdog/mlx-wdt.txt b/Documentation/watchdog/mlx-wdt.txt
> new file mode 100644
> index 000000000000..66eeb78505c3
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
> +it can't be stopped.
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

