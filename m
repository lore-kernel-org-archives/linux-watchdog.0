Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B744D6A1;
	Thu, 30 Apr 2026 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564631; cv=none; b=U9yDaUKceDRx/22brMFVl0pHxkjB1JP5scXdPiYaQf//WVV8Buf945N/Mn+ceSHVKmTtv0hyAHFgFPu+CLYd2acEEy49H9pB0R8v/pOHVLDH0aVaNJLHGiQeRxOyvw9YupuYsSzGjEVtBcq06LGiFNDahDT68Kdhrohz9RnNmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564631; c=relaxed/simple;
	bh=ML/Gq/hV5A/wPlg9KbFCF8Ep867OfEOsOc5tVSgimb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3dMgyRSiH5ZPd7Qc4i0JpbTeqhxSzMMqKy+P/Q04Ok60r/cTKIDB7faQJdiC28Tdy9Jpt7DW0jRCLVdSf32+vStRaScnpVdoAdzkRVA4ECtb7klmzn0LKsxRf/a9JFugdS4FsP9gImzVfrEYXJxX88PBvpiPeUU9hA7/PReUjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d1AamU68; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d1AamU68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=vkY8wUCq6SWwVGjoiQuvIPR6DclDJ+7jBKT2vzC4o3U=;
	b=d1AamU68XGemWjVM+dR5s8t+ogQmRhMitjko59eJ3Op5mVzWiiexdAm9ViEjRE
	N9pt86rwh6/2otJ1LpjDC+jezxDkQrRpcnvH3gofhHk55ubIxiUkTeZlXv5a19cX
	tcp6akJpHcu+1KHXxxRshk+ea2sYL1pdJZit4X9eCsB7s=
Received: from [IPV6:240e:b8f:927e:5900:c497:d540:b00d:97f4] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgB3X_+qe_Nppx1fBw--.175S2;
	Thu, 30 Apr 2026 23:56:28 +0800 (CST)
Message-ID: <52340c25-3e6d-4cf8-ab92-b01db5fac802@163.com>
Date: Thu, 30 Apr 2026 23:56:26 +0800
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: realtek_otto: Use FIELD_MODIFY()
To: Guenter Roeck <linux@roeck-us.net>, sander@svanheule.net,
 wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430154230.34218-1-18255117159@163.com>
 <2ca08749-f1b6-49c5-9281-c4f5b37e890e@roeck-us.net>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <2ca08749-f1b6-49c5-9281-c4f5b37e890e@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgB3X_+qe_Nppx1fBw--.175S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy7WFWfAryrZw1xWFyDWrg_yoW8ZrWrpr
	4DAFs7Wa1UtF1j9Fy7ZFsrZ3W0y3yvqF10gr1UG3s5uFnIyrn0qFWrKr95KFs7AFyxWFWj
	9F1UJa4kCay5Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR-B_UUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwxhBWnze6xk6wAA3p



On 4/30/26 23:53, Guenter Roeck wrote:
> On 4/30/26 08:42, Hans Zhang wrote:
>> Use FIELD_MODIFY() to remove open-coded bit manipulation.
>> No functional change intended.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
> 
> Please refrain from making non-functional changes such as this one.
> 

OK, maybe everyone has different preferences. Please ignore it.

Hans

> Guenter
> 
>> ---
>>   drivers/watchdog/realtek_otto_wdt.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/ 
>> realtek_otto_wdt.c
>> index 2c30ddd574c5..cf4841583721 100644
>> --- a/drivers/watchdog/realtek_otto_wdt.c
>> +++ b/drivers/watchdog/realtek_otto_wdt.c
>> @@ -149,11 +149,9 @@ static int otto_wdt_determine_timeouts(struct 
>> watchdog_device *wdev, unsigned in
>>           || phase2_ticks > OTTO_WDT_PHASE_TICKS_MAX);
>>       v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
>> -
>> -    v &= ~(OTTO_WDT_CTRL_PRESCALE | OTTO_WDT_CTRL_PHASE1 | 
>> OTTO_WDT_CTRL_PHASE2);
>> -    v |= FIELD_PREP(OTTO_WDT_CTRL_PHASE1, phase1_ticks - 1);
>> -    v |= FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
>> -    v |= FIELD_PREP(OTTO_WDT_CTRL_PRESCALE, prescale);
>> +    FIELD_MODIFY(OTTO_WDT_CTRL_PHASE1, &v, phase1_ticks - 1);
>> +    FIELD_MODIFY(OTTO_WDT_CTRL_PHASE2, &v, phase2_ticks - 1);
>> +    FIELD_MODIFY(OTTO_WDT_CTRL_PRESCALE, &v, prescale);
>>       iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
>> @@ -279,8 +277,7 @@ static int otto_wdt_probe_reset_mode(struct 
>> otto_wdt_ctrl *ctrl)
>>           return -EINVAL;
>>       v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
>> -    v &= ~OTTO_WDT_CTRL_RST_MODE;
>> -    v |= FIELD_PREP(OTTO_WDT_CTRL_RST_MODE, mode);
>> +    FIELD_MODIFY(OTTO_WDT_CTRL_RST_MODE, &v, mode);
>>       iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
>>       return 0;
>>
>> base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b

