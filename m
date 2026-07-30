Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005C424E4B5
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 05:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785387810; cv=none; b=OC5mQv+xEcXjmnS6yOb+1pXxhMMN9v4+QJdg0bIv1Z5HH2+Qz6arktF9tckHJPo6G2TMhojKbshhZVG8GabH1c2FXqMftrE3HFO2iiNnqwkxkShwK2epI44Vd3dI5YUuoSu+WCSptYsAcVC+BPBEMrwcDYLsA2mwhuxqQmFhUeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785387810; c=relaxed/simple;
	bh=4uq7E7hb6S9mKSdM9uNBZiVt9oo2tWewHPIMY/ljRHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzGPdpzfMtKU9UzCF7LKml9SE2a7Yvm5dck95uVAL28/MM/8mtug8FD56qi4wG7rg3uYgERWFWnsNDqTaiAdHLFBSelIHi+sTEVfLwC8N8MzqBWfG2Dj9wn8+nRfxhONImD+zRJMLuT9QwBdumPy9yhhWfiQ6jZuGybTkLWp23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJARDjqz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJARDjqz"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1337443a91.2
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Jul 2026 22:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785387808; x=1785992608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YrJirBdTraCwj2DppjafVIyYOTXPcd0fOGRdreHju3Q=;
        b=XJARDjqzwbVsl24KRtTcLlhB+x6L/CqgWAnu6S7HgWsg2LJSeenSnM58B7Jnh9l93E
         EMGwI5cJkSKZoX4Q0oo60tNdF6EfdpNwarRJaygsG6nEe7MtdDzaCloGcEMhtJviqZso
         a4BCIymnb0ehs5R61DdbISC33UoiYf9cXO6eBjIgNCwUxtYPV+n2UokoPFU08JMZAxj1
         HrHDAYUJq1gp0YMfKWeZ8V3ZO6ca2sYWYhujSyVriKqjckYmLPJxUt8KvNYkxc+sPIUK
         Y2DOI0GM8OJ9Dj+TMv3PzrvMpUBbKVKst7xKhxK/HfQh95gn5FvaJ4SnnmY81BVeYvp7
         o2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785387808; x=1785992608;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YrJirBdTraCwj2DppjafVIyYOTXPcd0fOGRdreHju3Q=;
        b=Mr4QEXBiI36pJ/L81CbGk07yZfZQhhPhHr0wQ6ssoEY9wqUqrTTIbUtp5coy+6QK8J
         Y9J1fZz06XOseos+48wpxgFI5OYb1seIri/0g/XD514hzysya2U++y2z4LrR57fXryB4
         sDitfmNJxtGhVGntqcnGSEUvK3qdMhlnai3MY8gEYA7Kb5YfKZBvEkuhCgOzDgRUdRp6
         PNc4xTGFSd+fKc+LnDPsrjrelzw7XRWyH6QoUonV+JuGR0RZCT1jh05kp4j99muVe5uu
         Kt6If2p6JnZL6QW8vtQzaC1ZQSAxvC+eR/Ix5an+4gcfj4EaQGvOtIdjqlqDgxNQjGMD
         j6Iw==
X-Forwarded-Encrypted: i=1; AHgh+RqwJjoj0/xYjupxPUSZh65cewYbN7+ISrdV6hLhKWTPXXUkZA1b/AQQwod/S64L399E6H3FukwU+kXt6+R55Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxedZtok8ThiFmXkd9P1eUTAyY8cE+nhllSR7lBKfs/C1ohfyfm
	82DFtue4X2l4WkRhwVPrkqUIgHTs/JF9OH0auDR+oFnErJWGj4pUiFJF
X-Gm-Gg: AR+sD12ZOsIMwclTtnuaVOTqVSjA5XbwJymwZishjjmZVED3wL8PtYAm8jYOwBGU7+P
	b64MMd1BWX2LjrRbCDtJqX8dL4j152MZcQrT9dc3utYIEf+4G2q5CPPa5jXpxlfg4Xe1ldHbkIX
	kf1Y/LHewlL7w71S0VOhG9T5PG6lQlV9NX0QNAiAqhhJdL7hlC+Wr2c35wOrgQS6cvCTfoMSY6m
	SRm0WnrvdY6AbW8aEcHxJOUcjahm1uCwj2uKk/dzZ29PTCb5H25cHYsRgB6piqQw64LmI/r1ewh
	bQrw5WumGZZBDxBLxY4+key+0cgkQhsSHWB2aNgrVbJQU/RkiIm39pPRY6FwPVkNxLBgN9SBxr9
	FkGIoD1nB33IOIR/Barbf3Tn6riz43MqW7FLMoXbJg55pJHQPUkPsjXZuuur+QuEIScmrIdT79o
	+xXcL52sAXWoWHtZeV//n//OVkv2e9lmuI//BVx4cP2j+eO4pOhtDpWvJTxXJfqFgKZu8ikukVz
	Sc81XnjI4MlJ8m5bzEHwn4kN21I9wJ2XrAA8UKH5tj+q6S5
X-Received: by 2002:a17:90b:2dc3:b0:38f:5869:387a with SMTP id 98e67ed59e1d1-38f9bd6e64cmr950536a91.8.1785387808118;
        Wed, 29 Jul 2026 22:03:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f8154619asm898584a91.4.2026.07.29.22.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 22:03:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b7e5b66f-1f27-4c3a-a66d-2100a982aaf4@roeck-us.net>
Date: Wed, 29 Jul 2026 22:03:25 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] watchdog: pretimeout: record PSC reason on
 watchdog pretimeout
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Srinivas Kandagatla <srini@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-arm-msm@vger.org,
 kernel@pengutronix.de, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
 Guenter Roeck <groeck@chromium.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 avaneesh.dwivedi@oss.qualcomm.com,
 Umang Chheda <umang.chheda@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org
References: <20260722-pscrr-reboot-reason-v2-0-495ba3005953@oss.qualcomm.com>
 <20260722-pscrr-reboot-reason-v2-3-495ba3005953@oss.qualcomm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260722-pscrr-reboot-reason-v2-3-495ba3005953@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 08:13, Faruque Ansari wrote:
> Update the PSC reset reason by invoking set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT)
> from watchdog_notify_pretimeout() before either the panic or noop governor
> runs, so the reset cause is committed to persistent storage before the
> system goes down.
> 
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> ---
>   drivers/watchdog/watchdog_pretimeout.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
> index 02e09b9e396d..ea48d4eca4aa 100644
> --- a/drivers/watchdog/watchdog_pretimeout.c
> +++ b/drivers/watchdog/watchdog_pretimeout.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <linux/list.h>
> +#include <linux/reboot.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   #include <linux/string.h>
> @@ -103,6 +104,8 @@ void watchdog_notify_pretimeout(struct watchdog_device *wdd)
>   {
>   	unsigned long flags;
>   
> +	set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT);
> +

A call to watchdog_notify_pretimeout() does not necessarily reset the system.
It only resets the system if the panic governor is active. Given that,
I think this is a bit misleading. If the "noop" governor is active and the
system crashes later due to a completely unrelated panic, the restart reason
will be wrongly logged as pretimeout.

Guenter
>   	spin_lock_irqsave(&pretimeout_lock, flags);
>   	if (!wdd->gov) {
>   		spin_unlock_irqrestore(&pretimeout_lock, flags);
> 

