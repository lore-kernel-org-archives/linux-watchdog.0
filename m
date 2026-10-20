Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460673;
	b=dPd8SJg/bZ/HKPYudE4wo7UhpRzxmAUjHiXSbtKQntiFkTpmNuC0q2FF7km2KnlILCaM
	 OTC726EhTNhLjnxE4KRCuHjbJx73yFU+5df8Fd/kMwToyvTxrkjPyEOFaWMclTSYDGoh4
	 5000v8AZF6VnDOxnR7WvygFthfFejzUCxmASdc2TnBD6ZkDVgIqu+Z3WBUQveCIvEFgaF
	 c/AZI+c4VDFd0rZSERtbUS0f/vc4M2ra7PXimrzrE0zxFRZ0t5sIFn8IDnE8ixkMTytLy
	 9xT0HOC6FWKS/l6opZS19m79tixrzEmHjpk75iJgiJ2Dle6YsTuQJK4ftFehjGI70PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=qWPo6Ih0/scjWj9tcKOojGIcqQqtvEcjo0ZHZ/nTgDU=;
	b=OCFFVcXDFEfg4XGjFy/mRBNdIxR1FhhFsH9n7tB0RqYiHFAEGfFpffqYmEwmCA+m9JOZ
	 ZgSCBkRSHoskIZLIqgJ/zDtbc52E6zJJjhutOdVG65pNFhDaND33TD5F76Jz55DyMW0ac
	 qz0wczwMUJy0IT9Ta4nSDfDDsaU+uCUQEiISITTuFy1EE7cjAAg8M97ABycAs7c5D/s0P
	 vOx67FSn8VCNA1W/GNnwibml9IJ3zeSzML+qS9KNHJTnsi6lgzLm1uiNhwEhaVDM20S+3
	 p05F7yxDJNQ71Z1oYqDRCLr1Xt/v2SWxqlrd1JWu97/AfHwl9CgJPJIJ45qCNpsVUPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q0kBGz+c;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1DF606A31A
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D1DF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q0kBGz+c
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3423678eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460672; x=1793065472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qWPo6Ih0/scjWj9tcKOojGIcqQqtvEcjo0ZHZ/nTgDU=;
        b=q0kBGz+cG6DGkD/uU4F68V/2cKLUWhiIBiHJGcDUjjlVLJaDmiFKV+QKN8IFa1TRKT
         DU921CG7iyK6EBdWo0gtnqgyAIOjCMLbX+1MrQ6OpkpQ1VZah8oGdM0BrsUXguYCe82P
         sPz+60w19lF9ySvhMbWy9SZMoNT5vgCPDALs/0CSKVt6KGJk8G/8LHxzJLxLpLOjQroj
         acM1HKlZ/z4CQBlZ78Ixr5DffYrFp6z0ZiYBRgisIQ6NYwoo64ok9CSfRzdUtenrjC99
         mczDZodAICQKKYqD96NLK2S7qG+u7fifdMA9mFb88TJg6yChVxQvNHuJsGn+Th2Eb9bB
         P+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460672; x=1793065472;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWPo6Ih0/scjWj9tcKOojGIcqQqtvEcjo0ZHZ/nTgDU=;
        b=J1CrBhqMm1S8FXzzclrMFQbw9fCqcgoBjBH3WJgnJcvwuItEdjlWVYwITygKv2UCM6
         XoskLmD6c9Z6ObIp6skhGbRyZ/dnwKTbpJc1b3V61A8ZX6VaJIbeuzH3fVi0dKFfd70O
         cV/q0jYIJWGgeliVBVVy+eu2t8HVGjpKPGHMaDlSk/2NoDiqc8IJP0OlXlhthzk16WnZ
         3SZfmofESQu1Djngln6D2B8K5SINQ0voC7Q1OPGGEUmhQAWCVymMibT3+dKIqBhp+DVG
         2SGNA5e6BUmq8LRzk0eSshY3aCBqDHZHB8sT6/R0Sg8kXPpC2uysE9Z/YegEkYTUmC6w
         WKxw==
X-Forwarded-Encrypted: i=1; AKwUvBxYNB40cEzbW2Shlk1Kar8ZyJQRgGBaAs74NAdtlT4BuIXAdZOxfLzvb1LjSh8JsqUvC+wRq2QfDDF5yqXTqg==@vger.kernel.org
X-Gm-Message-State: AFq9FYInG74OM4g3hQ5+fF1nLtoNpxWWkD4rEmoplQFr7M+u6Bx6BkI1
	3pRsX72ej5+5RA3HQX56ZVPcyswHFEhlSkOzJ71acpzOYMv5TaXzhn2Jp4mxAg==
X-Gm-Gg: AYBFou1oPdFlUSTEXwHt2cSrXqdbdHNuHd7lBngvtGmTR3eArrXkLDy7x1uPQClpQqS
	O6oecrhPgOL59OOETGq1aH8S79wYchgb/XIWP4ENF9slHAYTADg1SLBRMrNtfLsp9Q2PhPB0ac4
	/o7XyBUj2X3pAJqAU+q5BsDpYl/nODl0W/BYNTjl4EursxJT/T+a1HOaOMj5Fo6hrSmnKGhMv32
	krxGNlIdNokvZhQf1NPOn3C1fLzJ3BsYSd8i6fhhvDoGriIqufcVX05s7jcJa9MsTm4C+Vu3Rl1
	KqJBx3kMbC9TP0f74xjo8s0CpEsH4/bEImVMA2ULf4mOV66r/D6EPPfEGUNmGhqW0eiXCLs/TS+
	+NcSvnniu4PAAypy802qQd8dkPjWId1OkJbNxS5xTCnjn86ZVzKcWRW4WmfA9wuGiy5aYz6Tphf
	6NxZBDG2w4LMyNFjvImoVbeW+j4uQArHYH1jup0OHucZHTZa6lVGOicJhghufqudzYyTAQ0+8FG
	ZBP+8NBKA+U
X-Received: by 2002:a05:7022:ea47:20b0:143:2719:566e with SMTP id a92af1059eb24-18515a66a98mr13183669c88.42.1792460671660;
        Mon, 19 Oct 2026 18:44:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm37657407c88.0.2026.10.19.18.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:44:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:44:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: zoan37 <agentzoan@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Freddy Hsin <freddy.hsin@mediatek.com>,
	linux-watchdog@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: mtk_wdt: Stop a running watchdog over
 system sleep even if not opened
Message-ID: <c34d9fd1-6fc6-4229-8aad-0377166e5768@roeck-us.net>
References: <20261011013631.1149228-1-agentzoan@gmail.com>
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
In-Reply-To: <20261011013631.1149228-1-agentzoan@gmail.com>

On Sat, Oct 10, 2026 at 09:36:31PM -0400, zoan37 wrote:
> mtk_wdt_suspend() and mtk_wdt_resume() only stop and restart the
> watchdog when it is active, that is, when userspace has opened it.
> 
> But a watchdog that the bootloader left enabled stays enabled at probe,
> marked WDOG_HW_RUNNING, and the watchdog core pings it until userspace
> takes over; that has been the case since
> commit bbece05c0d3a ("watchdog: mtk_wdt: Remove mtk_wdt_stop() in probe()
> to prevent the system freeze and it doesn't reboot by watchdog problem").
> If the system suspends before userspace opens the device, or userspace
> never does, nothing stops the watchdog and nothing pings it while the
> system sleeps, so it resets the system one timeout (31 s by default)
> into the sleep.
> 
> Also stop it on suspend and restart it on resume when it is running in
> hardware, like sp805_wdt does.
> 
> The watchdog core keeps pinging such a watchdog until
> mtk_wdt_suspend() stops it, so it stays fed while tasks are frozen
> before the devices suspend. It may also ping once after resume, before
> mtk_wdt_resume() has started the watchdog again; that only reloads the
> counter of a stopped watchdog, and the watchdog stays powered over
> system sleep (it is what resets the system from s2idle without this
> patch). watchdog_stop_ping_on_suspend() is deliberately not used: it
> stops the pings from PM_SUSPEND_PREPARE on, which would leave a running
> watchdog unfed while tasks are frozen and could reset the system there
> with a short timeout.
> 
> Fixes: bbece05c0d3a ("watchdog: mtk_wdt: Remove mtk_wdt_stop() in probe() to prevent the system freeze and it doesn't reboot by watchdog problem")
> Assisted-by: LLM
> Signed-off-by: zoan37 <agentzoan@gmail.com>

Applied.

Thanks,
Guenter
