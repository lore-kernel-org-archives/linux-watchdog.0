Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7EC38C406;
	Wed,  9 Sep 2026 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939049; cv=none; b=ZAV74OqT5HkWlM+hv86n89oBxwgUsJyn05oZT2ZVdKpN71T/QUUEX1hc2/JUo7FkFyo8+zBb+q3VqoOpRg4QsWJam1sIQIaqjAPSIUjqO7TzuFS4ZuvuS7olkqWtDmRLTze5wCZYPJ6elZ7l6hJBIzzToXbbA++ho6JfAqi9Flg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939049; c=relaxed/simple;
	bh=Alq5B/Nj5pLMO0xKMyTNj17+T9GtrWdvnWDT/OMaQiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5tKpxpshJLzR90KMDLIFyHV665NWT3XtaADCqcgdHx0R4t8O6Poby53Ffbv8ZDTK80CtUXDBH6ZcwcMZ4IH22+caRser9nMPi2nIP+0Re7yVxyoHAXFvRllk/MnEXMRc23d8mebxGYMozwwXOOVQfKQUCO4IonEEEXTd1WOmII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLMaZVen; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLMaZVen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDC51F00A3D;
	Wed,  9 Sep 2026 07:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788939039;
	bh=FrjvOixqiCFATqeFkPccyskHJoKEDy+lHz7VLzXFwdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jLMaZVencp37Q1r8uUJTA/hlRecDZicUGWymfaHerZW7Q3Jy30jR7nn8Dk/nfwSId
	 Wm2HwOhmq+DK7uTUtJ/KhiIZw/IcXXUtXhY+fE6WQKE7IuSnjV9y6R1mbCJs/MhhHO
	 wiMSNVFj4fx2irXWPk2hvvWDIIfg7hinF2yAfKZABadnsrBSa+qAzb5St4ORzNEKRS
	 wEl7/W7t5Xkx0uBkPVEV27xfjpOxU3W0757hUmMsYPjs2/fHaGU3WB3vasXbryAuQW
	 BbpKftBOW9XZQ4RU6Tc/A3tr+viPY/DeW1fjOqvVTn+mPoynsW96nh9mFBG3YavarH
	 K2uIGllLdIPkA==
Date: Wed, 9 Sep 2026 09:30:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: arm: cpus: Add Apple A18 Pro CPU core
 compatibles
Message-ID: <20260909-camouflaged-weightless-chameleon-caa088@quoll>
References: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
 <20260904-apple-a18-pro-initial-devicetrees-v1-1-0c25401d165d@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904-apple-a18-pro-initial-devicetrees-v1-1-0c25401d165d@cyberchaos.dev>

On Fri, Sep 04, 2026 at 09:49:34PM +0200, Yureka Lilian wrote:
> Add "apple,tahiti-e" and "apple,tahiti-p" compatibles for the A18 Pro
> efficiency and performance CPU cores respectively. As with the M4 cores,
> there is no longer a generational codename, so we assign the core
> compatible based on SoC codename ("Tahiti") plus core type (E-Core /
> P-Core).
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

