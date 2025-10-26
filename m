Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E5C19539F;
	Sun, 26 Oct 2025 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761514635; cv=none; b=kJWP3KYaLH0L5iUL0Gv3rDH0vm5W57i1BhgBNcYa4ATycfEoof16nWRbXpxu9Ya58RWsYm7uDGFjt7cCVJrDe8CNvUOSO9wfwXWRQmpNcPd89Ob8Lt1gaQqDrCUYwMaWa8Ok0Jh0psLiI4Y0UhG3InIGxLVaJHtMaphPy/cFREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761514635; c=relaxed/simple;
	bh=wEjYWbi+BTe/TjLsdMw5NwAzQqbfXXpeD4BVOSaJePs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3FaOjYngplD2TSO1Ow5+eqDttE8nj7S8DC4kCZx6LIFXfp4LkljKxVKr9JuAGzPYfSEF8jH8C4dpwwPa/UHZ5u6CYwDeA4k04gyozU1UYX+SHloloULylOgfxBNWo3O5elvccanHr4z+QY3oslwmXybriYuqa0pPhQ+5KYqtv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsZb2bpD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsZb2bpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA69C4CEE7;
	Sun, 26 Oct 2025 21:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761514635;
	bh=wEjYWbi+BTe/TjLsdMw5NwAzQqbfXXpeD4BVOSaJePs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsZb2bpD0NLW49ReodzCzV5NbSkMc0egaLgw25kCCSHwHkOr5sDp3ki1hmBuQ8LvW
	 rkulQlefC8LevGXbCix+jnDjxG746n7c5IsgGqEI+hWrVmCO4RnVWb5tHdpo6XOuQK
	 zkdI5nz/iACHmKdMbJXv9bSpAPnndxEC7kzMUAUM7VBMyH7Y/UFUNUqcWUrUJkAf0i
	 IDB38onjJk8FXaUzeewsh7MyTSLeeODdgvtVEXFuUCDeFBXBUG7bTw1U1oAVrempCG
	 MUubjUiOW4jxkkGClmvHZzQ+uf4lAyO/EkXhPsPP4xapPJ+PG+UEaOiP9NfBeXeHTL
	 w/mXUlVtTzCiA==
Date: Sun, 26 Oct 2025 16:37:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Timothy Pearson <tpearson@raptorengineering.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH 3/3] dt-bindings: mfd: rohm,bd96801-pmic: Correct
 timeout-sec length and reference watchdog schema
Message-ID: <176151460838.2981264.5357787312563158842.robh@kernel.org>
References: <20251020-dt-bindings-watchdog-timeout-v1-0-d0f3235eb327@linaro.org>
 <20251020-dt-bindings-watchdog-timeout-v1-3-d0f3235eb327@linaro.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-dt-bindings-watchdog-timeout-v1-3-d0f3235eb327@linaro.org>


On Mon, 20 Oct 2025 18:52:22 +0200, Krzysztof Kozlowski wrote:
> The parent node of ROHM BD96801 PMIC is also holding properties for the
> watchdog, thus it should reference watchdog.yaml schema.  OTOH, the
> timeout-sec property is used only as one number.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This depends on previous watchdog patch.  I propose to take entire set
> via watchdog tree, with Lee's acks.
> ---
>  Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

