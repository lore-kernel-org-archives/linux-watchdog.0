Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380642254A;
	Mon, 14 Sep 2026 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377925; cv=none; b=XwaXLhmG9t9Pr/Qjx903CDbInGQ4xT1UQ5EVIe5Xaz85oEfM+Lc5BZBkcptO8yOKTmy5RmtcbFs9C30AxtfaEj75UcA67YAi/CV7/TAnA2oHO/C0YYPWvMpkvPQW1OXBmpp+7OBwmgwkZb6XvfwRDNzX1qa8ytXB2hqpxlKkeJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377925; c=relaxed/simple;
	bh=4G2NVXv6SlBDy0bCSAgPf+ahZD9eOdtgxH7/fF46vg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LhiKsGgdJq3wRnh2ovP2X7CEGEDIxNurBVOOlkmFVtPUbfvpUu9hoRa9csa7rUUlnC6xKUi1VUizWesSigVQCBM3c4eh+ADulGF7ZXV5AdBPn+uEx9CuiqpmWKjxVx3wFaxD/NHpnEQRZavtlWnLWT3ltZnUtkbpCKrnH+WpcRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6M3voQc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6M3voQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C9B1F000FF;
	Mon, 14 Sep 2026 09:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789377924;
	bh=4G2NVXv6SlBDy0bCSAgPf+ahZD9eOdtgxH7/fF46vg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T6M3voQc7IM2fb5Gy+zouPiN1+Mip8eG+1DULv22zSOLSaTqakktu+LjUARFu2oc/
	 qt+0nkThnm2pBuaOFiCT86vbre4Ksj0zdEgcbbT6BEMCbr2PhCiEDUnDNUQ9+JvNsY
	 UQ9w2sbLKhqww4IgFxeSAdlvlt5l5bwtruG9CVvAnfIKeCqKBWDtXvUrFK+5ZxAZ4I
	 sqnYR5tj5JAXDKyTCjzqzmViNuNvv+bJ5Lz/ykJSov/oH4QPiSvFNh570WEQC8nNMh
	 UGQdkyZvMzpSUwIAnPxw2J3CvW7KmPFk61hygeSZAmA4XqeqbzIzZMe6NB7Nz2RVVR
	 zAMoMWIcbCLaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] dt-bindings: rtc: nxp,pcf85363: add timestamp
 mode config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260914092126.3757418-1-lakshay.piplani@nxp.com>
References: <20260914092126.3757418-1-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:25:23 +0000
Message-Id: <20260914092524.03C9B1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914092126.3757=
418-1-lakshay.piplani@nxp.com?part=3D1

