Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1E4582ED
	for <linux-watchdog@vger.kernel.org>; Tue,  4 Aug 2026 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855581; cv=none; b=uNkBtCEn5RwkPdt2tnZB5MUUcivYt7KqvsP+vVNqiEedjVs6PYql5NDRMeTUc3OzgpABaZD71ibLm9/H/Fjllhqz/yTFPaBdSdGWr7xAthM7NH5o6KEysb5GOFIAuMfTD4qkdxvrF9VBgwCzGU9Zg7EF9opTb1aukCYEmVCcidA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855581; c=relaxed/simple;
	bh=vx2HoAYnzxdjsoZwz0pespz2k8WkdfkdO1teBXi4bB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMT8KufbRi0s+AZxE1Ziu92+e9OsvTnYPTXBdzaQ0ZHNKgywM0qL+QdHS6fIxAAtqxTKazIa5gyH8rbdBs1T3xdhCNX3QkuQhb3N5c44551fc8ermT2CPjscMSkwe+5oS7WSB2CDa1xkjtEuBRd6i8tO2VK4zdZNWNMOs29h+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYcoXcat; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYcoXcat"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so4499870a91.0
        for <linux-watchdog@vger.kernel.org>; Tue, 04 Aug 2026 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785855578; x=1786460378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5JgwzEvtfB2uQ9F0aI+6JlH048Ow6xZYPMLayRepZQo=;
        b=HYcoXcatS11kJzJ5rqUn3MyxV4fcaxEsSFbQl7ip5/2wYxWpZFFzsbuXBR1wFkKBaO
         PHjwqzJ9IqnmJQZMw7HYXkYxWxDvTKRvkpA47OoD0g/jzoD9I668/kZQXQd/S1TU14ny
         mOy+kT0DnkFKCUmCzj6bIawmO7XxsXsUVC3/oND2pZJxo9IwWze0G5RpuruhvO0jxIK9
         tMqXP6FK/OosAfkZAFj9Cmbr4JK3hTjk5lydBM8ID9UOGjZ4dDB7tpz/TWGYiTOnylC/
         NUh2RmaDk4OhmTpMt3JYk2PeAZG5DNxqseJOBXUIWKR9SlnJsrzlDezd112pwz4gmJTM
         IIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855578; x=1786460378;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5JgwzEvtfB2uQ9F0aI+6JlH048Ow6xZYPMLayRepZQo=;
        b=N3WeF2cyC5bkW7vy7uNfsIl8KIbATJLnFpHck1EtsY3nW/LD8NZEtGNEVmPLHCBKZ6
         uI7FulWSwR85rB+KtdKLSjn+TQ7Lff8IUBVA6i7KER4mA27kOkffBnTuLQVNQnKHHemO
         7knV0GjogMzbedCAK2yACs/avN7Y7i5Hb1h+L2pKxMTaSpszBfch/XzXgfXM3GgUgo7D
         NT1SHuORzAcpMRSKtuc3Yd11d7o5KDIjMn5CEuu9Q5rIT1q6TNmqSFieif9UU7QwkhOP
         qwEKfs+mEIyizF77A79RL5b9ERV8t6C3bAXwA9D9+BGlnZg16B1eBBF2lRzlFnO2BxyR
         Cw8A==
X-Forwarded-Encrypted: i=1; AHgh+RpP+KMyjJH/P73gw8G6yvioV1jtt0QIs2XV+AD9FSkEJNw57rpOtSDa0O3FndlGRZaa1YBeX3GY+pKYSaL7QQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/a7XTEQ4dplNTOSaHTNFNg5Vvn+4/d6/dC3MVLfcW6EvqYeU
	PeSm6HZk9HxGtMeaonEXCQoUdj1SiOyWolhUpQf2kBIUX9nZbCxQIAtU
X-Gm-Gg: AR+sD13DrlkQvFpBNhOdmvfG3ocaxijCj1+Zu4cwW2I63Lilg3KOSJd3/yWZjDFow/a
	JE8yA1Tx9zWwlBHoan5KbIj2emYH4oYDTin1BJzsP9neO7j4Vrb0Qpu1Fiq3aV5N14uEusaiz3v
	7x9VrIYQYoDQGIolwFcMOBSbE5jwbVlzenZTnWfR1VSHmjisY4XCe10Gf8Izyu+IkC3rviu2nc+
	2oamDK+BQH0Q/iweui37jyxpMBk3pqbzM5TPqIKD7MlxlzCQBjU8YrgBS6gGd8VAhcpSL0oocgs
	zoHXA9xqGMwB3V2sWPrmDeBoqGrFMOwaCLEL6K/KxyHLJMb8OJkyocgRfFFR5WWgHlgw0UJbeEV
	8ioRDqFQhZRh0CsjX7vAlxYs9aM6tp/0NSgH4NRK6ptvwlQCvcUpotYByKdjPmMUueqET1nlwQs
	Y7c+txtCiROZtW5Qg+0MM+0S/QFsFIndHPlUi7a86MpehF3n0JPtizu3EAQfkXiMeS9KJuvspQM
	OSHV5LWWhfTzolRGuXeFB4ZqZpyBa0Vn3Pq1w==
X-Received: by 2002:a17:90b:2b50:b0:37f:e326:6559 with SMTP id 98e67ed59e1d1-38fbc51a361mr13144797a91.22.1785855578147;
        Tue, 04 Aug 2026 07:59:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca50acddsm4434915c88.3.2026.08.04.07.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 07:59:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bf41bb0a-6f2c-443a-a487-164277c2dcfa@roeck-us.net>
Date: Tue, 4 Aug 2026 07:59:35 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] watchdog: pretimeout: update PSC reason in panic
 pretimeout governor
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Srinivas Kandagatla <srini@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, =?UTF-8?Q?S=C3=B8ren_Andersen?=
 <san@skov.dk>, Guenter Roeck <groeck@chromium.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 avaneesh.dwivedi@oss.qualcomm.com,
 Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260804-pscrr-reboot-reason-v3-0-e706dbfc7465@oss.qualcomm.com>
 <20260804-pscrr-reboot-reason-v3-3-e706dbfc7465@oss.qualcomm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260804-pscrr-reboot-reason-v3-3-e706dbfc7465@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/26 02:21, Faruque Ansari wrote:
> Update the PSC reset reason by invoking
> set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) from the panic governor's
> pretimeout handler before calling panic(), so the reset cause is
> committed to persistent storage before the system goes down.
> 
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/pretimeout_panic.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/pretimeout_panic.c b/drivers/watchdog/pretimeout_panic.c
> index 8c3ac674dc45..819487b5e6fe 100644
> --- a/drivers/watchdog/pretimeout_panic.c
> +++ b/drivers/watchdog/pretimeout_panic.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> +#include <linux/reboot.h>
>   #include <linux/watchdog.h>
>   
>   #include "watchdog_pretimeout.h"
> @@ -17,6 +18,7 @@
>    */
>   static void pretimeout_panic(struct watchdog_device *wdd)
>   {
> +	set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT);
>   	panic("watchdog pretimeout event\n");
>   }
>   
> 

