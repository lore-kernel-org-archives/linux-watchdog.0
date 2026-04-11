Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095B61D6BB;
	Sat, 11 Apr 2026 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775928176; cv=none; b=VRLm8Aexv8vPCw0ddBsriF4FvWml4BzAiGiwaGeXUMNd1nTHwPEfc5bGAw4DcQEqb1qSxywEZKcYt5wHg1bbdj3LpDu3TxVkHKXS0u94BFggrAX0sJBnhG3Ta1L/yCryOFd41+kdVHEdhStXGLbyATRZi8TSARgOlc+10l6MB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775928176; c=relaxed/simple;
	bh=FQM6ywD0C9OLhQRBxpAw2CwAxJnCiGuArr7SZIsbfoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yu6JUnrzSlZK8Df42wk+V7n6lOpbRj2ou5xE4JqMdYj6REg3A+aPugfh1z05ZuhH3zWy0DMq3Z3u/AyvQB4dHaA/w3/S+ab9q3KQoOR1byZfkycpzjYwkjNXTD200373C3E2xNKkrrV498GbrEWNE7jj2WkyA/tn8y4E0z5wULM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FEcccpnt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FEcccpnt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=xMZtbxovVZdXpmbCooD3OY0FSnOrTeJL/fyBNqIaSmw=; b=FEcccpntOTw1Eun65rrMre9qdH
	q03H2Rnmu5eKw4TtkTCnaH1R9Ezl8N/X3xYnHFK/1tGGfLep4qENqG12MD4PBPrhuFkGAE3ktInTx
	h5dOYBa9CPjmo2oA8Nj1BG8IRy9zCCqRVCxoSh3FDEmAOI0QZSebN5Wkl5Gn2x2YZzNx9vsIyRqcr
	QiqkqHUu6HvU1yCtPWMtSvPU1QhhLzCNrifd5uQCwAa3oE2n4MUIqHO623+6OrEbukmOsMk/WU9gl
	JRt0LZYgNCNT6m3NNMt+YBBTnXBhKvZW+Dbcx3TELuapjgux0wwWwAH3yjv4sGfK7OJyNlT/Lg4jA
	zzMqxbZw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBc2c-0000000DfqX-2m2M;
	Sat, 11 Apr 2026 17:22:42 +0000
Message-ID: <303dcd9e-ca40-48b7-851e-6cd283cb96ad@infradead.org>
Date: Sat, 11 Apr 2026 10:22:42 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: Refactored watchdog old doc
To: Sunny Patel <nueralspacetech@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <3e25ae54-e62d-484e-8d90-4f7825705e4f@roeck-us.net>
 <20260411150922.20536-1-nueralspacetech@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260411150922.20536-1-nueralspacetech@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/11/26 8:09 AM, Sunny Patel wrote:
> Mark WDIOC_GETTEMP and WDIOS_TEMPPANIC as deprecated since
> neither is implemented by the watchdog core and both are only
> present in a small number of legacy drivers.
> 
> Add documentation for previously undocumented status bits
> WDIOF_MAGICCLOSE and WDIOF_ALARMONLY in the options field.
> 
> Add documentation for WDIOF_PRETIMEOUT and WDIOF_SETTIMEOUT
> status bits describing their respective ioctls.
> 
> Fix the following issues in existing documentation:
>   - Remove version-specific reference to Linux 2.4.18 from
>     the GETTIMEOUT ioctl description
>   - Fix duplicate "was is" in printf format strings
>   - Replace [FIXME] placeholder with proper descriptions for
>     WDIOS_DISABLECARD, WDIOS_ENABLECARD and WDIOS_TEMPPANIC
> 
> Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
> ---
> 
> Changes in v2:
>   - Fixed typos: "tiemout" -> "timeout", "characted" -> "character"
>   - Fixed "small number if legacy" -> "of legacy"
>   - Fixed capitalization: "New Drivers" -> "New drivers", "USE" -> "Use"
>   - Fixed spacing: "WDIOS_DISABLECARD,this" -> "WDIOS_DISABLECARD, this"
>   - Fixed double spaces in two places
>   - Added missing newline at end of file
>   - Rewrote commit message

However, you failed to fix a malformed table warning that I reported here:
https://lore.kernel.org/linux-doc/9e3403a0-4ec2-4fbe-a50f-53f939c1d841@infradead.org/

Documentation/watchdog/watchdog-api.rst:250: ERROR: Malformed table.
Text in column margin in table line 2.

================        ================================
WDIOF_ALARMONLY     Not a reboot watchdog
================        ================================


So I repeat, please test your patches.

> 
>  Documentation/watchdog/watchdog-api.rst | 59 +++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 8 deletions(-)
-- 
~Randy

