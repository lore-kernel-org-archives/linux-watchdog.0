Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FF82D77E6
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161746; cv=none; b=JwAIXDTC4pt9jhkWQqZoazNBRSzmI32Wt4w3obzPCLOvlCbYBjFZ5YFXaBma8s2RzexgQ5/+GXd8FX5bzManD3ISNNS7G2i0v3/EHRqeqZSNUv7YpJPsfJyfC3gp9rSlo7X/DGRzzb+aafNlvsgCRpf260P7EgxUzEjanxOW+JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161746; c=relaxed/simple;
	bh=Pn412DYiAzxCT+4OPjStksFO/tbSj/zMlkHkGBtPatE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Efv0+Pg/7P9epfAmB5IKSHYtsFboliFJ1eJ+HsjERCRfzrKToxSnwspOOb52EnG3vc0Zb4JEieHWuQd+BoCdlk16bZu8bDXSqqXO0B5Qgi2Mrtu1GL92PSGIu9G/q6wBOZWAx++4xrTvqzQsd1YjxF9FPn+Z8JolXbYtM1sexMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmd+edKm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmd+edKm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cad4170e8eso76073755ad.3
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Jul 2026 17:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784161744; x=1784766544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OGQ6x2eWb0kXOAnv/GgXof7PDNge2C09gVvctRHhkCQ=;
        b=cmd+edKmzKMPZggls0FDrWBDODabc9rJtrdobsoPsNoxEc9BKSZfGXCLzcTJq0+cHK
         e1WfPqWDtA3jFpxSy+obtSQv5BrATtpz6kjW8Qlt29gcpr1uuZCKHtWtIWif0ceuh67Q
         Zflci0J8UK88Ldd3y09dIo2emaskL5z+h+oLZarokmgaHnO4ZDq0XV0bTq8UxG07/ofk
         rbNeLajf8Uz0xN0EZPtmTXjB86HFwRehGK6o+RhddP/xtNshX8tAKvwkl02w+ewCQqKy
         iTZBcCh8uaalgOUBAfBdvSkGpIWTqXHmME8X1X0waha3N9gNd3m96MqQp49luQ/q/Udf
         UWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784161744; x=1784766544;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OGQ6x2eWb0kXOAnv/GgXof7PDNge2C09gVvctRHhkCQ=;
        b=bX1+QacvhMkiPZaBSdFAZmRdmCY0rV1QAs5ZtyoBJ7z08QjCb1CnK9p2gmbfZ1oA8T
         QJMjPLQzrulVbwVgojyJopDllPbB6Xc8uKSEFRH59ZN93zB7xNbJOvDsFjzdz52Fsolo
         k2QI8g89qRXtp88zqofLgy5MqXWBIWeNZLCOBd8Oqmo2MVW0ch0MkIcOodn87IorkTU2
         l5gj9oTB2Sl9j2L5kBRTqYHIJj2e4/fPHigqZ+7FesuQQ2uDgntFzurt5abx7bixdEKL
         25BpnH/3go92aedws3b9AprW54O0bAeHFU4w0T17EkznK22aCLnXUQzPXZKpeX1xK+/Q
         scPg==
X-Forwarded-Encrypted: i=1; AHgh+Rrpk1UFpetlrZM25F0EOE1S0u93uJGfrL6Iw7RpdfaB9A/YtA2AXvwVXw4caMo8a8ViPrZYpS5GIfwwtxoexg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLr6ITW5uoJDffx9aAK3pAOgDBx3qa/Hqct+JA+m4BjUSYGehl
	hVqou4v41DgAp0urehru7jJSdDBpjlS4tIgmOikwDI9KnXMJR6n3nzFe
X-Gm-Gg: AfdE7ckbyWR2ugKKj/Vwp0+c6NdNUVRYIEHzyGusVNeQmUyJ6UUkRZ5Zj8oi2gcEe+I
	t17OoaRgRcwrPb201ihsdiV9Y3ge4QDeEIfsFvkrwNWWgl/CvW6YWWpZ/Ka/BMcoa/QwQq4+PBd
	6fI/vjUoYYCsSTeaoEywq7ltqZU0RcYk7U/ih8mj8j/FJ4pSQ8Vts0h5kFw2hPHCvqKZHMPNW5q
	+vf+nZYsEQtNUX8gM7x95w0O65S7gHBGUeKLH8XcJTp1b08uMQhPJNp1eO3lGT8kON6kiU4Sn9b
	JQ6cXWPbi9HhC/IW7lRqUr2tTgoYYqN1fHSQNo3tF9RA5zOlbJ4ZSNQt4ZOvz5PgVoZ40xgsmMv
	c6kzhf0GYRCKpubdyB4QJJTa8MUVeDqdA73LpnxNgYxHu/NRAyTB1B1nAhhddl+urwSifpARK9P
	9TdW9L1fvkM3w6z9GjTScopOjFu6Q6ILWkDPjoVdBt26zFMt362Ws=
X-Received: by 2002:a17:902:f683:b0:2ca:1479:d9dc with SMTP id d9443c01a7336-2cef1326596mr78291255ad.12.1784161744012;
        Wed, 15 Jul 2026 17:29:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf10591d3dsm10278195ad.56.2026.07.15.17.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 17:29:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b7171173-aa64-4393-b9cf-77d92f2ec932@roeck-us.net>
Date: Wed, 15 Jul 2026 17:29:01 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] Add Advantech EIO Hardware Monitor driver
To: Ramiro Oliveira <ramiro.oliveira@advantech.com>,
 Lee Jones <lee@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org, Wenkai Chung <wenkai.chung@advantech.com.tw>,
 Francisco Aragon-Trivino <francisco.aragon-trivino@advantech.com>,
 Hongzhi Wang <hongzhi.wang@advantech.com>,
 Mikhail Tsukerman <mikhail.tsukerman@advantech.com>,
 Thomas Kastner <thomas.kastner@advantech.com>
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-3-76e5e41026db@advantech.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260714-upstream-v2-v2-3-76e5e41026db@advantech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 08:54, Ramiro Oliveira wrote:
> This driver controls the Hardware Monitor block of the Advantech EIO chip.
> 
> There is a separate driver for the thermal device driver
> since it's a use case we support currently, but if it's
> really necessary we can move it to the same driver.
> 
> Signed-off-by: Ramiro Oliveira <ramiro.oliveira@advantech.com>

Normally there would be a hwmon driver instantiating the thermal zone(s)
using HWMON_C_REGISTER_TZ. If the driver actively controls thermal zones
since it also handles fans, that would be instantiated from the hwmon driver.

Since you have both thermal temperature and thermal fan drivers, I am very
concerned that there is functionality overlap andor even conflicts. You
should drop this driver and configure the thermal temperature driver
to instantiate a hwmon device from it if so desired.

Thanks,
Guenter

