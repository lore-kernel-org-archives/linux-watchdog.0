Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096FF2FFF90
	for <linux-watchdog@vger.kernel.org>; Sun, 10 May 2026 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778441007; cv=none; b=ivQ0SLY3PWJ5biVE9FskhdUZuKVDmTuN4y5YxglSw6byxQ519elnPiQLbPkoVArFTinfJB3XZvP6f9jKe3xjEPAgivtMY8MWFOoqvgcH5ZlF+E58M5LThw3AoyWaRUZKUutqkVAPlNeqKYCMd10k38f0YFL95ciAPja7YqdHOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778441007; c=relaxed/simple;
	bh=7h7VEb1IQalYk3uf8LvceW/ggx/Bm2wE13XAeEQw3aU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HIaD67OTVGg2CFhmXt9o09ZeqBl16WVRh2FUhSMKF2CeoT+HPsdKW1NotdrZBvQOcgJ/EzIVhvgTpU3QEwczOrPAGl9j0hVTehfXeXlmAop1FhGsCnKlOJDFy0mZCQpR5H5x+8xovELNoQehBAJEN3miPJWcKD0bpCBOF6kzZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=8NpTHEeY; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="8NpTHEeY"
Received: from [IPv6:2a02:1812:162d:3d00:649f:659d:f6c1:d42] (2a02-1812-162d-3d00-649f-659d-f6c1-d42.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:649f:659d:f6c1:d42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 3DA5F77CC34;
	Sun, 10 May 2026 21:23:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1778441004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7h7VEb1IQalYk3uf8LvceW/ggx/Bm2wE13XAeEQw3aU=;
	b=8NpTHEeY2o4dBpEVcqUq8ICJgutuH6yyoDsCIy7TzOgZZv4AfISsxBrao5+7qh80XOljiz
	vqWjXgy/udziPzgiAtYpnmC8A+W8fMp2NhZXmSM85pl0BPt9ss7c8sbb/nXM/hopzQQ1mQ
	IlWPFj//DI/zlQBNCrqIc64mS9Qzof6DRaJH/z1zwghqW8xpYWuWlrNLtFK6XWhn2TsBDw
	kuBr8AQnDmV8v3cUvJ3+xyJBo8MrPvWyC1GMVTlUgfZq79fY2mt/D2iqzmrX7Bag63UKiy
	sNusMvDQHDSBu6PqTdkKIVV0Ejm7t4xosruriYkltWc8584kQkCt+S5ozGlS/A==
Message-ID: <a6d6f58a09aa3e787f3f24406b76aa5a5b6f8200.camel@svanheule.net>
Subject: Re: [PATCH 2/3] dt-bindings: watchdog: realtek,otto-wdt: add
 compatible for RTL9607C
From: Sander Vanheule <sander@svanheule.net>
To: Conor Dooley <conor@kernel.org>, Rustam Adilov <adilov@disroot.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
	 <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 10 May 2026 21:23:23 +0200
In-Reply-To: <20260509-rebuild-snowboard-e82a3adc5a27@spud>
References: <20260509163101.722793-1-adilov@disroot.org>
	 <20260509163101.722793-3-adilov@disroot.org>
	 <20260509-rebuild-snowboard-e82a3adc5a27@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Sat, 2026-05-09 at 19:13 +0100, Conor Dooley wrote:
> On Sat, May 09, 2026 at 09:31:00PM +0500, Rustam Adilov wrote:
> > Add the realtek,rtl9607-wdt compatible to the Realtek Otto watchdog
> > binding.
> >=20
> > Signed-off-by: Rustam Adilov <adilov@disroot.org>
> > ---
> > =C2=A0Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml =
| 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/watchdog/realtek,otto-
> > wdt.yaml b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.=
yaml
> > index 1f5390a67cdb..ac9db40b12dc 100644
> > --- a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> > @@ -30,6 +30,7 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - realtek,rtl8390-wdt
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - realtek,rtl9300-wdt
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - realtek,rtl9310-wdt
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - realtek,rtl9607-wdt
>=20
> Please explain in your commit message why this new device is not
> compatible with the existing ones, particularly given the driver patch
> implies that it would be.
> pw-bot: changes-requested

Back when I originally wrote this driver, device-specific compatibles were
encouraged "just in case" the hardware would turn out to behave differently=
.
Has this changed to minimizing the number of compatibles?

FWIW this platform's GPIO driver does have both SoC-specific compatibles an=
d a
fallback, but for reasons lost to time this binding has no fallback. I'll s=
ubmit
a patch to add a fallback for this binding too.


Best,
Sander
