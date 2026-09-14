Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84A741C30F;
	Mon, 14 Sep 2026 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378343; cv=none; b=lS3jxoDnu9JalUF++/V+J82KMtw/tECMAbMmOWZf4H2orE8mz2dphLbEvq7BgwfPguU9T72EWIFgkM44Woz0Y0lsC1pPU0i9uMe8hyTuwOM3UexwwR0jHrdzK7NfCUzIZjREHBmUTyG5/jHhbsiFbAMArc1Z9AwlowN3aspCi0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378343; c=relaxed/simple;
	bh=MxDvtdUVWriv0VZe3rd8xfPLmcRfbp4Ne1W3f0fRYOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ukeo4Z6Gt4Xk5Cj8Lh+FKngryJy0qL+9+wp6xgBb9bv7KFhQkXQbDRpE1dfFh80915ANDAUU2Ik3ONAtteia6bg/DstRW28L/XLnxLYJWCjd84mkyOmdw+TF2cfUD63xMo7TJAoXghV55+zn0scjymsMGRPG9zC7swtETPvi5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMamxRva; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMamxRva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753661F00898;
	Mon, 14 Sep 2026 09:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378341;
	bh=MxDvtdUVWriv0VZe3rd8xfPLmcRfbp4Ne1W3f0fRYOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VMamxRvaVTNVUF7QhnhtIQKlQC1nlc1Q69Xe8PeBo3mIHuY2Vgjfck4ct42skxvRo
	 VY3BjzbSCW8rSW0okDJpGuKjwJmxk0ZtGrhUEUJspdVqODsSkss7JSsgrgLiE/dtID
	 I4rWbHiOa/0kEU4R4W0xydF48fbi7/kzTrARrJsIDWyWyGCgWdWrJJqMMGos8Ejc53
	 Rcb6W+e58bt911hnYEQYkyGF7kdxzl/7w1HnXPDcTBHSxoMzrHe53N51e+K72kw0DY
	 R3j+7h8/k0RDj65/6W885Og3F4+qQ/4ptJj1fCAGUaBw/4DQBbbsqWcBz5ViEqyRkp
	 2DHHUx5ZswjwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] rtc: pcf85363: support reporting battery
 switch-over via RTC_VL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260914092126.3757418-2-lakshay.piplani@nxp.com>
References: <20260914092126.3757418-1-lakshay.piplani@nxp.com>
 <20260914092126.3757418-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:32:21 +0000
Message-Id: <20260914093221.753661F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914092126.3757=
418-1-lakshay.piplani@nxp.com?part=3D2

