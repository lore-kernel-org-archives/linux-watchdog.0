Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ED83ACA4D;
	Wed, 12 Aug 2026 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520993; cv=none; b=FDvZPvPI3cbY63fanGCMh1HdSpXrPsuyo9UCXpvg9Q2RI+fagEmWYncHQkFoirRUSR524Q1CWNOnWTEt/JwVgzLuJyXFQG0V0ydBb5u73oD3jvS8Qn1Dz0wcz3a1kFdmr1h0lMiaieWkAVsE9xAgI1C+N2k4Xs9IbB+YyzCYaos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520993; c=relaxed/simple;
	bh=yCm4OWYvAIrvWR2PYat+IgANSdfvhoGVaszgTjCokoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nLaEKlvTLidNvosGO64kjk+gXRj0QkvANutDw8pQdP1druVNUP5+C1sdPZH3b54n76xBC/9UuutGE5U1I4sE+8QF2S3A0eyDowAZng1Kz7uVBrinjse+fGyTUNBqmePV651UReXdlvd8Mr80+MEEUWSFe75026sugwdpyJl1gtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoH9Salj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoH9Salj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE841F000E9;
	Wed, 12 Aug 2026 07:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786520988;
	bh=yCm4OWYvAIrvWR2PYat+IgANSdfvhoGVaszgTjCokoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MoH9Salji1uBbz/a0hnU9DSSUvMoXVqcW+S4IFKeygIgrH+vgnVG2/t0OswVhKuFS
	 89Ccn0rF4Hl2DLMo+yp8VO0YoCuPP+rgD7UmajRuskd2A377sQgbqlzBx6NNoGNOsO
	 EewlHu954UTjX8O4ysn47rRwh/6UhrLbsfx170UVTWRJ5cABOMuKPMqC4NOBDLcb7z
	 FhdpdxI1NOyTCMt1KX6ir2hleocYnvqyBGeXKyK6BJXNiYnp6+NP4enABC5hj0cNSE
	 /KpFbYmekpm64ReaU2+hq4Djx2BQDvDhsJRt57pFAq6Yn7rxoAY3g/0MuFl93VA+86
	 12TCw8ge+H8uw==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND v4 1/5] dt-bindings: rtc: nxp,pcf85363: add timestamp
 mode config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260812074533.3545058-1-lakshay.piplani@nxp.com>
References: <20260812074533.3545058-1-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 07:49:47 +0000
Message-Id: <20260812074947.CAE841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> NXP PCF85263/PCF85363 provides three timestamp registers (TSR1-TSR3)
> which latch the current time when a selected event occurs. Add a
> vendor specific property, nxp,timestamp-mode, to select the event
> source for each register.
>=20
> Also introduce a new header 'pcf85363-tsr.h' to expose
> macros for timestamp mode fields, improving readability
> of device tree file.
>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812074533.3545=
058-1-lakshay.piplani@nxp.com?part=3D1

