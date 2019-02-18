Return-Path: <SRS0=tGrw=QZ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DB3C43381
	for <linux-watchdog@archiver.kernel.org>; Mon, 18 Feb 2019 16:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9DC214DA
	for <linux-watchdog@archiver.kernel.org>; Mon, 18 Feb 2019 16:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaQgJrdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbfBRQMo (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:12:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39799 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731094AbfBRQMn (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 18 Feb 2019 11:12:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so8936016pld.6;
        Mon, 18 Feb 2019 08:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LZmElH+mybkh2stmXmgWswK7a0p8R9Lfl8zMLPlc6kg=;
        b=oaQgJrdv+OJvlVQ9brJ7F1AO9FKjYq1nyAD8u7YGd3wPmpxJhdf3vxXGyMEOAHlFZU
         aifMtZZBSlaADVMvSNMEYL7u5LylmndXNuGhKcON7jtofJ6ujoxL0fLAr6yRzHPXUWS2
         vkbTlaG2RfEaccUyqHr6bsIXbVHX+Jwy6RqHN7b6SoaCyWiPaj7LXx5bS7b8LuN6Myrr
         GP0L+gcJlbLcoRvaenYJjaKOGR79RzKqye0nY0M4MaZODcNwStTnZctw13E3Sn5GnDFg
         Pa2Wh9dV71SgsCACPElkjOqBaERijCZ2XzI0+9dPT01ZVQ0mfvK8QnOdR2onWBP6q7jQ
         6FSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LZmElH+mybkh2stmXmgWswK7a0p8R9Lfl8zMLPlc6kg=;
        b=fAT6ayaPOAESXLaifkQ6362pW/pWkxLRUDT9O3+zgaRO3V3zqqDAY5SC+H93KpbJQ+
         2tQIGuxepyLCMVuDPht+mFY1okbZxlZ4KKcgW2JuFdTHRcDKjtAa7v+Aaec9I3KR3ce6
         sy0GlkYL6PI1YGNegigwGC4kYdFle0c+K12MiCPL6WUimjlf+wEHRA9UIjyCZzCZx2rR
         kyAhCC4vpxo6s4TJtXONiCMVYPqom0RmyRBTTiRhIwDaucbuxkPrTHq8gsBnUu4alafz
         T3YRxPqarUbUZVVzSEzaha6pjn6+qAFozOlfUEXRv08fNq9Oj3Yfzds149vHG1JBSdIk
         MktA==
X-Gm-Message-State: AHQUAuZhOPMo7WFzBd4pmYEsIWXfGNp4f2GufcfBYioRgEJpikIPZHhK
        QfNos9nxodjryFvkV/JIyac=
X-Google-Smtp-Source: AHgI3IaIhZ5NuXEGMKriI0ymlwTNmGHuyDLUnJCo8lZp+Uj0rrbsUv09WIOAyO8GBTUxgkMc2m2QCw==
X-Received: by 2002:a17:902:2a47:: with SMTP id i65mr26300259plb.237.1550506363167;
        Mon, 18 Feb 2019 08:12:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 125sm19086340pfx.159.2019.02.18.08.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 08:12:42 -0800 (PST)
Subject: Re: [PATCH v2 1/3] platform_data/mlxreg: addittions for mellanox
 watchdog driver.
To:     michaelsh@mellanox.com, wim@linux-watchdog.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-watchdog@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, vadimp@mellanox.com
References: <20190207211053.10766-1-michaelsh@mellanox.com>
 <20190207211053.10766-2-michaelsh@mellanox.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a48b4759-c0c1-b2df-0e98-99d39f9b4161@roeck-us.net>
Date:   Mon, 18 Feb 2019 08:12:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207211053.10766-2-michaelsh@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 2/7/19 1:10 PM, michaelsh@mellanox.com wrote:
> From: Michael Shych <michaelsh@mellanox.com>
> 
> There are two new fields added to mlxreg core structure:
> features - supported features of device and
> identity - device identity name.
> Add new defines for watchdog features.
> 
> Signed-off-by: Michael Shych <michaelsh@mellanox.com>
> 

Subject: s/addittions/additions/

Otherwise

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v1->v2
> Change feature name MLXREG_CORE_WD_FEATURE_NOSTOP_AFTER_START
> to MLXREG_CORE_WD_FEATURE_NOWAYOUT
> ---
>   include/linux/platform_data/mlxreg.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
> index 19f5cb618c55..aadc80700573 100644
> --- a/include/linux/platform_data/mlxreg.h
> +++ b/include/linux/platform_data/mlxreg.h
> @@ -35,6 +35,8 @@
>   #define __LINUX_PLATFORM_DATA_MLXREG_H
>   
>   #define MLXREG_CORE_LABEL_MAX_SIZE	32
> +#define MLXREG_CORE_WD_FEATURE_NOWAYOUT		BIT(0)
> +#define MLXREG_CORE_WD_FEATURE_START_AT_BOOT	BIT(1)
>   
>   /**
>    * struct mlxreg_hotplug_device - I2C device data:
> @@ -110,11 +112,15 @@ struct mlxreg_core_item {
>    * @led_data: led private data;
>    * @regmap: register map of parent device;
>    * @counter: number of led instances;
> + * @features: supported features of device;
> + * @identity: device identity name;
>    */
>   struct mlxreg_core_platform_data {
>   	struct mlxreg_core_data *data;
>   	void *regmap;
>   	int counter;
> +	u32 features;
> +	char identity[MLXREG_CORE_LABEL_MAX_SIZE];
>   };
>   
>   /**
> 

