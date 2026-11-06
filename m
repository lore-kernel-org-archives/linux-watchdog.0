Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974924;
	b=DaT1UG9YXj3+YC6wOH+AzD22RSIFyX4E1430gDKI/0Kl6guiglVEAH1iriVU0WLQjoRr
	 E2ZSRrWcKhzTQbYETaFh23p0SLbR9+xHXEHWrsItPsibxb7CbxYC/GH9lciYmyzw810jJ
	 aeeioUqxgDAFaVb+5WAvjMQSjnX1XIQe1lon9JFnby94NsCQ5t1wNopNh1RTa47REN5oF
	 3Q+SG5BCAJ58dx9M1DdLYxMpvbhzeDLN/Sr4JrfNQxZ93b1+D6QD5gUIXb39d6uFzNXNX
	 RNXzMQqrC305jK72Qfemi/3kt1Ff8eH0o1RfyL8MPbKMogAwZO/xnGmUZMrEk+ACrCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974924;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1CyuNBbmHWfQlK02spGsrvL05FvW7QnAOT3CvHmfiNE=;
	b=V0XjzrnDCv5PrW53+hb7akSvmd50/mpazKWiq/7P6Zl31SpPxfRFTfGXB4j9qliR4+6h
	 G/hSJs/zeDFwl7AgD0CQCYzI1zGwjRI8nKFs87WotibgyFSMQ8Y2I/+goQNUjHExMZTbh
	 MCBrZCI9av4KCOYG7p1S7OWkXFCp0pLbO6BJZTbBlwoDPTqXl+c8gyLkZt+OVucwtxhJR
	 sl5xGS+eod+IDedGQSXE3BnvDP3WyoIrdbdYH4Dnz7+XGKwwZB14s4ntcsD5Ip3SMB3hM
	 YTDD+7ljy6ZfcKjv/4UPRBjC/nRZW6vaAzMUMCpAHW7cMoLqKFLAHgFJQXc2NmK8prA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHMt8wMz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B1606A32C
	for <linux-watchdog@vger.kernel.org>; Fri,  6 Nov 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHMt8wMz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCE71F0089F;
	Fri,  6 Nov 2026 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974923;
	bh=1CyuNBbmHWfQlK02spGsrvL05FvW7QnAOT3CvHmfiNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IHMt8wMzhXIUe7GP8kcFGGsoScQlFkbez6kHIzAQ69khNj++niP5n1FLJ98d071RH
	 Pohfzh147bB3lIE22uLxgTvd8tsaj6Y+YXTy8Mt0p+k8Zuo1iltTpJKwRudVcl8l2f
	 3T+5ieUi/zDLGL4b57abTOgwZbihQLTQNbHU6xRDhQCNw6aa4NA6v4RUlt6DOruaqC
	 w/VPg8ydScbtP5mwAt5rxYFUh+v+r8J01V8tofPwzNkOmuGDNXcMOQis25PpqV/Ub+
	 DILDogBICf2cDc68kAcWn2IuYXrVJ18dMWfsfaj6YvaZr+6wL1tbHNnvfY0wievqc2
	 Cm2bUFTl5i5Tg==
Date: Fri, 6 Nov 2026 14:22:01 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v2 6/8] watchdog: starfive-wdt: Avoid unclocked MMIO read
 in starfive_wdt_get_timeleft()
Message-ID: <au3iicqFfz6iuvF3@google.com>
References: <20261105190530.2371854-1-linux@roeck-us.net>
 <20261105190530.2371854-7-linux@roeck-us.net>
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
In-Reply-To: <20261105190530.2371854-7-linux@roeck-us.net>

On Thu, Nov 05, 2026 at 11:05:27AM -0800, Guenter Roeck wrote:
> When the watchdog is inactive, runtime PM suspends the device and gates
> off apb_clk and core_clk via starfive_wdt_runtime_suspend(). However,
> reading the sysfs timeleft attribute via timeleft_show() or issuing
> ioctl(WDIOC_GETTIMELEFT) calls starfive_wdt_get_timeleft() unconditionally.
> 
> Because starfive_wdt_get_timeleft() reads the counter and interrupt status
> registers without checking whether the hardware watchdog is running,
> querying timeleft while inactive performs unclocked MMIO reads and triggers
> a bus fault.
> 
> Return 0 immediately in starfive_wdt_get_timeleft() when
> watchdog_hw_running() is false. When watchdog_hw_running() is true, the
> driver holds an active runtime PM reference keeping the clocks enabled.
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
> Cc: Ziv Xu <ziv.xu@starfivetech.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
