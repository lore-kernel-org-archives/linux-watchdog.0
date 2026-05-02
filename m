Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694253803CC;
	Sat,  2 May 2026 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777740509; cv=none; b=pfMVpr7d7Xwtgfn+dhsMdG64AS6qp2bW8BTVAubCa0iicNcQHaP8tIw66LhewKQ3ysOGRIYhLHPYQOzj+U27Rqwzs0t/A6TlpeK6w373uvFPig0L/7Hho4GM3YYux4GUR5/g1Yd8o1QTsAB+v6wcodUPlaCziZduVRgmc4SasMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777740509; c=relaxed/simple;
	bh=bO2M9D25keA8GdKYXgGy43X1y5+pdYX8KkaIwSc32rQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IYeMM+ZgRNENOTvvEXWTPQDUZRPCWqKJ6f4UlhXrYndiyGO9ZZK0x52B3zDBY8SGFtlcvww14UJIWVgXxYnN7BXbr5uKLt8/P7B6Hx85VGnaR/Ood7eCVqSN+B57rObVmwjyE+A0LnwNytI3ZsEp1o0KPGaev+z4wfntC/Sih1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MQBtLO/E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MQBtLO/E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/meKTHTAkvbhDj5xDrIR3aNhIH2nSGsMIIGJIDhst2Q=; b=MQBtLO/EBST7CRIGK40JzOd/8w
	v+KaqhliYEl79bukYrkR5hNU2DFcyfWBDv+zU8iQRzbqiwFSt2ngI5RAUkj/q2gZ8h5ybynY+WBxl
	jJP7cm1KbWIMQCJrFP7DRXewrB6uRetAogGHTDwmHt+TFUhygyytZQ9dlmAqQjbgrNiSVQU6/b7Qm
	WPW+k/jvOtce2t9MU3htSiMZXAuMTssNeLRRW36ZZ2A/fRD73GOGDiI0VJT2TSNc7e83X7I7eAaAg
	3N6HD6bfu4oaxEDFS8dFA1RhyegYDhKwwiFkKIe+k/InQPIkT1LX6ynrj3RcNvIg9oGSQ3JOzOd6v
	+xxaCL5w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJDVz-00000009Loy-032E;
	Sat, 02 May 2026 16:48:27 +0000
Message-ID: <563f2633-4304-45fb-9188-1b5235463181@infradead.org>
Date: Sat, 2 May 2026 09:48:26 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: watchdog: Fix typo "oncse" -> "once"
From: Randy Dunlap <rdunlap@infradead.org>
To: Wang Zihan <3772548978@qq.com>, linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org, linux@roeck-us.net, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_61E8FB326F4582DB0074952B9FE4A239CE05@qq.com>
 <9a6393f4-6aec-4f64-b3ef-9566206c4ac7@infradead.org>
Content-Language: en-US
In-Reply-To: <9a6393f4-6aec-4f64-b3ef-9566206c4ac7@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/2/26 9:32 AM, Randy Dunlap wrote:
> 
> 
> On 5/2/26 4:19 AM, Wang Zihan wrote:
>> Fix a typo in mlx-wdt.rst documentation.
>>
>> Signed-off-by: Wang Zihan <3772548978@qq.com>
>> ---
>>  Documentation/watchdog/mlx-wdt.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/watchdog/mlx-wdt.rst b/Documentation/watchdog/mlx-wdt.rst
>> index 35e690dea..3778f85d1 100644
>> --- a/Documentation/watchdog/mlx-wdt.rst
>> +++ b/Documentation/watchdog/mlx-wdt.rst
>> @@ -48,7 +48,7 @@ which is optional.
>>  Watchdog can be started during a probe, in this case it will be
>>  pinged by watchdog core before watchdog device will be opened by
>>  user space application.
>> -Watchdog can be initialised in nowayout way, i.e. oncse started
>> +Watchdog can be initialised in nowayout way, i.e. once started
>>  it can't be stopped.
>>  
>>  This mlx-wdt driver supports both HW watchdog implementations.
> 
> This typo is also fixed in my 5-patch series (pending).

[PATCH 1/5] docs: watchdog: mlx-wdt: small fixes
https://lore.kernel.org/linux-watchdog/20260228010402.2389343-2-rdunlap@infradead.org/

-- 
~Randy

