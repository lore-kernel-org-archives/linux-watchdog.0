Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1848A36E478
	for <linux-watchdog@vger.kernel.org>; Thu, 17 Sep 2026 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607564; cv=none; b=AoQ3+kTm2nmAUtt0eH1aNQnc2LtxFly/pLYjob+9CYvdzL0y/w0OLK6zVq+z0m3yxqz+gwsdDqiwFE9GSpVfCHYuDSbAFfG+Nklk2u2bNp9C3FRFECRjyAwFzJSLPi2iAhUcjKjv0AmKl/1SpBX3Y75jcEpTSdZ32jDnaWLKbig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607564; c=relaxed/simple;
	bh=wOFW0l30GenVNsZDdUk8OONnZPCsyhdZ+Xpwju8QmVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBRN9w/sp1AjRLem/UDQtEjX8CXjTxngY7AYlo6JswDuK1xBd04RtVp+m2oXOYbeH69lz6k6Wx2hBp5k3aButPIK7AKpPywRcb9pNFQMGpmLXwVdLXZjyRc0VIh22P6NBMGbkmNBLp640o6pXHhh274zftOFAhD/BA7K05N16rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d938cdfab23411f19a56ed5b684f684d-20260917
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:20a750d5-a5c8-40ef-a313-cf5689581ad4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:7dca233ddff28f84eedc7d6fec4a5355,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898|915,TC:nil,Content:0|15|50
	|99,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d938cdfab23411f19a56ed5b684f684d-20260917
X-User: lijun01@kylinos.cn
Received: from [172.30.70.202] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 391503909; Thu, 17 Sep 2026 09:12:27 +0800
Message-ID: <7c692a69-2922-4b2e-9d7e-c6c852841da6@kylinos.cn>
Date: Thu, 17 Sep 2026 09:12:25 +0800
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: da906*: fix suspend/resume handling of
 HW_RUNNING watchdog
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>
Cc: support.opensource@diasemi.com, wim@linux-watchdog.org,
 linux-watchdog@vger.kernel.org
References: <20260914063707.607071-1-lijun01@kylinos.cn>
 <b48a5140-1a70-4af1-9136-1eccc29331b2@roeck-us.net>
From: lijun <lijun01@kylinos.cn>
In-Reply-To: <b48a5140-1a70-4af1-9136-1eccc29331b2@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

OK ,i will send the da9063 patch immediately.

Thank you for your suggestion.

2026/9/17 08:36, Guenter Roeck :
> On Mon, Sep 14, 2026 at 02:37:07PM +0800, Li Jun wrote:
>> da906*_wdt_suspend() and da906*_wdt_resume() only check watchdog_active(),
>> when the watchdog is left running by the driver sets
>> WDOG_HW_RUNNING in da906*_wdt_probe() but userspace never opens the
>> device, so WDOG_ACTIVE remains cleared, the wdt_disable() will not be
>> executed in da906*_wdt_suspend. In this case, the suspend callback is
>> a no-op and the watchdog keeps counting during system suspend,
>> leading to an unexpected system reset.
>> Check WDOG_HW_RUNNING and wdt->wdd，can fix this issue.
>>
>> Signed-off-by: Li Jun <lijun01@kylinos.cn>
>> ---
>>   drivers/watchdog/da9062_wdt.c | 4 ++--
>>   drivers/watchdog/da9063_wdt.c | 4 ++--
> I applied the patch for da9062. Please send a separate patch
> with the fix for da9063. Also please provide change logs to your
> patches in the future.
>
> Guenter
>
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
>> index 2b6946478527..3d7bf2f351db 100644
>> --- a/drivers/watchdog/da9062_wdt.c
>> +++ b/drivers/watchdog/da9062_wdt.c
>> @@ -256,7 +256,7 @@ static int da9062_wdt_suspend(struct device *dev)
>>   	if (!wdt->use_sw_pm)
>>   		return 0;
>>   
>> -	if (watchdog_active(wdd))
>> +	if (watchdog_active(wdd) || watchdog_hw_running(wdd))
>>   		return da9062_wdt_stop(wdd);
>>   
>>   	return 0;
>> @@ -270,7 +270,7 @@ static int da9062_wdt_resume(struct device *dev)
>>   	if (!wdt->use_sw_pm)
>>   		return 0;
>>   
>> -	if (watchdog_active(wdd))
>> +	if (watchdog_active(wdd) || watchdog_hw_running(wdd))
>>   		return da9062_wdt_start(wdd);
>>   
>>   	return 0;
>> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
>> index 92e1b78ff481..3703110e82fc 100644
>> --- a/drivers/watchdog/da9063_wdt.c
>> +++ b/drivers/watchdog/da9063_wdt.c
>> @@ -271,7 +271,7 @@ static int da9063_wdt_suspend(struct device *dev)
>>   	if (!da9063->use_sw_pm)
>>   		return 0;
>>   
>> -	if (watchdog_active(wdd))
>> +	if (watchdog_active(wdd) || watchdog_hw_running(wdd))
>>   		return da9063_wdt_stop(wdd);
>>   
>>   	return 0;
>> @@ -285,7 +285,7 @@ static int da9063_wdt_resume(struct device *dev)
>>   	if (!da9063->use_sw_pm)
>>   		return 0;
>>   
>> -	if (watchdog_active(wdd))
>> +	if (watchdog_active(wdd) || watchdog_hw_running(wdd))
>>   		return da9063_wdt_start(wdd);
>>   
>>   	return 0;
