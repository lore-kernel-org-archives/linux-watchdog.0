Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459565;
	b=HgMn+tGZfkqy09GCATGb9F2VqG5R8gibrGjt4bSS3AjcgQb2/P4pS0PAA6Msu1Y9Xqr0
	 el+mTDe8mNnZV4Snheuuxnjtv+LVagTrmmMHVupxuvSPeYwzxo9WS3DjPPOnfWlnNFB4e
	 4G/eHm7W4w/h9LFNasWXV2P2d2YE5tIJ2EK0RjgmVQLXzBg5/GwybNgADu5p8ciMD2BFw
	 386T5CDmD+VBEH/GsSI1ua2dXeQMoxJt9rx3OkFBwrCWnlTNScV8vHKR1RR36kDcBVciz
	 bVBZ0uyJJZq+gVG5tnzaRLY7I7bGzLkqLsasCyfI82CW5V4iN2luKDB9LA5P684ZB6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TDPMkG1SQgnWSwQUqpWJz4GemlxwNldPDN0SoLdOdWA=;
	b=MflC0WV/+rxo5E3oLlyxYBd2eZbMBrqUniqAilJh8D/QDK+5HAw3cuQGu6lu2DrelGyt
	 PUsBn3J/TGFpM5gllmZFp6gpW85CCIDk2sTKVXu/efCpe8E5J/lxAbOYkqWv5UjqHfGlu
	 eilNNjj6bdXptGHOxOERbMHsPeu1jzPaTw2vyuUnLbGnibFcxsXH6hd/50W8stKcvqCr6
	 VK29F6AYMkjUArdOoe11V/z6YAUaaUi4wORYYngRjuvArOcl8VHvDYD2ulWNnQ2276iyr
	 UrHGVvDyfDuyzSjvrvGi8zzOiyEertdaG818V+w6DCPoeAZP8k+Lgn3oXpheLZriX8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dtUKGBhT;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50834606A31E
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50834606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dtUKGBhT
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ccca948203aso987786a12.3
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792459564; x=1793064364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TDPMkG1SQgnWSwQUqpWJz4GemlxwNldPDN0SoLdOdWA=;
        b=dtUKGBhTi4pj2sO++DHt5X+7Sx+F3pK5XAmnYA/olV3k80cy4IDnn+ykEnmQkRvSIG
         DhRDPrRav/PXW8OqhjimAI4udO+ElQn5Vhh8Q0NIgYrjvTr4cBcTieqRhlgGp5ACYGzZ
         rfsT/Mns7cRkdieikIXgem5Hr+dWNuv88t/hqtujOTRULVBaxmqBVW7aR1OVlbGo0CnA
         54dKgRbAm4CYiUYR45AjsbmZsYE9GQ+/HDlQruDkegX7lzvdJC/sRauGrm5I4LpZyFug
         xKTqtc5sJNY+z2UJAZrfRCOWLWx+bn/CVvWjNjfILZ54VNStNOzjj925t2tmMh6pZqg1
         JOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792459564; x=1793064364;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TDPMkG1SQgnWSwQUqpWJz4GemlxwNldPDN0SoLdOdWA=;
        b=jns5sDvLtp5//sm99JQ1e2NKmG8Qo5cKEdjqYJKkWF0N/BuNg8xPw7AUu/92C5Vw/e
         P786jisbpKe/Ohn1LE8NAmMOD+Rhjff00XOkLcQNK9UdExxZupRjel039oBSwCRygKJj
         p0THpf0GZrqNjNo/N9k6TJaHk254r/R6ht6FDbsUT4qhb6HSKa1JaRlC7cY2f784oCGI
         5QE8K2+o7aFCPLy9NHPKKmGAonqjA1zqzjYSnkPshZQaeHXg0FYUxTM2MPWoBqStT0E7
         tHYHW/ghLXXl6Ouglrx8iNXig5cYTcYyPNtwduNK91jD3YyGmSlOm56xQ61iqPoOCJ/I
         l8ww==
X-Forwarded-Encrypted: i=1; AKwUvBxJs1fMtGcG8mjUA242la5SH3BqmtJ1wLDQSqGOCWJ/T/zWXFkHVJGF2y0jkQ4JS8z0KaKUco7f6A+fub4K3Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYIfqRZXEb42uyq0UBoPj/741j2zbQ6CvNmfKoZ4TYeAvQiXdzfZ
	1ysNXD104L2w+xT3mjkGW5RHLDjaPVrKKKJwSreEDMF0KEfgQ5vD/C0g
X-Gm-Gg: AYBFou3t6X2LOF8KdeIqYbvdhdb3UMgg0dNKUYRpesnqtVp2k7xJmzfZuDq9aMdfMr4
	4bLMlLUiyv98+F/sZrtGr/Vz73ehcEBE5LW4pvXnBuEUTLYH4fESk9DVOoelxgqg8lP+D2qsRb4
	Z5WLoHFT1IdryQrH3aeHsUd5RQ8QETebz87C0FRFrbI8LAm9YIJIRHKpMKC4+VsIqc9twetAkeY
	y+kb59cRZZ799dLuV/aY/QwdKL1DhosbYF5RqwFwFAjULYMhHF4nezok29JO9HzpMS1jFZwDqj4
	TIXvDAjPs4JybyegscKrzXrigA9rRuYtjCzFCVM8O4C8D7/yOh09DooWL/wCEbcILym1KNANSBj
	CokfUSK0LNngBtUEYw+sDVawX7UnRiuuxQngi+MIoYWramgl03Hql6yYTV8Ly72WHuOik9Kqr/7
	njILeehOOqEk6xSM/OyansET3nNtfYLfVL7K3gGZRMaZKcy0f8MIbURp/JCx5TJ7LHcobyY+E60
	dAD05JsgU2bbnGaYMHhu/ffp6HIKyHLFAOhJzVMCxdwv9wkk3X0mxwqT/gilgBTMDg6hg==
X-Received: by 2002:a17:90b:57c7:b0:3ac:a139:1b13 with SMTP id 98e67ed59e1d1-3aceed9ff39mr7771161a91.29.1792459564582;
        Mon, 19 Oct 2026 18:26:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5df655b1sm1647321a91.17.2026.10.19.18.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:26:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:26:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: krzk@kernel.org, peter.griffin@linaro.org, robh@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	hajun.sung@samsung.com, wim@linux-watchdog.org
Subject: Re: [PATCH v3 2/2] watchdog: s3c2410_wdt: Add support for Exynos8855
 SoC
Message-ID: <38b3759c-b564-4826-bae3-5f0eda7ed20c@roeck-us.net>
References: <20261006161700.2185432-1-alim.akhtar@samsung.com>
 <CGME20261006155900epcas5p1b842116272ea9d75c815ebb11303cfa5@epcas5p1.samsung.com>
 <20261006161700.2185432-2-alim.akhtar@samsung.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006161700.2185432-2-alim.akhtar@samsung.com>

On Tue, Oct 06, 2026 at 09:47:00PM +0530, Alim Akhtar wrote:
> Watchdog IP on this SoC is similar to Exynos850/ExynosAutov{9/920}.
> This does not have CNT_EN_WDT bit in PMU and offset of RST_STAT is
> different then the previously support SoC.
> Reuse the offset as much as possible from already supported SoCs
> 
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Applied.

This missed the start of the commit window, so queued for v7.5.
Sorry for the delay.

Guenter
