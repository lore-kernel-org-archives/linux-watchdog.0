Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9A1F099C
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 04:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785473883; cv=none; b=QGIoS/D9hx4H0krAo4yxasSzxmC7Ta9Tx1hwN58Z+Rv98R6jJgH+2+ZvEHtGOi2NPkF/pSPY3GygOJ2gd3/en6eyb5QDk00tlKrowRrGQt0h1Ik2trQtAMRl9Ln5iVb3dFSOmuVr587Q1fJZ7dZoubgIHelAu1DDzl4wH2Vv8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785473883; c=relaxed/simple;
	bh=X6OGDm/VB6iIh58IJAWY8WxflOxDrgUmL0JJMy/Fk+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxvHGnS/boEwGDYZLoHJylB3Vy6idy59nZjoEc6ldIRsWYhBYRxKwWs/AWo2Y0GgZyeFoa1DzBelIDvUTKDrVDMrdnMQjc0XDkFTy5msFRQxOdkGMzwy9yJOyvmmwp3uoEOyd7vnmnHCwA9S1FX1vOCqG1xlwppB2vTV3a50zWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGGkgCzw; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGGkgCzw"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so1934237e87.0
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 21:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785473879; x=1786078679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWVsaGtK4t8BYwwX0u/oZhTbeS39OgGPkH3ocWt5uz4=;
        b=qGGkgCzwqvlkSj2llLZEgYbpahz4ulNM6i4HwHIhrer1UpYBu6EFOijQ0eBJ/7qyYV
         hkdn3REp/ps7gLN1+nkR6vmTJKDCO1nZe0v5aPpyz52epWDfIDVLXIWTLpVuDNYWa1e/
         CckMk4ysuFISquriklIK9s6IAUkhgX7Krxt5g4/TUGVdMMwjHA6y8U/kWlaq/Cu6+/uz
         UutGfwK9o9Fvbm4A2MGnUJIaZNGUiWnN4jTvHZiMJ2AzAL0ZV7izMCEO4eSnEox1HDN5
         ileVxK2b9D8OLWlNKxgs88QRxZtyDiVLCFDv/dwIh5u1/70UZEDV8ghgdYG7qTBKjbTi
         Em0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785473879; x=1786078679;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cWVsaGtK4t8BYwwX0u/oZhTbeS39OgGPkH3ocWt5uz4=;
        b=nAVSK2FldnM4fePDiyoY91I+QNj3kLutgCgy7oc5MTDLg6QrJ/EdXMewrzEcHAoFsb
         rYxMqxuQV1qMESqRoVp+QTYULox0XAEDs/lcEmhkXTjotEfYSgrcsDLwWDwQ0i0YZUn2
         Z7sY+LEOvDUFUWEn7t6yEteS18T7DKVsaLYC/owppWEAH0EaaHJJe8YEDsl9nHHgNVcE
         6Q3YKiHrrGDaBXdLlpc62mK8G8Gwxc5ZH5VxD9BEOcdRfVipCtQ5Yt6cysWHrr9BlofI
         +g0Oh9WK96pTbDhyBm1+eJjyU1YUDJso7UhRPX1wGozNsfNM+uz2P+CReIPmBw2/1hhc
         2sNA==
X-Forwarded-Encrypted: i=1; AHgh+RrQsrnpSEUlXEmLQeNp86R2NRvFyNYx1hzu9Yrv/lSGe5BoPJNUnRP0xQ3bdEDTGI/cLFAkKaYY1sWz9/ohSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAkztmQSN11MeZR1lEquu4HMkjTw/BtsLYqVmhTP516ywDFHT
	zhmzvhpxxwITV6rnj6aSoc/LtWPrLJ8KztMqILXOLx6pIsL6e3NEvoie
X-Gm-Gg: AR+sD12UwtZ1TcI8KWug1ZxQ0uhpM3rtqf9A2+9+lt6U6SpNnNsbkbEVZ34CHk+yogY
	UhwAEtkv1zJxI5bEM9Yda+zCS9MSAwGxahTFSTlr/w5lD9OEUOQ3fvwNAD+BQmrzhm7mDDiLIMj
	SSoGtRy/6eljfo0NcX2cG55qwzJ8GTXPszJm3ibGHl05XAxRqDr97gysWSghnQNzNiWE0oAaLDH
	I4UAk6Ji06iEFxW/ZIjOt5aCLbQV+cGsmdyKmQa2chHzYPiSx/XAAhNPmetzaIQbeAm0xRIOg0V
	FqvJ5TQpfjuRvTxJ4TPEInEoYEwBPtMqsVkH6z8r7kyGsK6CFHTKM8R58KYu+G6rR8cwvqPwm3R
	tZMGTwR28e/EULoKuH0CqbOFFckH05EvRjC8PQn/rmJlFZ17cYsZW3+b0EYfo0HvV9M8TFU1B/s
	9vTMPC8sUt1Ju9/VKe4+J5UrxHUOBKzMchumGCt/NY6SlbFXaGyjCRBWI/uSC7AYd0htdv3BRQ5
	fEelx0EsbB6MlRI7eCnmnPJaHQz1SwCuBSLS3n2vPDKvA==
X-Received: by 2002:a05:6512:6185:b0:5b2:afd7:ec48 with SMTP id 2adb3069b0e04-5b2e2349c05mr70476e87.32.1785473878783;
        Thu, 30 Jul 2026 21:57:58 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e245c8basm58952e87.84.2026.07.30.21.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 21:57:58 -0700 (PDT)
Message-ID: <1cc56b2d-457a-4152-b701-ee05c2e203db@gmail.com>
Date: Fri, 31 Jul 2026 07:57:56 +0300
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] power: reset: pscrr: add watchdog pretimeout
 reason tracking
To: Guenter Roeck <linux@roeck-us.net>,
 Oleksij Rempel <o.rempel@pengutronix.de>
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
 <19a2b8bd-09ea-4df9-b0ba-f78f60c44848@roeck-us.net>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <19a2b8bd-09ea-4df9-b0ba-f78f60c44848@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/07/2026 18:02, Guenter Roeck wrote:
> On 7/29/26 22:24, Oleksij Rempel wrote:
>> Hi Matti,
>>
>> On Thu, Jul 30, 2026 at 07:49:41AM +0300, Matti Vaittinen wrote:
>>> On 22/07/2026 18:13, Faruque Ansari wrote:
>>>> Watchdog pretimeout resets are not recorded with a dedicated reset
>>>> reason, causing subsequent boots to report PSCR_UNKNOWN and making it
>>>> difficult to distinguish them from other unexpected resets.
>>>>
>>>> Add PSCR_WATCHDOG_PRETIMEOUT as a dedicated reset reason code and
>>>> prevent the panic notifier from overwriting a watchdog pretimeout
>>>> reason with PSCR_KERNEL_PANIC when the pretimeout governor triggers a
>>>> panic.
>>>>
>>>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>>>> ---
>>>>    drivers/power/reset/pscrr.c           | 7 ++++++-
>>>>    include/linux/power/power_on_reason.h | 1 +
>>>>    include/linux/reboot.h                | 1 +
>>>>    kernel/reboot.c                       | 1 +
>>>>    4 files changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/power/reset/pscrr.c b/drivers/power/reset/pscrr.c
>>>> index b5906f127e88..5b107c62fe82 100644
>>>> --- a/drivers/power/reset/pscrr.c
>>>> +++ b/drivers/power/reset/pscrr.c
>>>> @@ -149,7 +149,12 @@ static int pscrr_panic_notifier(struct 
>>>> notifier_block *nb,
>>>>        if (!backend || !backend->ops || !backend->ops->write_reason)
>>>>            return NOTIFY_OK;
>>>> -    set_psc_reason(PSCR_KERNEL_PANIC);
>>>> +    /*
>>>> +     * Do not overwrite a previously recorded watchdog pretimeout 
>>>> reason
>>>> +     * during panic handling.
>>>> +     */
>>>> +    if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
>>>> +        set_psc_reason(PSCR_KERNEL_PANIC);
>>>
>>> Hi Faruque,
>>>
>>> I like the idea of adding WDG pretimeout resets in pscrr. I am just
>>> wondering what makes WDG reason so special, that it shouldn't be 
>>> overwritten
>>> while other reasons can be? Can this notifier be called (now or in the
>>> future) so, that there are other reasons getting overwritten? For some
>>> reason I think the PSCRR was designed to be able to store multiple
>>> reasons(?)
>>
>> It depends on the backed. A simple nvmem cell, would be able to hold
>> only one reason.

Thanks for the explanation Oleksij :)

> That makes me wonder: Shouldn't the priority be a back-end decision, not a
> front-end decision ?

I have no strong opinion on that but even if the priority was decided by 
front, the decision whether to store multiple or single reason should 
perhaps be left for (or depend on) the backend.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
