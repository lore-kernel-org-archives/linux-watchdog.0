Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD338911B;
	Wed, 13 May 2026 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711338; cv=none; b=MBVoea5y0jP/7JEfdZViNC44vPaVoqvfsdt2Djuu2K2LuJ/GojpcCa4Jh7hTU8o7+ypqBQKnana+PSBqeFwWzTFZCAFVKL2ZIR8aujqvd2yEyZm4W0MRtd7UDnGBVbL2FnEt/62NF/8FfCWzIHvOReMH6vLpipp9WoS77FRKoi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711338; c=relaxed/simple;
	bh=5Nk0rRgq80ty0dx/6K6KZ2bDzftzeT3LI4fZFjuUYUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGzyAsU6tv7fBsV3Lq5kuOOdKT6PLkgv0y/ZMr1FJ4GVSPYpf9csdSCBypUUE9sXJ/utMRCkawnrGmHt8cagkvZag5h8nMwCxTNnYgJryLApmRyN2B7oV1NuHwpd31V/8yGUHS4W6Hs/IPDlDnhnEBGGVzgbq6ZIEkX5MX8YDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkSTDeX+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkSTDeX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DA9C19425;
	Wed, 13 May 2026 22:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778711338;
	bh=5Nk0rRgq80ty0dx/6K6KZ2bDzftzeT3LI4fZFjuUYUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KkSTDeX+KNPPe6GO2wGypLPD4LOzQ8dTJBdQbPnG9vsBEiWhkS3eIynY/sloT9Oes
	 Pe23Z4C3abDpKJo3HSvOcIdSKxsLTMFFNIOYtw0bL3Ga0x/yHwikA4OCT/IP3OG5YY
	 XJ4Ah7Aa7gEdsNHYB5BtV7w1UWTgvwSkfRBwLxJK+5P61AiW/zYzMSIUZrS14jK2Vn
	 M9Uhd9UqLRYXuCnYLSUkMGZcElveo3FW8krb0gLn9XJnbOHTljttUUj7fHJVWNu5aW
	 A4jjduLAjytjYCTNaDUzKWOd/e+HFGFV+jfwqsUBlfX6khY7uwqC33DqpDh9HQFGo6
	 jTj2qMOY2HrIQ==
Date: Wed, 13 May 2026 17:28:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-renesas-soc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>,
	linux-watchdog@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v4 4/4] dt-bindings: watchdog: renesas,rzn1-wdt:
 interrupts are not required
Message-ID: <177871133450.2129345.2012198232996151400.robh@kernel.org>
References: <20260507102410.43384-1-wsa+renesas@sang-engineering.com>
 <20260507102410.43384-5-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507102410.43384-5-wsa+renesas@sang-engineering.com>


On Thu, 07 May 2026 12:24:09 +0200, Wolfram Sang wrote:
> It is now understood how the watchdog can do its job without the need of
> an interrupt. So, it is not required anymore but optional.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

