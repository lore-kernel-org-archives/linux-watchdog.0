Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A536196A;
	Thu, 10 Sep 2026 05:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017473; cv=none; b=WJpJlrpsAsjVJ6V6mihIDxERkWyC9LNDD0FfGUe7RbYXo+aOfv8ge9UT5DUJCblXAYirAyJ8F4REcBJuxATY4l+dN3NJeFPsYFuRWb3SYvqkEdwGg1oojRhvrGwHPeN9KsWe77W1fVXNdFdH9YEbdNLNQvsKA746LtL3WFXH9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017473; c=relaxed/simple;
	bh=MGSxJLJTBeEeAVukrnV6E9crvGfITIHgmbgn2NS9BmA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eEJ09blECtpvS2CVBpvPTyo/3hXHwBZTNKoxUZhUhPg/u6ZK5atIoDfxVa2ZacJORzDxQCEsdVCb9WJxXSCBqX42++9QKhfScJxpGQ1E6xAIdWPOeWR47dGQGDk1e2TOksICHL5eqM/OhcPfqs68f/ri5T+Vm9fw2yReqtCMQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyM9ijqC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyM9ijqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEB01F000FF;
	Thu, 10 Sep 2026 05:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789017472;
	bh=MGSxJLJTBeEeAVukrnV6E9crvGfITIHgmbgn2NS9BmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RyM9ijqCYlwhKmAs9g/hNINWhbf7Sm2VI08G9stwhBXQ1vIV5H2jfTFtabwtx37HN
	 DVKXTKeiRvovga4JCYDwvnYMQJdUFdJwvt0zci1H3DRY+CRwD7LAvFkQFqT1Q8d6MN
	 COpw+hK/id2Jlv6kZ79orXekDi0wCn9u+f2vNbA3DNXzvpSw5SF2SvU6YLN/vJUOlf
	 P6eSIdJQZmzn4t1qoiPKej2IYFrvgMGZpp/KxWrxJYC9k0Qn1S6VJKtE7eKr7GCP8H
	 hWvBriBkDmZ1bNS0emwh0nV73iE0hm2/Bp0EsGtDTYBbAE6CmBJR/gJmEG8wF8fsO4
	 NFY6AeHHwMF0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] rtc: pcf85363: support reporting battery
 switch-over via RTC_VL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260910050747.1901440-2-lakshay.piplani@nxp.com>
References: <20260910050747.1901440-1-lakshay.piplani@nxp.com>
 <20260910050747.1901440-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 05:17:51 +0000
Message-Id: <20260910051752.0CEB01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> Report battery switch-over on PCF85263/PCF85363 through the standard
> RTC_VL_* ioctls: RTC_VL_READ exposes the BSF flag and RTC_VL_CLR clears
> it. The flag is cached before it is cleared so it survives re-arming, and
> it is collected from both the IRQ handler and RTC_VL_READ so poll-only
> setups still see it.
>=20
> CTRL_FLAGS is write-0-to-clear, so a read-modify-write can drop an
> unrelated flag. Add pcf85363_clear_flags(), which writes the complement
> of the mask to clear only the requested bits.
>=20
> Probe no longer blanket-clears CTRL_FLAGS, so pre-existing events are
> preserved. As the battery-backed registers can hold stale flags across a
> power cycle and storm the level-triggered INTA line, probe masks off only
> the interrupt sources and Alarm2 enables this driver never services and
> clears their flags, and the IRQ handler clears any unserviced A2F/PIF
> flags.
>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910050747.1901=
440-1-lakshay.piplani@nxp.com?part=3D2

