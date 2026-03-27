Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F03EF65B;
	Fri, 27 Mar 2026 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620907; cv=none; b=FjSw5YY7ANruIRZhNF7yCybhsQHfyC9RfedrCsnvYAjpZ+7kl8K8Lo0Znh2grOJEr84bD+Qm9uFQgxvi7KEeA4DsZmssjyoC1Rq/g/lv5VYwaN5pjnFqHVJ7EDGUwk1pnt0M9+QcguyeZvQ52R5hx2BwOs1L4YEkVU4wPhhLqhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620907; c=relaxed/simple;
	bh=mDiN3CwDrGxYxvIHxSISwYWQtGmSr6sfXYIrXdbxyiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1uFsRmG3yKK3F2waB4pMHOXyZE/+5fHwAlN0SS7bzCyvscknet8KI9zp7XGo5tPqcSWyG8/6U0lfoIzWyXDLLu//eDzfAW2Cpr+zG9rTNYZmAbPzXMosca0HOJaICYv6H31w5eLFyGT1czq0Mm+s2ngqLXOswc7jORjpD0EwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTf8wCOK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTf8wCOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1671BC2BC87;
	Fri, 27 Mar 2026 14:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774620907;
	bh=mDiN3CwDrGxYxvIHxSISwYWQtGmSr6sfXYIrXdbxyiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTf8wCOK6X4yKAzSc2f24WMygbSUxlO57UzYhNphUBfRxXyppdBQZPlCUkxVBdrOH
	 Uz7Fy6/0e/piqICij9fRz59LwPCoxO2IYxFt44MX1kOvlyXOAyWVSIgVYoaEjuqxvB
	 YzBs49DByqBIFT7nak/Z27n61HyH242rT17TM6XQT9J9wKU4KIqZ1aTnNwf6CG0Qix
	 pFPU+3LblCGigprhujlOD6nTqkJNOauA70GNtaJ/yMa65pqG0tlyxT0zRi7ohsCnli
	 SIBsi0U3OQMzFx1cCKCEA6wKSgDde+8q71TS+q4Wb6NZXBw6V126ULtEalLyTs2lFc
	 PJhb2lAF9csyQ==
Date: Fri, 27 Mar 2026 15:15:02 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Linus Walleij <linusw@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Sasha Finkelstein <fnkl.kernel@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 6/9] dt-bindings: i2c: apple,i2c: Add t8122 compatible
Message-ID: <acaQ0tDphJH1OPH8@zenone.zhora.eu>
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-6-5842e1e393a8@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-6-5842e1e393a8@jannau.net>

Hi Janne,

On Fri, Mar 20, 2026 at 01:23:24PM +0100, Janne Grunau wrote:
> The i2c block on the Apple silicon t8122 (M3) SoC is compatible with the
> existing driver. Add "apple,t8122-i2c" as SoC specific compatible under
> "apple,t8103-i2c" used by the deriver.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
