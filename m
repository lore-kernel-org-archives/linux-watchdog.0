Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73044211B
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Jul 2026 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519751; cv=none; b=Aijg/2y2792zN8NdWpbC+TGlE3vHH4DL8OGwkJ4VTjZZr0fmEeL4/H3WK3VDd5TGwZwORY/vk+D3t5+lDbTGu74/gn7bEIj89/7L7M4GmcWKUyriaYai7ARDgsywa9YMg5I1RllrZy0taA7n3fgIcCrBi/oQSUpmvBiohq0sMgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519751; c=relaxed/simple;
	bh=OpYADzo9BYn7CZWFtK8FBgF5VkGQzi+h/k6iLphFPnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laUGePbaBurNwmnTP/retH1dQpnR/cSGOc/NRwW9+1zFVBZHHghs882nyFSO2bQEY5iDkuLGPHKEvNSaiq9O1z8/lMSHi3gfQzhddj/GJSZ4RYWIcRK6YQl7JJ57OKuv4CGH8I4JMMWeH3Jr88I8RAO6P9bQZATKqbZ+GMc0L2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9QE57MR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9QE57MR"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so388957a12.1
        for <linux-watchdog@vger.kernel.org>; Wed, 08 Jul 2026 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783519749; x=1784124549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mxQ6p6qH0xhQ9b3siMinkgMwzVrBiCLnu56N4IBGMbs=;
        b=E9QE57MRGCDksf5kHAgThXLuxecmi+xveSss9NajOPSlhRKBEkQZrqO0PEEB0H0cIm
         hFAfubNUsuQBOwjJaMaCbNXYQ1dVo+CKcOM9l1reZbs+mSwmI0smYk1jIxBKthcHZ75X
         OH5qpUPOCzp/0VfvGhwlOZd8N4LbXiGoWFPURdrRxsVEXx7tO35pSaL+KDV9Ms6uY2c6
         R7iTLOXBgphWLzEqlsVMd9V3L9IqZzxFf3Vhse2nbyQwx1Nj+TAMb0vgn5zau03uvQB3
         YJylQWNps3xiczTRI6KyUpzLf3mo7DPMoPC0aE3aL/lcxjA6EyN/ndZP5qa9P88dPbdG
         Hvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519749; x=1784124549;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mxQ6p6qH0xhQ9b3siMinkgMwzVrBiCLnu56N4IBGMbs=;
        b=C7RQKVEsMqGqnU0/OSSghgp6mM4rN0d/J8j0nWHUvh3BAWCjmK4zo5sOq6u9BF/9a3
         t93Pad/i7tkl1llu6JMeNkwizJoJ7cNyHo9kNd9+07jth2FF9h8EAZzgzxN001Z+N01r
         58J34q7yFLwBVbiPooU9P2NJ3s1Uro/UK8ghoyFGHX4Et+ZaAznuM7By0lXF1ytm01FM
         qF8d/4giPTtITdlulTDTPW1c6dCmBGTHe6mlybdHw4KzWg4ftNNI0TNwKVCE3PrC6Zfm
         gG4lCDlclOD6t85XdXQcsFSQvq0RsiRY4kbgi5J8XLxCdtImB7pFk0TVBHC6bxob12c8
         Cykg==
X-Forwarded-Encrypted: i=1; AHgh+RoKIciAHEEWu4AKp8CemmqSinULhPe0AYhMj81LY+nPr52phVachQdoTCERCPa3U/TyQGgssTt3rzCelLQM4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyby2iZRpVlkkdPSfK+lacBCFW6hitQsOFnvv0KaRFVDMATErjx
	vz5shzQZCM/lHXP2D6nLATq+iMdzcUrufRhrMZ/6Kskm4F10y5qjMSw4
X-Gm-Gg: AfdE7cmFUC83WjQJqNiEfub8NuvTSApkNy9sg1neIj6y+5IEpUzHn4F5rUvLBg3yrw/
	QN6atxBX4rHsafdTQNNtov6HgGhp4+g+0C43qEFLF5WRBzJqz/qxVsQc2Su2t84vv0gFxR6pn+E
	YKsdNvjJSfhfPfj99Em7ksVTl1EXAOk5j+IZKwY38PHA6FOhFaNT+Bvmfxw3KHKXgK5mAxocB+k
	0PNvQJ91rvCthSJdsg+ujQq4jqAy4NDNkCJFBcThgVBpDxbb6aZ0Eat0Wcy07QLe7bcRDAoWMUG
	1mWAlZeqAle/clEwuIeYEQC36XPI8PZsS0fBqYoiwbSS6DEF91q8ZbUikSaSqYh0n4gLDdClFjQ
	u2RXuNhrDbuGtP82NIeev2GekPW1ec2btqvUuaNLWTntEsDkeWU9KQBklWG98/+aO6drqR9WGQ2
	jX3ZzspK5DnIvRVlcGu/f3ipMOCA==
X-Received: by 2002:a05:6a21:328b:b0:3bf:8ae7:ba7e with SMTP id adf61e73a8af0-3c0bcf5d7ffmr3665179637.17.1783519749278;
        Wed, 08 Jul 2026 07:09:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3643399sm2530163a12.22.2026.07.08.07.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:09:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 8 Jul 2026 07:09:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wayen Yan <win847@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: airoha: Prevent division by zero when clock
 frequency is zero
Message-ID: <d1d4fad9-31b2-493d-92f5-360a43effbf4@roeck-us.net>
References: <178347932594.81327.4834644880399144119@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178347932594.81327.4834644880399144119@gmail.com>

On Wed, Jul 08, 2026 at 10:41:54AM +0800, Wayen Yan wrote:
> clk_get_rate() can return 0 when the clock provider is not properly
> configured or the clock is unmanaged. The driver uses wdt_freq as a
> divisor directly in airoha_wdt_probe() to compute max_timeout and in
> airoha_wdt_get_timeleft() to compute the remaining time, which results
> in a division by zero.
> 
> Add a check for wdt_freq == 0 in probe and return -EINVAL with
> dev_err_probe() to prevent the division by zero and provide a
> diagnostic message.
> 
> Fixes: 3cf67f3769b8 ("watchdog: Add support for Airoha EN7851 watchdog")
> Signed-off-by: Wayen Yan <win847@gmail.com>

Applied.

Thanks,
Guenter
