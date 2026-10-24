Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792867595;
	b=AiWw9PREYHFKZUikPFFqXBcl5gflv0xBJCknQ9g4FbZn4l3NiEMua3p8C+wS1SQhVDTN
	 1X2XgZJGEdtYTvU61w6juwXXHaacFAVKzwgOM3skYrAQfdZhI7o86+TwVTQqu6exYelIP
	 lWtXgJEcBmaJvNrvDbrUR+dw2nhSTsEs3pXXVNopTZGvgYcl9eZGHsdZ01bq/Gu3QbKog
	 5lRL6AloIgtC2+xz8I+t7RiWQHtSiXrU0GtQCSWsdJw8fciCDvOQ94PDKe0b6etaWXKE7
	 gAJCaETtbVrbj4ZpmWRMnp7QXN+wMGg3qOP9uhy8lMK13zUo3D622p4Y6Njv3LPre9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792867595;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MnrQ55dyeMSwGwNReeOBPj4JjDJpMy1sTzm2Nuwa9vc=;
	b=2xj4ESdmO34QAO+k6NomPGF++wW8g4ZZO0voUyEYxAy40nBl3OXNXghLiRK4YJNJM0Tw
	 0Ks1PZjvh8vr6go8oM5e9Qu5W8gxD7R4c5aQTeZO2aOiDYXwUClgKfntnLIPNVHzyGi3d
	 iU81gr6LmAvj53Cx3QdDx6QeIs2EBw5HnbnLRPv/6nOfar65ci1XXVU+d7LR7BfxqauQI
	 l52wi2ERwckrV7ZX2VMZ5Ps2Zz5IeFonihFaS7K5r2vI+VDB8VSae+a26OJSusSPh95yC
	 SYEZCvdQvGBChykW3n3K3758PdtTGEHiQ1jZ4XNVQ3k73Q2EweHb5ddHlZxvt1tZEHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=HSYR8zaP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92333606A31B;
	Sat, 24 Oct 2026 18:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92333606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=HSYR8zaP
ARC-Seal: i=1; a=rsa-sha256; t=1792867546; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HMGKB+tQQA0SUzq/7fIY2rMaXUkIHQnMuNtypWS40CnW9W0EbRFYNA4rQOgpo/7ApgcieY5rLDEbU6JTtgiaapjVgrHb/L639wWlUMTAbZLo0cV3wxJXJVklSsZBKaEDiSpvs6ZgFcQS0jKDtWqTAuggELF3NoMFzxVVdEalya0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1792867546; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MnrQ55dyeMSwGwNReeOBPj4JjDJpMy1sTzm2Nuwa9vc=; 
	b=eHTBdEgl3aH8rhyTOVvvBR+3b2em1krWG6BN3z5H3+F18u622PDXfV9QDC55d9jbspTfMigNBKkoAn506lIA3VqDDCcLB4lK5oNwxJpPNerrXusybtm3BhkNSvNJjQP12aMbAsK3W+0usBdduDKKIaqcF8BBBCrFqhMh8JBSWc4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792867546;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MnrQ55dyeMSwGwNReeOBPj4JjDJpMy1sTzm2Nuwa9vc=;
	b=HSYR8zaPo5cI7PAYG/5oMroV+utChHPYR/p+FsssRjfBf4e+G7qcFdxv+R8SwI4k
	1tL1fiPSTbwXBxEYdOnSouEcvDP9V5ur5aUgQ2r/a3kstTtQyEVKFsja6TPzpD5beEZ
	4Jzuna2bajfZtT1JdjBCkfShJRdopCZx1LqDrCv8=
Received: by smtp.zoho.eu with SMTPS id 1792867544042885.6437458142384;
	Sat, 24 Oct 2026 20:45:44 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, p.zabel@pengutronix.de, Sergey.Semin@baikalelectronics.ru, mika.westerberg@linux.intel.com, andi.shyti@kernel.org, Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH v4 2/2] watchdog: dw_wdt: manage reset line during system suspend/resume
Date: Sat, 24 Oct 2026 21:50:00 +0300
In-Reply-To: <20261024140854.25664-3-a.shimko.dev@gmail.com>
References: <20261024140854.25664-1-a.shimko.dev@gmail.com> <20261024140854.25664-3-a.shimko.dev@gmail.com>
Message-ID: <20261024-dw-wdt-shimko-v4-resume-imbalance@iav.lv>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sat, Oct 24, 2026 at 05:08:51PM +0300, Artem Shimko wrote:
>  	err = clk_prepare_enable(dw_wdt->pclk);
> -	if (err) {
> -		clk_disable_unprepare(dw_wdt->clk);
> -		return err;
> -	}
> +	if (err)
> +		goto unprepare_clk;
> +
> +	err = reset_control_deassert(dw_wdt->rst);
> +	if (err)
> +		goto unprepare_pclk;

If clk_prepare_enable() fails in dw_wdt_resume(), we return with the reset
still asserted. The _deasserted devres then asserts it once more at unbind,
and on a shared control with deassert_count already at 0 that is a WARN_ON
and -EINVAL; the next suspend hits the same. Deasserting before the clocks
are enabled (or on the error paths) keeps every exit balanced.
Not tested on hardware: I can't make the clock enable fail.

v4 re-tested on ROCK Pi 4A (RK3399, resets = <&cru SRST_P_WDT0> added
locally): watchdog daemon at 60 s, 6 x s2idle for 90 s without a reset;
killing the daemon without magic close resets the board.
