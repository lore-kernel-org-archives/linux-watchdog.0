Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670A288C2C;
	Sat,  2 May 2026 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777739541; cv=none; b=Gc1K+Bz/JaFJyCZGb0HsUmIWiVtu5rkFqyMJeC7uWJGPsaD3GxHE4+b6eIJZ3gssFM5yKUPTHtlYPNa13+aGw0seOnK3YMWecDkXnQ/OADXi4CgbmiVGCmX/4rAKPLe6ZRMEfqT7iz9w3eq1dmPXnOAaJALbEUazdYa7u8tYyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777739541; c=relaxed/simple;
	bh=x/BHD3CAXGDULNEJr3em1ZSuA9jCGCRkeWiAHj2zGI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T/9QdgFuvakrXsk055A3yfD6IjBorBe8g/sZruAxz3zqLrxt0dtIPsAhbPKdsn5sv/xxPPlaxNPfJ+9sS0FfcRDg9k/dliemzToyCeqTVSRteyCsmPqbZ64zIhPgEAozLu+2pqMKu5tUs9QR/6/ob/9+RF4zo0AEro45hySONY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZXxQWaSr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZXxQWaSr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=md7+zHAt5EGAX2gcfuHCurVIYrn7czIC8BCgt5qwUfQ=; b=ZXxQWaSrhy7/HVHhrKGOzRBMBR
	+OEW5iWBnH6ZuhqwsE8UfvHqEsZFNncOfa/XJX/p6ST2xKFbys4dPWMzit3bwWqoRJ1NxU6zA1zkz
	+eUUiNuJKJz75If41i1I33P58VDUHtbBym7Z2Byt1TCZC5f2e0jl9eMDBpkNlI6qjO7Xnwg0ASG83
	ki4N2EUIbuPicDiKpgnxph/2HpeTHoZ3/1KaIzssSTTy0HFtgEFmZlLn2M2UHchMHReJiB16n84HA
	/WnTl8ZkcD/e6JcL9n7snSTdw4D2BI22zd6F7DpWsHui1G7cR7xbpSgcKSe8KgSWlDyItbiSDEtuP
	JCW6zLuw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJDGJ-00000009KH2-3TrD;
	Sat, 02 May 2026 16:32:15 +0000
Message-ID: <9a6393f4-6aec-4f64-b3ef-9566206c4ac7@infradead.org>
Date: Sat, 2 May 2026 09:32:14 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: watchdog: Fix typo "oncse" -> "once"
To: Wang Zihan <3772548978@qq.com>, linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org, linux@roeck-us.net, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_61E8FB326F4582DB0074952B9FE4A239CE05@qq.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <tencent_61E8FB326F4582DB0074952B9FE4A239CE05@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/2/26 4:19 AM, Wang Zihan wrote:
> Fix a typo in mlx-wdt.rst documentation.
> 
> Signed-off-by: Wang Zihan <3772548978@qq.com>
> ---
>  Documentation/watchdog/mlx-wdt.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/watchdog/mlx-wdt.rst b/Documentation/watchdog/mlx-wdt.rst
> index 35e690dea..3778f85d1 100644
> --- a/Documentation/watchdog/mlx-wdt.rst
> +++ b/Documentation/watchdog/mlx-wdt.rst
> @@ -48,7 +48,7 @@ which is optional.
>  Watchdog can be started during a probe, in this case it will be
>  pinged by watchdog core before watchdog device will be opened by
>  user space application.
> -Watchdog can be initialised in nowayout way, i.e. oncse started
> +Watchdog can be initialised in nowayout way, i.e. once started
>  it can't be stopped.
>  
>  This mlx-wdt driver supports both HW watchdog implementations.

This typo is also fixed in my 5-patch series (pending).

-- 
~Randy

