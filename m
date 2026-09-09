Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D363D524E;
	Wed,  9 Sep 2026 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939124; cv=none; b=o6zeIAjsJxxQ4k6uzcD6Xdte42fhQrL4QmPQj3q3vb+RtHWL3HsB5Jmb9weJKMEInR0YcDZGg6P4h42kMHwq8Wg2OYUT86HUc7DgxzTKm0mb8N3WQdGNkayJQcxeSBgAnRZMi5YaHEvd/r5ENi/JuyYhO3SD5ThJlmc0QeihEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939124; c=relaxed/simple;
	bh=yOSB4sO0Zycb9mmGq6bI8hil6oa01NqvlqVqX3oTykQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTYRlBD4n3HC3jyv/Qs15+8w3mIGPt2yKFi54bW5Tsi7GhMi/JihBn9Y6r/h728UD6q9ujTYHslEmtUZSXluCIqn44sMD9KwnvAbKX9FM1DtVmSv2fHcDD/qJ9eHIWnz2Zid0drRAKvwfRL6d6TVCDG0quRRSs6l5bf+hjmQJqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeKxFVIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeKxFVIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F52A1F00A3A;
	Wed,  9 Sep 2026 07:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788939121;
	bh=1vSmlUZNoD842yAgOOnJ5dfY6tdwXPa3MRt5dvciHVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VeKxFVIt+DF7mFO51IB+xdzSa94T+4yM7OeehXzAJyo8fuJZ6GgWa8sEdHGA/owkR
	 12LZipugyJTsnbISBrT+I2JNoUiiGlBdFBzX6oSy3lpV/dJxvE/EsLHQ8m9gT3vR2z
	 M8XXTVoAUd9Ef/cAaaS4BMHfCOIvIQSMPWFDoAkZilwALLFRM5Bzd67pbHblOLwSzr
	 u6MNpSijUQ2TVQ56gPlmczPuE8IgBIY7nEmgPMjH6alefnlep2UZy9RoxVhssOR6h1
	 ip3qZyPEascUmGAM4KXOPpBg6p0EXmtLdBB3UH12YiQ3ct2RTUpPFevmUQwfz9g9V5
	 Q2VmSm/1ZCc6A==
Date: Wed, 9 Sep 2026 09:31:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Yureka Lilian <yureka@cyberchaos.dev>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: interrupt-controller: apple,aic2: Add
 apple,t8140 compatible
Message-ID: <20260909-advanced-marble-lorikeet-eebeef@quoll>
References: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
 <20260904-apple-a18-pro-initial-devicetrees-v1-4-0c25401d165d@cyberchaos.dev>
 <4e65ef39-cf1b-49d4-a899-da36acb442c2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4e65ef39-cf1b-49d4-a899-da36acb442c2@gmail.com>

On Sat, Sep 05, 2026 at 04:25:36PM +0800, Nick Chan wrote:
>=20
> Yureka Lilian =E6=96=BC 2026/9/5 =E5=87=8C=E6=99=A83:49 =E5=AF=AB=E9=81=
=93:
> > The Apple t8140 (A18 Pro) SoC uses an AIC3 as interrupt controller, sam=
e as
> > the M1-M4 SoCs.
> >
> > Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> > ---
> >  Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml=
 | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/app=
le,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple=
,aic2.yaml
> > index 1cb886785173..e3cadc5ad39d 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2=
=2Eyaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2=
=2Eyaml
> > @@ -46,6 +46,7 @@ properties:
> >                - apple,t6030-aic3
> >                - apple,t6031-aic3
> >                - apple,t8132-aic3
> > +              - apple,t8140-aic3
>=20
> the title should be "... Add t8140 compatible" describing the hardware co=
rresponding
> to the added compatible since the compatible being added is not "apple,t8=
140".

Commit msg is correct, it does exactly what you wrote, no?

>=20
> (Alternatively, if you mention the compatible in title, say "...Add apple=
,t8140-aic3" as
> "compatible" is already implied)

That would be repeating diff, so not really helpful.

Best regards,
Krzysztof

