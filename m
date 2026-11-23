Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468555;
	b=mrPvhyjvMMu2DX3dN75nXqgEkkzXwf3EsRzN0+E5UVHLDoFMbvEZW0dt+oayck+/y3hm
	 NQxkBt8oMsCoWyGFsM8Vbn9TKJ/F2mOp2bepH1NpuwYfLNrLjlMekF7+04QRXP+m9NKnb
	 hsPPOwIJrxTSHmVju+aQesAxJA8xyDimu9NWmrkJG1wV4mVBKyOWhGYiMGndXepRrKxht
	 zjDFwNIIeJk5t1/2KH2iUWCe9bmuhfqF5FESKtEv0ZOcsWIsizWSDMNQuy44xg75e/+Db
	 Qb+V0u1GGHiW8ek+ZNIeIApGGGAolYZu6BV0FaDZo2DKI0BSjZfjfDlS1eg/xgQg38w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468555;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=SugmUpZcP3giXxtLx/2w5dJCUwvJBZHQ6LFuruKUSkA=;
	b=k3BDNoQ2f7N7jU5blFJiDHnGCXnk9y7uaqWRNp2Vjbu1/FfyBDGncBAy96f42L56MX7q
	 oZY6XkyeMpl/kATNn05sJ/7Qelp3l1r+pxU5N5/ghWzNxAIrjChPT4drFXoykLRa8ajDv
	 PI6ESgBbkb3CBiIprXXUOcanABs92z9OzUVHb76gk+ePZt+enObXQKyktTl6oNFseuSMJ
	 g5MtCSf0R8agMlztaN1eANPLi3KTXPgrqZsBE667gA8dN/5mpZQ41/zkHwNSeSRqY4lts
	 kA94TPax19WUj6gxt+VYP3yPsXmjhOohmduEEeeYn0if+oJFH7ozHlqRQqBEwIZwC3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b="lcjkfZ/P";
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0853606A31E
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 21:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0853606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=lcjkfZ/P
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id Vb8uxzqWPVK9UVbOEx0M32; Mon, 23 Nov 2026 21:15:54 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id VbODxBGHob2qJVbOExWMxN; Mon, 23 Nov 2026 21:15:54 +0000
X-Authority-Analysis: v=2.4 cv=A7tsP7WG c=1 sm=1 tr=0 ts=6b04ad0a
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=sU80RbG2OwnfRxnRxfwA:9 a=QEXdDO2ut3YA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=SugmUpZcP3giXxtLx/2w5dJCUwvJBZHQ6LFuruKUSkA=; b=lcjkfZ/Pgeic
	rvtTIVHDitz6wgH2z/c9vh3nQNrx2cYW7Lq4gCjd7oSlfLNOsMpsNibZ6P1kpEqzYq+Rn0qxrxkfl
	iZdF2wgbqWHSG5KeGblgTibB/evRLBJTV8dV14fN+iqcvWlP2gPApAZ5mQcvM7+K7xl4VKBMEwutz
	R0D/kraDgrZUJyfZVnT/fvi9MpccY8XLN7BBDfNp4jsRpxLgkVHzfAAfCsfAxR0p4jbFcKsL50hD7
	a6nswQEa+jgDIlwCYOWAxNyVc8T+EjaVoBhB9yx9PEutp0WjIkiZ6SSPYClyjAbtplUx026Pwo7MA
	OCdxWIoaHTLVth54bNuCtw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:51544)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xVbOD-000000024Jv-1gXA;
	Tue, 24 Nov 2026 02:45:53 +0530
Message-ID: <eafefe7b-c1e2-4130-847c-84b969b471b7@roeck-us.net>
Date: Mon, 23 Nov 2026 13:15:52 -0800
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: core: Fix module refcount imbalance when open
 fails
To: Artur Kowalski <arturkow2000@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wim Van Sebroeck <wim@iguana.be>
References: <20261123-core-wdt-fix-v1-1-a315269dce4b@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261123-core-wdt-fix-v1-1-a315269dce4b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xVbOD-000000024Jv-1gXA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:51544
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 3
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN295m/h2jygIYUkKG27m14gi7JojPQS+rvEYEHnM/CAYc88mh92j96oEvjJvBozVk+O10WKM8c/vrRQm0so1rP6YVirdb88RiUBpk5KjJqN+pmsbdQC
 j2CYW0j5MyZdksSDI9HCvOzeJRvNw6KNP73z/voIMCgNDTPi/P0ayzSjbbzk4YjiM2zBccaORicBPBn6/19JppdCpsMDtQFzNo/HG9l84DFEStL7modJGsTP

On 11/23/26 12:46, Artur Kowalski wrote:
> watchdog_open() doesn't take a module reference for a watchdog that is
> running in hardware, as watchdog_cdev_register() already holds one for
> it. If watchdog_start() then fails, which for such a watchdog means the
> driver's ping failed, the error path drops a module reference anyway.
> 
> This drops the reference held for the running watchdog, so the module
> can be unloaded while the watchdog is running and the core still uses
> it. Stopping the watchdog through the core later drops the reference a
> second time, underflowing the module refcount.
> 
> Only drop the module reference on the error path if it was taken.
> 
> This was found with the help of Sashiko and Claude. It can be triggered
> by any modular driver whose ping can fail on a watchdog that was running
> when it was registered. No in-tree driver was checked for that. The fix
> was build tested only, and no reproducer was run.
> 
> Fixes: ee142889e32f ("watchdog: Introduce WDOG_HW_RUNNING flag")
> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
> ---
> This was found while developing a Tegra20 watchdog driver. A watchdog
> reset hangs Tegra20's boot ROM once the VDE power partition is off, so
> the driver stops the watchdog behind the core's back when that happens.
> Failing pings afterwards would trigger this bug when opening a watchdog
> left running by the bootloader, so the driver keeps them succeeding
> until user space has started the watchdog.
> ---
>   drivers/watchdog/watchdog_dev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index e8c1fcb53c56..9ad715d4d46d 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -913,7 +913,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
>   	return stream_open(inode, file);
>   
>   out_mod:
> -	module_put(wd_data->wdd->ops->owner);
> +	if (!hw_running)
> +		module_put(wd_data->wdd->ops->owner);

That seems to be identical to upstream commit e1d91be1ec2e6 ("watchdog:
core: Fix unbalanced module_put() in watchdog_open()").

Id suggest to update your tree to v7.4-rc4 or later to avoid hitting
a number of other recently fixed issues in the watchdog subsystem core.

Thanks,
Guenter

