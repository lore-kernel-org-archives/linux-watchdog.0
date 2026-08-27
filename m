Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EBC439F7E;
	Thu, 27 Aug 2026 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823373; cv=none; b=BnjeMh9rtjKFjOsSZjDGsKH3+8i6Kds02v2LgkvgwPOPvfb58MH+naUgiyiJxApgIRsDwsHlY41DkhbhY9o8uL7VY0Aqkl/mFiUVGqkS2gsRVnXvcv8F1nyiBLz2Ti3s2fjRReAs0SZU6iPYmyKReLLaNP2Z2M7e0u18mJ19Vw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823373; c=relaxed/simple;
	bh=MYAbY7veJuyIvFEyIF8vAmK3/E+0P+eqbEQlLJWpOAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REECQ+QvnkqgEriWOKJ2cHVi4w7EM3QhROOFi0YW+G1DHW61YfOgeNiM1qlG/uBfacGNixL7YDs58f16rXH1wmMzCQtgxHpyCNMdt95vrbPdyhPXHsSG8jdvwseCmwa5OexdA88SpZdnFrZnQzgw8Q1zFgbBUxg/NYFxswnQTNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elEcMd2K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elEcMd2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8891F000E9;
	Thu, 27 Aug 2026 09:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787823368;
	bh=aaeVZUhJhsnBFWMdkw+zxAnz4qf4NB+2fch1KyGaEpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=elEcMd2KDDVwQhq3IrxC0ZuRb9j0i21rsxew5aE/SouSM630XfMX4XAc0DG3fmL8/
	 LmXVCgFuf7hV5sIcHgFQBpqBupnYxopwbe6bt38GN/00a+68IXBLQhLiE7bJKff3JV
	 C3CrderGwCshfuYpx85Y2UBMpMmDMX72d28be9omSp5iapATnmkiMYtnl1/9FKtdkK
	 poY2/l+5JVlFGHbnUBpqGydykoAa+i6749uEv0PLhgZ54SD4uBS7ZheVZcx0W0Q9I0
	 xzQr5uHejR8298W0c17Clst3uRgSUnS+zZPdULp5T5BjEyzbPBPpXPeCIqIdDR2CD5
	 pGPk4ZrgkTElQ==
Date: Thu, 27 Aug 2026 11:36:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/7] dt-bindings: reset: Add mt6589 toprgu reset IDs
Message-ID: <20260827-rousing-emu-of-drama-dee69e@quoll>
References: <20260819101853.44681-1-l.scorcia@gmail.com>
 <20260819101853.44681-2-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260819101853.44681-2-l.scorcia@gmail.com>

On Wed, Aug 19, 2026 at 12:16:22PM +0200, Luca Leonardo Scorcia wrote:
> +#define MT6589_TOPRGU_PWRAP_SPI_CTL_RST		11

> +#define MT6589_TOPRGU_SW_RST_NUM		12

Not really a binding, drop

> +
> +#endif  /* _DT_BINDINGS_RESET_MEDIATEK_MT6589_WDT_H_ */
> -- 
> 2.43.0
> 
