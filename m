Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19603C5553;
	Tue,  7 Apr 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578018; cv=none; b=cjTEpoPBCMNKedjfUZOLkNwbe6pbJvdw1Ft7Q8AP9bCgcVyIprEtmgvaYxKV1RgyJo0iyyJK9aKUkEhU8kdTkKxm/N3d/sItE0+06xhEw/rKA/3FpDhfKfKD/hV6bC0LsFVEpKOwnzq6G0TiELXFPp0Sut6JQLmsGvEGlZqqe20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578018; c=relaxed/simple;
	bh=mvUZweDlyjvVe2JcQ7USWDAKAd3S21Moj2GrvsWKB38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzUF9PujvpZ23APqZ6s8HU/bE1251a4SPhX0ZzTAoJDgetUrGs1+z6XBQ6HPvltHdYv/iMfRnN7F8mf9c354wjLuhqw8FttxYYR9SWgo1Jbh9OsJU9YK+++6Bpm0IQ4lk6qyIIrCa3ujC2ZKDX5k8kze4eacWmZBZbWUm+dcgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvODB8vM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvODB8vM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED684C116C6;
	Tue,  7 Apr 2026 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775578017;
	bh=mvUZweDlyjvVe2JcQ7USWDAKAd3S21Moj2GrvsWKB38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvODB8vMZ5cfQpNdKcqYNH3puirStHN6PvyBPN88TgoVecbiRqavcSW1iqxI88Y+q
	 SJ9h/lfh3KVXzK+LFyR8ty9DAkTf+9KMcxPrIKRfT/3awJ6TNbGUJ+DkqgpG76281s
	 L36pFGImM7Gd3O3KXW1Zi63bnjzYArWhtv9B4jp3o5LoAhJWiQTC0OCTdktl8E4Tmi
	 ORZSHVbKXqsixEWVJS+pP4G0Fa69jQzLD8O+Ujqt56v+TGswKHGdGg1FX7vgUe4SoH
	 eQGDYart+SOYLEYKY+C2RyzvwJMRNM13OdSO+cMBIOZAM02hVvsCLrn7BcrVEORoMn
	 hQ0dPeRNu3uoQ==
Date: Tue, 7 Apr 2026 11:06:55 -0500
From: Rob Herring <robh@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: arm: cpus: Add Apple M3 CPU core
 compatibles
Message-ID: <20260407160655.GA2643629-robh@kernel.org>
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-1-5842e1e393a8@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-1-5842e1e393a8@jannau.net>

On Fri, Mar 20, 2026 at 01:23:19PM +0100, Janne Grunau wrote:
> Add "apple,everest" compatible for the M3 performance core and
> "apple,sawtooth" for the M3 efficiency CPU core. These CPU cores are
> found on Apple Silicon SoCs M3 and M3 Pro, Max and Ultra.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Rob
