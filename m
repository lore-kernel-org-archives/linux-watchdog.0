Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A93C2F84F;
	Thu, 28 May 2026 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779930281; cv=none; b=ZYRlcpNFFBPiKfYoel9AUjDDrkiK68KKHgsU/wfA/EpDwRcXugm/8kX95t+LLqYIFRN6IoquH6BL2OIiIi8A+umB7LtVqV5uSrFlChMRRX1Ehk8s3j62mgVgEP0i4LUFXEu5gQDvjBHIXeg/FJE3NC+z73TmbL8oZbfyGaftA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779930281; c=relaxed/simple;
	bh=+htRiXE6u32bJhYWlwt25z8mPvqvJ5voB4ZDy+z1Eoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufPYwfIuROd9aNcNzNwPsXXoHHv29oqaGacl8ZqlXqZynMEyPwwzF1ujC3DG8Ef2vhg+FOnLX1taByxF8tDS7kglFSWFPwoMYrtIDUiuaJGhnOjy9MKVlZlHvYwpxRTvtfZbXkt/BwQE2QdE5grIA9+fAn62nc7G0WYjAvEnrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y82gGSDc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y82gGSDc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=QvB/8VDuUFg1Is00Z00WkYTKvGEX2FiwR5sxY7wnpBM=; b=y82gGSDcJnlI9OowIxg4cRP4Bw
	5HeQOdZrZF4DQf8PjOIPyNmax5MHxAWcMELuDD1/2d9E1c5KyZQHSpttyJjLMOq8bNgwbJZKEwEhe
	5wgOMOTi3sLHqtoMUKolHZ7XMo3NsYp7fubS3K4Q/epMLMtZ7UyQ9EpECfxMcUjoXHFYVIs/S09tL
	8A07eC6Ec1QACQB5Jl22WnT0NAeMC/2lpaIhniY3lCSN8npyAlkR1UCYTM4PVzLkeP2v3BCBaXJS9
	m1cdpNEQGs7VFW2w6M+Td7UDUy8lJIelkbRYbZhOdPnxvWy51THN6Cp09+8BT+h6HfTeEmqkj/+z6
	uI64pIig==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSPAt-00000004vXK-0I3v;
	Thu, 28 May 2026 01:04:39 +0000
Message-ID: <86407c7a-2ef5-4eed-9052-d58d2352b917@infradead.org>
Date: Wed, 27 May 2026 18:04:38 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] watchdog: uapi: add comments for what bit masks apply
 to
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
References: <20260528002803.1260126-4-rdunlap@infradead.org>
 <20260528003709.AA3681F000E9@smtp.kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260528003709.AA3681F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/27/26 5:37 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The newly added comments incorrectly describe the constants as 'Bit numbers' instead of 'Bit masks'.
> --
> 
> commit e1ceca9084192292295862799b05158c88be7e2d
> Author: Randy Dunlap <rdunlap@infradead.org>
> 
> watchdog: uapi: add comments for what bit masks apply to
> 
> This commit adds comments to the watchdog UAPI header to clarify which
> bit masks apply to specific watchdog options and ioctls.
> 
>> diff --git a/include/uapi/linux/watchdog.h b/include/uapi/linux/watchdog.h
>> index b15cde5c9054d..0d70a150809e8 100644
>> --- a/include/uapi/linux/watchdog.h
>> +++ b/include/uapi/linux/watchdog.h
>> @@ -36,6 +36,7 @@ struct watchdog_info {
>>  #define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
>>  #define	WDIOS_UNKNOWN		-1	/* Unknown status error */
>>  
>> +/* Bit numbers for watchdog_info.options, GETSTATUS and GETBOOTSTATUS ioctls */
> 
> [Severity: Low]
> Is the term "Bit numbers" accurate here? The constants that follow
> (0x0001, 0x0002, etc.) are actually bit masks.
> 
> In the kernel, a bit number is typically a zero-based index used with
> operations like test_bit() or set_bit(). Describing these as bit numbers
> might be misleading. Would "Bit masks" be more appropriate?
> 
>>  #define	WDIOF_OVERHEAT		0x0001	/* Reset due to CPU overheat */
>>  #define	WDIOF_FANFAULT		0x0002	/* Fan failed */
> 
> [ ... ]
> 
>> @@ -50,6 +51,7 @@ struct watchdog_info {
>>  					   other external alarm not a reboot */
>>  #define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
>>  
>> +/* Bit numbers for WDIOC_SETOPTIONS ioctl */
> 
> [Severity: Low]
> This isn't a bug, but this comment also refers to the power-of-two values
> below as bit numbers instead of bit masks.
> 
>>  #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */
>>  #define	WDIOS_ENABLECARD	0x0002	/* Turn on the watchdog timer */
> 

Righto. I'll change both of those.

-- 
~Randy

