Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB01424668;
	Mon, 14 Sep 2026 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378024; cv=none; b=AEb7YyVkykaCrmq6cWXmexveWT2jHb+T/13gQLRyvhYUyZJSTdILXQeyFoepN79/jMr693EDN4IBfuH8LGmBeodX7gg7uAI3ZWjaB3l8H3aPQAPVwLaI/hTsy3B2/WLIv/uw2rCZcgwbJJJ9BsEQu8avY/2PTX/n9Af4C1sWjrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378024; c=relaxed/simple;
	bh=0CMNRLGhYd35hQOF7rUzgK/0pqL+U4Okl+pTHhBMXqE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XtYXjA4khuJWVWqXa1akrutduiMXn0/th/d5X6MUmpxR+oUyRNJCA+tlEzlC1VGOWxMdPDzJcQ1migeLtnDAu3YAbYlWjwYgm37YDMTtoZdYayL7tE0NnVk2TdMHYe3V7iVIzFxuOe4I71fwRC5d8s84ZdsWY2fEPymhbDhkLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAh0pf1w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAh0pf1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2631F000FF;
	Mon, 14 Sep 2026 09:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378017;
	bh=0CMNRLGhYd35hQOF7rUzgK/0pqL+U4Okl+pTHhBMXqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iAh0pf1w54isw0PuBqRvT13cb9eOH93K86NlCgXvrw3lZVqQae3ljOcubLul2XavK
	 R/XfEFG6PRLQtDiuKQOCMTRovQjXk9rvqgHcvLv0/WEVlrLGlMDAWCQyrLstLYqeNq
	 6Ti9OoGRaEJho9hw65lt2T/PHmENip5k0A0kCMH44IjBHwxrI+OK9B4bi1l0uvIh/b
	 zOyL0qLZB2climwMOL1CJygC2yrYvcWizJwWrSk5jUAx3cYaVWb8rGgcjcQpBjVot/
	 5ZQZH1y6VAcPlz56qyezmvwxoVcExAJKwgBFwAQlEXxQNgWkPkGDC6QbIoDo137L+s
	 ANPqG0xEi7mqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] rtc: pcf85363: add oscillator offset calibration
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260914092126.3757418-4-lakshay.piplani@nxp.com>
References: <20260914092126.3757418-1-lakshay.piplani@nxp.com>
 <20260914092126.3757418-4-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:26:57 +0000
Message-Id: <20260914092657.6E2631F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> Expose the oscillator offset register of PCF85263/PCF85363 through the
> read_offset and set_offset rtc_class_ops callbacks, so userspace can
> apply frequency correction for drift compensation.
>=20
> The offset is in parts per billion (ppb). CTRL_OFFSET is a signed 8-bit
> step count whose size depends on the OFFM bit: 2170 ppb/step normal and
> 2034.5 ppb/step fast, the latter computed with an x10-scaled constant to
> keep the arithmetic integer. Values are range-checked before that scaling
> so the multiply cannot overflow, and out-of-range values are rejected
> with -ERANGE rather than clamped.
>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914092126.3757=
418-1-lakshay.piplani@nxp.com?part=3D4

