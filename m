Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C1F3BF68D;
	Mon, 21 Sep 2026 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010090; cv=none; b=nsSl7RAFWLN2aRRFu7VoQiLdDEvFCjAlOZqsqbuK0KjShvFoEoKo+CBJIQeb7uWjYM7WXM98Ux5aKb/nNQNgyzV895AbyAL8y12c8QYngehx+GIVOHCg+xx+LAJCQX+wgp8UNAMTEuC3q8qw1iP1Tugmdq3VaoMH6iKbjAzZ5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010090; c=relaxed/simple;
	bh=MA+ZcYIUn/C28DKNLCi4W6hUtQhlgmcukjYPAcPtLjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/zc0X/OGTD6buhsAefrEBgDNWXd9TJxsAfDVAgW6EXwwzSHANoVti0tca7nYcFDUsXihOhTZczzkZMKLO0mPWqMYYjUynmwaFDkn3BLb7MH4oEYotO0X6ua3QUxZKYRW78oj8RDmnznPEfmpsPPLRFAQtGbNuzfbi0plTcJmuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIvufl2K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIvufl2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010741F000FF;
	Mon, 21 Sep 2026 17:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790010089;
	bh=LDYfj0q0WBbc27zJfQKY47KhE5CkSTCe0tT5qQ5LOuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YIvufl2KQ/GmFXyad1oCBKcuqybWf/Yt8lXLGX5IJCfSonNJA4vvhaTFnghQMVcmo
	 xdZBV+4sQAm0MAZe2kCCVhSY30RNqNxUvsldGpqSGxRkkxNaGT3eCYF3uUUT+jMx43
	 Mh5KIxaE7RZ8rWrfkvHrO4ZJVENXvA/8Ucw5xPJZnIrL87+27oVEfLw8rdqhXoICrs
	 3sVK9FxEYzg140DNb+DzWI9anb5AyljUp9yfDsATkHmOxiBSVr4Wt2x6yv5oX9ao+r
	 E0ztA/vE4eVQsSBun/CZE7RW9fKl3NYMl1TjWTFArFGYHf3c4WA94/525bvdra3x9T
	 ywdZn8rCcHRNw==
Date: Mon, 21 Sep 2026 12:01:27 -0500
From: Rob Herring <robh@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: arm: apple: apple,pmgr: Add t8140
 compatible
Message-ID: <20260921170127.GA894200-robh@kernel.org>
References: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
 <20260911-apple-a18-pro-initial-devicetrees-v2-2-08d06cf011d4@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-apple-a18-pro-initial-devicetrees-v2-2-08d06cf011d4@cyberchaos.dev>

On Fri, Sep 11, 2026 at 06:58:39PM +0200, Yureka Lilian wrote:
> The PMGR blocks on the Apple silicon A18 Pro SoC (t8140) is compatible
> with the M1-M4 SoCs. Add "apple,t8140-pmgr" as A18 Pro specific
> compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring (Arm) <robh@kernel.org>
