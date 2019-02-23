Return-Path: <SRS0=mrOV=Q6=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC16C43381
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Feb 2019 17:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875A120657
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Feb 2019 17:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVL+Dh6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfBWRMI (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 23 Feb 2019 12:12:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43710 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfBWRMI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 23 Feb 2019 12:12:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id m10so2508748plt.10;
        Sat, 23 Feb 2019 09:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QUZFiiG/rcUKEAIYD3DVHnicEKeO+0h3900EAsmV+Ac=;
        b=MVL+Dh6XFBRJYOW+yz4Xe3PjQcD+tZt5enLIhhzxXDMJsbnqp+MULvtJRdQmDtKoCe
         gzly+L+HkWwHnqs9WKiC2Gl2OZIGlpeDawWN0i84gqjlhI61iyhyJabfL3NoSzMdkOP8
         Ye9H9fx2jNhDYMCvqCCp4sEKPBXZxhvPxhjcA7auPHzm9msotbkw51VGZiTH7pyVxsgF
         BmYtpm/5bMXFRICiXT1stAzN7o4plxBljJvHSjYpVI0gLh5ogCfZfkZFods2bm5Hsz6N
         DWJ06Lf6Hi1PvE8C4rWM6czxIoOqtsMTvaGc7/He4LiOHll9KUN6onfFCPo5zWn/gO2j
         3O3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QUZFiiG/rcUKEAIYD3DVHnicEKeO+0h3900EAsmV+Ac=;
        b=t3a89R6qlQ/ue6y657P79GXNPk7fZi9P7tXY5YKAW8WsCXzxJPmQxSA1aaoi2D0c7A
         MXEA785mriajqLf6vIQw0LsKBPcPheiomVEpEQCMHjqE4iaCUi6bmL7xqufx2n2B6zvz
         G6aT3MKJvTIxMWVyNeBCW7KbHN30QImqYIiAMavaO5LkRCdBg/3SDQbyeNh9Rlht7Vrr
         45YjLUSmYouIw+7jmoH32TeKVD1LOGq7/lOreOu1OPyPSsQhEPS4TSGHTBjY0keWWqkj
         FaX8zUNdYiO60056EBmWxE4Uk1TlD4m2Sn1l00kfRM21wr4afMumQNU2oS4uC1etG9Dp
         VasA==
X-Gm-Message-State: AHQUAuaOeH+Heas2wbHSdyGuFSzyxaW/vi3WcdHIlNh236suZWK/tYmw
        YMRBS/YLkfoD8YgFJ4CXU9s=
X-Google-Smtp-Source: AHgI3IYHJLB6KxlBCyBeY1ueD/wZq2tQOHBVw8xXUtsubXcfbFdH2Ledni7Jxg26WKfV+I/xRmFpbA==
X-Received: by 2002:a17:902:b598:: with SMTP id a24mr10352289pls.27.1550941927379;
        Sat, 23 Feb 2019 09:12:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x15sm6632140pfn.74.2019.02.23.09.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 09:12:06 -0800 (PST)
Subject: Re: [PATCH v4 1/3] platform_data/mlxreg: additions for Mellanox
 watchdog driver.
To:     michaelsh@mellanox.com, wim@linux-watchdog.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-watchdog@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, vadimp@mellanox.com
References: <20190220093424.5374-1-michaelsh@mellanox.com>
 <20190220093424.5374-2-michaelsh@mellanox.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1b3f9492-7085-4c2e-69ec-a30dfb2185f6@roeck-us.net>
Date:   Sat, 23 Feb 2019 09:12:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220093424.5374-2-michaelsh@mellanox.com>
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
> There are two new fields added to mlxreg core structure:
> features - supported features of device and
> identity - device identity name.
> Add new defines for watchdog features.
> 
> Signed-off-by: Michael Shych <michaelsh@mellanox.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> v1->v2
> Change feature name MLXREG_CORE_WD_FEATURE_NOSTOP_AFTER_START
> to MLXREG_CORE_WD_FEATURE_NOWAYOUT
> ---
> v2->v3
> 1. Move enum enum mlxreg_wdt_type from mlx_wdt driver to common mlxreg.h
> 2. Add version field to mlxreg_core_platform_data struct.
> ---
>   include/linux/platform_data/mlxreg.h | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
> index 19f5cb618c55..31f7c25a44da 100644
> --- a/include/linux/platform_data/mlxreg.h
> +++ b/include/linux/platform_data/mlxreg.h
> @@ -35,6 +35,19 @@
>   #define __LINUX_PLATFORM_DATA_MLXREG_H
>   
>   #define MLXREG_CORE_LABEL_MAX_SIZE	32
> +#define MLXREG_CORE_WD_FEATURE_NOWAYOUT		BIT(0)
> +#define MLXREG_CORE_WD_FEATURE_START_AT_BOOT	BIT(1)
> +
> +/**
> + * enum mlxreg_wdt_type - type of HW watchdog
> + *
> + * TYPE1 HW watchdog implementation exist in old systems.
> + * All new systems have TYPE2 HW watchdog.
> + */
> +enum mlxreg_wdt_type {
> +	MLX_WDT_TYPE1,
> +	MLX_WDT_TYPE2,
> +};
>   
>   /**
>    * struct mlxreg_hotplug_device - I2C device data:
> @@ -110,11 +123,17 @@ struct mlxreg_core_item {
>    * @led_data: led private data;
>    * @regmap: register map of parent device;
>    * @counter: number of led instances;
> + * @features: supported features of device;
> + * @version: implementation version;
> + * @identity: device identity name;
>    */
>   struct mlxreg_core_platform_data {
>   	struct mlxreg_core_data *data;
>   	void *regmap;
>   	int counter;
> +	u32 features;
> +	u32 version;
> +	char identity[MLXREG_CORE_LABEL_MAX_SIZE];
>   };
>   
>   /**
> 

