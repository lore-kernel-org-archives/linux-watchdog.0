Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01CA3769F5
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423761; cv=none; b=NW9/EgqD5TIk56lIXcJmEQLp54ddjXrnjM5DId7gtzYBdJ3e5Cy58jhrwQLgVLxSUmFwOOkL+z8tVjBIaYSn+5lw94uF2d0ftIc1XsJwhVSVCkDQTHgV+U73aSZipZZXAE6YoWpOmj5hHXprmPyqEWGzDeSKjzWLSm+LNhlCx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423761; c=relaxed/simple;
	bh=lnPmujkoSvOOLGMqjbquxyL4hLjA/ramPgRYAIoT/Kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ld8nTLlC5d2r9jFH3VHBG6XfId9kM0wh4TBlvsOkclTe4V/913UMKhtmVObaiQHSZ/5HHT7uu/WcQ4dyBS3QlkCtRRnxVE3d1MgCaT5zzdnHWskdXOjOmm+oAdLWZFqoEcGQXw46TfbWAZ/1Fwac2OehZNr/OHQGokF8u9GXHQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlpkFiHa; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlpkFiHa"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc73e322dbso24629475ad.1
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785423758; x=1786028558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tLEzUW8o0U9S9X6t6tu33UKtz4CdGONFnEDfRlrAs9U=;
        b=hlpkFiHaWXAbF5gmE61wop6HWRAMKi/SOO1f4458Z81MLYAvDSOh2ONOOIPYcpeH60
         2m/9sr5wp0O/zXG7IdTYgEi50mysifIrw9ztcWO3JU2UB2BCyatNBIHRKnCINrRODNYk
         0yKmDjw+CC0njxwUMn2SR5GrqbFU8Xi7FKbEQ7TGmNwC1NsJ7Rf84YiOLwSyjJY8s8Hd
         EzL/xD5W9MoxtE/5MNVflbqKWpYCh/4gvcs0O5Qb9jtgBanTpseB8xSYgROkzjsBPkg+
         iBSjD1i1bK7nXzbeCs+YR7mTFLpiPQbjPkYsRR6ygQbtCvd6mypGmzCuEsMuXHVsQ507
         pbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785423758; x=1786028558;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tLEzUW8o0U9S9X6t6tu33UKtz4CdGONFnEDfRlrAs9U=;
        b=aY6zqyKbU67iHmbKzwHT37kIZBgFd47AOBvIpb37/rv5HWoEvEmECxm0AJ9+U+59s4
         mFr5BVdtjUiPlavlSlC30HvLM33Mf1aF4lmmg2JyK0FyeobupeqCpZtNvNxeYIN6G74T
         C2m/yhchR67AwBJ5NnWXNANnZ75wbQz0ctx6gbYJkwnkmMiA8p/CqWdt2Svn0Jii/zFo
         uVTwGMy3MqBvIsYRnSeWMZBV01KBa9+stYuSFsV3gHbAI17bOsErL1IiNODkuu3iO6Oy
         k4Tg4nZOU624kgdPbnjBccFhhrLH+NJ8PIlw47hAVA8fRetPct9pdHHwvOmyoi+lx5dq
         ISOA==
X-Forwarded-Encrypted: i=1; AHgh+RreMWyTqcwZt4iphiaE2iZ8wJPJ3uoCzEz8cJdUIAtcqub0nyScuRpXonXDuuBMGLtuvzjf3zmOOWAEAioc+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtDICn0rauiy61LHZaPge/gpi70BpHcbLsbX4KImSQ6FbEChka
	HOrRB/MvoJAFk8qJcOltSyKQYyImjB4UoCt/OdPKtqO+dX/D+AuZ3P1/
X-Gm-Gg: AR+sD13lLJ+zty3RDehX8mVy/lmX+U4NL5tS6OZXyp9T9qIY9FCleqGBHuGbkQcLnZR
	DCdcR0R14FyqLVQ3W6T2H3h2FsK4Fz5N5iSuKbwjdGC5ITrRXeP7bKWUwmMCbEYPPIz/Rr5cim9
	DMxXUqnzrlfJJLNt6hSogpC22jk9YscrxmFxKm20doHT5260yFx3vXuH8CeF9x4pyPXO7JSCrXL
	1c8EXU5dh7GJscoMGsesgcK7dHdcQHMshrQwc/ptc7jZtbpedJHfoG5Bz8HaJH3YKO6CSGFX8c9
	WRo4vYB8jDghWseDRPYUcL01AOE1ds5cXYGnVUOU06oCi5C8iVqfL6ALoyEbvVEHFpXo7gOEOpv
	CPmepy1/cCCgKr7jvrAW21SasBSeIhzrBbx9Cnndge9PSCRksuC4OD8UwmoYgKtgFW9wECDV3wI
	xkV2GFwu2wLUgm6ZuOcNziwk0sRI6PDn+eZR73ZJpmBtMdew5oXfIp5zbuPWABlgPKLQZ/aZM1/
	0KybAaj3dd+hfVEibnyZXnmY5Hk2q/dBhjg2Q==
X-Received: by 2002:a05:6a20:54a1:b0:3c3:2e2b:29ee with SMTP id adf61e73a8af0-3c900948db6mr2952552637.55.1785423758227;
        Thu, 30 Jul 2026 08:02:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d37368sm41415686eec.22.2026.07.30.08.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 08:02:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <19a2b8bd-09ea-4df9-b0ba-f78f60c44848@roeck-us.net>
Date: Thu, 30 Jul 2026 08:02:35 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] power: reset: pscrr: add watchdog pretimeout
 reason tracking
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-arm-msm@vger.org, kernel@pengutronix.de,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, =?UTF-8?Q?S=C3=B8ren_Andersen?=
 <san@skov.dk>, Guenter Roeck <groeck@chromium.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 avaneesh.dwivedi@oss.qualcomm.com,
 Umang Chheda <umang.chheda@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org
References: <20260722-pscrr-reboot-reason-v2-0-495ba3005953@oss.qualcomm.com>
 <20260722-pscrr-reboot-reason-v2-2-495ba3005953@oss.qualcomm.com>
 <98e65507-3084-4948-8096-4e2d8d20dc81@gmail.com>
 <amrgDC0s3rb5Xv4N@pengutronix.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <amrgDC0s3rb5Xv4N@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 22:24, Oleksij Rempel wrote:
> Hi Matti,
> 
> On Thu, Jul 30, 2026 at 07:49:41AM +0300, Matti Vaittinen wrote:
>> On 22/07/2026 18:13, Faruque Ansari wrote:
>>> Watchdog pretimeout resets are not recorded with a dedicated reset
>>> reason, causing subsequent boots to report PSCR_UNKNOWN and making it
>>> difficult to distinguish them from other unexpected resets.
>>>
>>> Add PSCR_WATCHDOG_PRETIMEOUT as a dedicated reset reason code and
>>> prevent the panic notifier from overwriting a watchdog pretimeout
>>> reason with PSCR_KERNEL_PANIC when the pretimeout governor triggers a
>>> panic.
>>>
>>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>>> ---
>>>    drivers/power/reset/pscrr.c           | 7 ++++++-
>>>    include/linux/power/power_on_reason.h | 1 +
>>>    include/linux/reboot.h                | 1 +
>>>    kernel/reboot.c                       | 1 +
>>>    4 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/power/reset/pscrr.c b/drivers/power/reset/pscrr.c
>>> index b5906f127e88..5b107c62fe82 100644
>>> --- a/drivers/power/reset/pscrr.c
>>> +++ b/drivers/power/reset/pscrr.c
>>> @@ -149,7 +149,12 @@ static int pscrr_panic_notifier(struct notifier_block *nb,
>>>    	if (!backend || !backend->ops || !backend->ops->write_reason)
>>>    		return NOTIFY_OK;
>>> -	set_psc_reason(PSCR_KERNEL_PANIC);
>>> +	/*
>>> +	 * Do not overwrite a previously recorded watchdog pretimeout reason
>>> +	 * during panic handling.
>>> +	 */
>>> +	if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
>>> +		set_psc_reason(PSCR_KERNEL_PANIC);
>>
>> Hi Faruque,
>>
>> I like the idea of adding WDG pretimeout resets in pscrr. I am just
>> wondering what makes WDG reason so special, that it shouldn't be overwritten
>> while other reasons can be? Can this notifier be called (now or in the
>> future) so, that there are other reasons getting overwritten? For some
>> reason I think the PSCRR was designed to be able to store multiple
>> reasons(?)
> 
> It depends on the backed. A simple nvmem cell, would be able to hold
> only one reason.
> 

That makes me wonder: Shouldn't the priority be a back-end decision, not a
front-end decision ?

Guenter

