Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C2A426D37;
	Tue, 15 Sep 2026 03:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789444435; cv=none; b=l6YJX22+Q3CMCGbcQLMLVAWCGVdDFtT9XSqUp5RRmZ70UJGbX/DU+ogob63y3GqaytDleMLNKoF4VFyM4vMfm+fmcW98sTkQU3L8OwDhSOMEp4FTrAmBkgdmMy5/nFUbnu8vwhO4BCCyBJ/yjpTKLOTBa3xrJv3Sm3HAINCE6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789444435; c=relaxed/simple;
	bh=6Pv+wza7B2e9peca7dOSI82886wtH21W4p3KXt64ALI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dZigJwVDfGBV5XXIVH13dsKXZBo0ygUs+DzXGBJlTO8irvslKrVg0jdF6SqVosEsvV/4XoJRTNlXAFJLrvZ9NCDw5a/TPHhTP9w6ANst6bsDFqikZ2iB6i+xLM4I9Tkq+uYb7w49aGrXwBRqgNzRK0ksODWv3ZSC3WGNKaNgbFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm3HVeg8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tm3HVeg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B941F000FF;
	Tue, 15 Sep 2026 03:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789444434;
	bh=6Pv+wza7B2e9peca7dOSI82886wtH21W4p3KXt64ALI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tm3HVeg8yzzzqTbVwF8Xzrv4XBSl5XaTAARZdlwXyxEizQENnlJQA3H0wrR+yGeE3
	 77HyFJ8+JxKv8iAlecJ57xJo5ps8brAdXzmZHJx8dVil13Lll+7QAuhjSapr6gfoc8
	 9OgG3H+Fqt+5a5LgpPLBI4iyH9ppi9+hcXLPBUOLX/9k1VjA3Ib4h5q+g0RRPbTAhe
	 f8LbrBBZ1xVnkaek4JuSJ9NN5Tx07Ki0exxLZJnwJSHkHswXah/Lbu7ZaOZlVWaV5U
	 WxCkNPf9LA7sQbGOr6YebK+9KmiOJ4MzAuEEpuUiUwVInQvT4V8/fwa2e8LaRVUTyR
	 T44UaYMeCPqRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/5] rtc: pcf85363: support reporting battery
 switch-over via RTC_VL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260915034452.4086683-2-lakshay.piplani@nxp.com>
References: <20260915034452.4086683-1-lakshay.piplani@nxp.com>
 <20260915034452.4086683-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:53:53 +0000
Message-Id: <20260915035353.A1B941F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915034452.4086=
683-1-lakshay.piplani@nxp.com?part=3D2

