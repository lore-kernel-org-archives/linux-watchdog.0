Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2049E29ACF6;
	Tue, 23 Jun 2026 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201929; cv=none; b=cRm1IucduBDWQx/HjvP34yGZsWt+cK1xH3vSWk6dLgf1QEokuRPOMsDghF3aWna2/wOdOC7Q+XPRbYkHuhjwUFoWnnle9zIcpUjWHr2TddIXAvm2ziKrn2dZLlK3e3aOZcKxc5HnfIl68SZwkoN9EqRCivq6cKalXLG4/6E/k4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201929; c=relaxed/simple;
	bh=bU2+giOUB2sKQipDsJx4vuSshbOB3S4lFLv6QJlQLTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0ufodWTC/HwafsWhI9yOGjHOjMCJ83T3GkEL3Lg9eKKhhDhQ6YkFj8M//OAhOaGKJuLJMx5zvsPoVnIO25mYyyp+/cs1Bgx6VFV4tA+wA8eH1jkPUCzlW0a5PdhWyb7zcW01kPj9Mqh+CIXW4nMEM3i169rtbNcfPxR9nCAG94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpPTKrrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpPTKrrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A6D1F000E9;
	Tue, 23 Jun 2026 08:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782201927;
	bh=1aHtGofhHLMB8j7InSkqYYRn7GlNQy+IpF/+m73egvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UpPTKrrUW1rshvAn7yi8V2OoPID98lpOrMAsL+vXA8/m3fBcsYLSJUaFRhKdMj3BS
	 yrQ+N/zkwkx1TL9mJF59PUNwuIeGb6eQO832wNTCO9Ydik+Iqb++Y68khZ2fmZPSB3
	 8lx8UcdaQPcpOAj/iXTAE5LDcTgGdsRePdjpu/+8fh+9tWkmvOyuzFPMCH8bWgdVz1
	 u6rwIcHrAKjMLkOFQKCVhQJN574oBHShYVIAuaBQHfSDtysW8Q8OEHl1helhH8vvzw
	 Fz6QiM9vg6WEU80bozpJplfrkx0PNNqbdphZs13yExwrTj9kZ/p5mat2h5XHPcVHHY
	 IarHs2rY6eoSA==
Date: Tue, 23 Jun 2026 10:05:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: andrew@codeconstruct.com.au, wim@linux-watchdog.org, 
	linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	openbmc@lists.ozlabs.org, linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, avifishman70@gmail.com, 
	tali.perry1@gmail.com, venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, joel@jms.id.au
Subject: Re: [PATCH v2 1/3] dt-bindings: watchdog: npcm: add GCR syscon
 property
Message-ID: <20260623-ochre-spoonbill-of-security-a4bc42@quoll>
References: <20260622083046.3189603-1-tmaimon77@gmail.com>
 <20260622083046.3189603-2-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260622083046.3189603-2-tmaimon77@gmail.com>

On Mon, Jun 22, 2026 at 11:30:44AM +0300, Tomer Maimon wrote:
> Describe syscon property that handles general control registers (GCR) in
> Nuvoton BMC NPCM watchdog driver.

Why? Well, you try to answer by saying something about driver, but we do
not add bindings for drivers. Instead hardware should be the reason.

Anyway, why is this needed now?

> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml   | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
> index 7aa30f5b5c49..4f00f099b2d2 100644
> --- a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm750-wdt.yaml
> @@ -40,6 +40,12 @@ properties:
>    clock-frequency:
>      description: Frequency in Hz of the clock that drives the NPCM timer.
>  
> +  nuvoton,sysgcr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      a phandle to access GCR registers on NPCM750 and NPCM845 watchdog
> +      instances.

Here you write also for what purpose.


Best regards,
Krzysztof

