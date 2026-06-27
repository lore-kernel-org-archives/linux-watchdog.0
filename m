Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3621C5D72;
	Sat, 27 Jun 2026 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782583915; cv=none; b=hHVnaFcKXxGLUFCev7k6i9mfyZbJEYD6M/iR6T4Rrq1riihGYYlJ3ZS+FXnZzpHzuoK5svYtTJ403VALNSUrJK7suXoRfYf1rY3kp2ZCzqDdiUZBGrqiya6P6jq2Uqc11CXxREaTI/Bej1oCZLV9zz3PokHzChGRTqdOISfOFFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782583915; c=relaxed/simple;
	bh=qGDUxhviRnm7IIVmhNMjqmzyrnEb4wgA2TfUsM+XLzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RcyIQH7P1z6+aoZ8ljXcO2hqdSNDQNGf/pIv2QSPr8Z8EgnhxQovRJ8NkpiJrJzLSjWqTvZdvrGA93mjQZYMKrQpMtrqiSrloYp4+BM+Ag/Amo9Wh5+cwARryNCERdbJ43cmLFmQ6hrC2FrPBIdiTffjaLD1/myHRvyfu8SUmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QsZeGoc4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QsZeGoc4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=7h+N/UUWjxazJxi7OmuFdN82kq9fAKPnIPFkiSg7QaQ=; b=QsZeGoc4GHhfbnz6oOGEUjfPOr
	aAghmSpaAdFwbmUja/nmmPT74uwv/zNcOOSx7t1hqlmKBUoLSh8lNPqmqE5c2qBziEma4u0dSatxr
	hwtkabq490bCs2FhQ0OR/T53nOC2JgSTNiCLei9ix1lIRiO+5uCSY1Hq2PXehXtbwX2sukZogOPKJ
	mMNolUjghd3+cSKE9BnIjCU4J30vmWjf+guegOsv6L2wEF2ZOxkIxhjKOSDxzyE9q8a5XYwFDiruZ
	4jSN/VyZ48snr1YcLLs216DpV3BPJPB0pqbvZibNVRXEW2hRUfjJRSyhwszJsIS8LwVuuLqzhjqmw
	SXSGHYHQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdXVP-0000000ChHt-1dwg;
	Sat, 27 Jun 2026 18:11:51 +0000
Message-ID: <040f4089-7f81-470a-92d3-3ad022f3fd86@infradead.org>
Date: Sat, 27 Jun 2026 11:11:50 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: watchdog: Fix brackets
To: Manuel Ebner <manuelebner@mailbox.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260627091707.29688-2-manuelebner@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260627091707.29688-2-manuelebner@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/27/26 2:17 AM, Manuel Ebner wrote:
> Add missing brackets ')'.
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/watchdog/watchdog-parameters.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.rst b/Documentation/watchdog/watchdog-parameters.rst
> index 2359aa32e25d..8e2df5b7d241 100644
> --- a/Documentation/watchdog/watchdog-parameters.rst
> +++ b/Documentation/watchdog/watchdog-parameters.rst
> @@ -59,7 +59,7 @@ advantechwdt:
>  
>  alim1535_wdt:
>      timeout:
> -	Watchdog timeout in seconds. (0 < timeout < 18000, default=60
> +	Watchdog timeout in seconds. (0 < timeout < 18000, default=60)
>      nowayout:
>  	Watchdog cannot be stopped once started
>  	(default=kernel config parameter)
> @@ -68,7 +68,7 @@ alim1535_wdt:
>  
>  alim7101_wdt:
>      timeout:
> -	Watchdog timeout in seconds. (1<=timeout<=3600, default=30
> +	Watchdog timeout in seconds. (1<=timeout<=3600, default=30)
>      use_gpio:
>  	Use the gpio watchdog (required by old cobalt boards).
>  	default=0/off/no

-- 
~Randy
