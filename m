Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1D294A10;
	Sun,  3 May 2026 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777821666; cv=none; b=Ds3TZeMT6NhKe61u1H/Te9VNk969gJ0OdxwA44Ri674nm7Tsd/9UjSUpGqVsSzhnunc4BBGxnUaRxIbYHet7mEKEeuXr0YwufQRjK0KKN3eZTZgIxA5rCPy5BWn5l4J6JdjNyuLAOodOTTRDJPst1SJiMc6i6rQh69a7Vvr6ndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777821666; c=relaxed/simple;
	bh=oRzSBmvaC0wDFlpC1BmnAf1wkzWW3YM+yLa46mPJhe4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r44lHsHKFKttWVMy/P/L8HDE0impxzq7gm/8y7reBvVObzuwkJxJWvP65MZHMDLBjTy+V2CQP3oglSyK+63hR/sL3cbAUgoD/RH9ZNvrOtbuv1seKWuSOr301cCvYBTvW228hZRw4NAuX2vjs8aB45Qlqv13AAsxkO3MdV5wQ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PgPDhotf; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PgPDhotf"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A3B1741202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1777821665; bh=CKwv6HzDtRDzQd3GF544mljP79vzRuJnefhhL5BGSR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PgPDhotfB8RC4NYluBPHq3TKLUgca5Z2sfYTm/mV5oig2KTS0dDFsgun5OH0DnBwc
	 6NPzxD7m2KKdntO3t1ed+ZRvTtKRmm1R6CN/i2Uy2UVKgwRvQc1P2KYVrJUdLVtxLg
	 tdVBBGK882R/2PW38vZdN63tRvtlVCKeaokpA/kWjfPrMAohGx7Sxkbeg+XUBFM53a
	 FX4YV8bSNhW4QyR6qwasGuRpv6l3OBCWg/KUeodUxhrMXCYhbp7eLh5FnIC3qZo0Y/
	 z/urAEd6xAjl7MNlQd1PvAwHPFDBeyXCrWkN0ps/FRDNIp8QjHxwMwVBsp1JhBGbkK
	 EmEcSkDRE+9Rw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A3B1741202;
	Sun,  3 May 2026 15:21:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, Wang Zihan <3772548978@qq.com>,
 linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org, linux@roeck-us.net, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: watchdog: Fix typo "oncse" -> "once"
In-Reply-To: <9a6393f4-6aec-4f64-b3ef-9566206c4ac7@infradead.org>
References: <tencent_61E8FB326F4582DB0074952B9FE4A239CE05@qq.com>
 <9a6393f4-6aec-4f64-b3ef-9566206c4ac7@infradead.org>
Date: Sun, 03 May 2026 09:21:02 -0600
Message-ID: <87pl3cbjtt.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

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

...which I just applied, so this patch here is no longer relevant.
Thank you, though, for working to make our documentation better!

jon
