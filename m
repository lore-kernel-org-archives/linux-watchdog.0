Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0462F3C37;
	Tue, 15 Sep 2026 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789444072; cv=none; b=j5jfC4FT/OgIztfOF0Vc1tLHZdD/9f9+NmHLvPBWK5Y+vvh75NChDrq9kDXjwL+GHijMKObkmlwotpAX0UGS0D7jBS4/+E97F6my0DmQWga+txseQMo2cG2dIcpcyCtjOdTNKf3vGnasYH4ZV1HuXv6G9xkOD/ewN2IjZ2/5yHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789444072; c=relaxed/simple;
	bh=OO2eNvfwY785evguiytJlEspSt95q3VV3ctDfVSI5mQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UffRmmEdBJzsIEjWYYdQtZCp+DVmd0aUCSXuy+sd8tcEYgtWyZNTlPVuNIZ8Y+pc9/g6vFy+WgEaTR0bub3N32VqbBK8zYLlGxd7liXG1b5I/yoaCRXJg7FI548pX8JErRNrip5fjvJqbsphPh63olMOiYAlpDff+WYSy4Z6mg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du4gRsV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du4gRsV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28081F000FF;
	Tue, 15 Sep 2026 03:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789444070;
	bh=OO2eNvfwY785evguiytJlEspSt95q3VV3ctDfVSI5mQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Du4gRsV2Oq24oDUlmeFnXv43zBKOEHr7zjM1zJCPqN1p5ViC8GGuB4qNfCcx6Odxw
	 CLkM+6xUNsBA8DpXqGkA0Fc04Gdz+dRmUeygpc5I+Mt76iGlBYUQkL++8X6rz3RrBK
	 scDa6v9vvUqoi3GN/qGLMZqJ76nceg7XwhNog7PSJGyFLIdmKhexKaJPGdhYY14Hy1
	 pUbDyhs87Pmk3OuemjrTWuAP6vieUor+K0AFKYQRVpnbYGlzWbwrbbuT+xvxVht9af
	 w3tOcnKaY5QVrAJ6R7oZ/BnzKmn5kx2tccbzTmBwqb1pBfUvS7f634Y8KaXXLCDYd9
	 ZZhkGXLyoQ+mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/5] dt-bindings: rtc: nxp,pcf85363: add timestamp
 mode config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-watchdog@vger.kernel.org
In-Reply-To: <20260915034452.4086683-1-lakshay.piplani@nxp.com>
References: <20260915034452.4086683-1-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:47:49 +0000
Message-Id: <20260915034749.E28081F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915034452.4086=
683-1-lakshay.piplani@nxp.com?part=3D1

