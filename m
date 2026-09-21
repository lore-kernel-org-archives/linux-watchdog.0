Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D343C3F58;
	Mon, 21 Sep 2026 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010107; cv=none; b=iDbBInuiI+LXI2iNLhM5GWosZX0jxC3hffrKqTAXrPh1UHsUjNL4ZZ9ZS9TVuN+H4ePYz93jCIXDzwf88SYppL8CIFNjzG3CAz0ACKUhdaFaO7/LCJ1JGVvuUruB5aUy7ZKV41qkdNbvoTNQIzMOYEnWbh7uxLWrfJQhPdiOzYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010107; c=relaxed/simple;
	bh=8a8/BCiSe8xKweqxj1JJOcUDxGBje5KoVGi5IMgOTo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E352UVFkwIQyXBHC23+dLfdSdTCsjgp4nPcLYDo2Mej3QSMyfyQQ4xbpf/v8XY4EM88z9+I9tO8dyCqL9EiuT2sAotZ5xGGMR6GD69lgS1u+kVyQ6UUA/eXfcpRZkwP7N9Sim3+zUy7tuAoIxrik1E1pyO5J9Ew5rDJtz0mpN4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIpvpqes; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIpvpqes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C1D1F000FF;
	Mon, 21 Sep 2026 17:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790010106;
	bh=zW6n2whwAnfcyRSHzFtmAav/mfRX7I5cVOpyJ0tCWSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iIpvpqeskhjo4JuOBW6ln5mxz4k3JeSD/fwn6cKOWUz29LsV4ZE5LBMywJu0u4GUa
	 /gYsekj/WrUSUjvBfsbKdrHgPqcRav2chDbezOmA0jvkJ6RP9zissyj4Cw9Zz/jplb
	 OFaKYmBcasebsZJ1wvzTlrVvqdDMTEUzVSRcSI6gY7JsqyMQWDKOFYKeykh936TTZD
	 CC0vlQXXX7E+BC8k434M19YXBNydkO6e9W0tpecluHXy7h4ZbJBAaNt3h9DCYk2vle
	 TokAvKGEwqdw7yW4aM0U5i9q63pCKli8fm6O1u9blXHjtmVH0wA12yjwSTAKk1KR5S
	 y9e+FPGk6lDgg==
Date: Mon, 21 Sep 2026 12:01:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	Hector Martin <marcan@marcan.st>, linux-watchdog@vger.kernel.org,
	Radu Rendec <radu@rendec.net>, asahi@lists.linux.dev,
	Conor Dooley <conor+dt@kernel.org>, Neal Gompa <neal@gompa.dev>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sven Peter <sven@kernel.org>
Subject: Re: [PATCH v2 4/7] dt-bindings: interrupt-controller: apple,aic2:
 Add t8140 compatible
Message-ID: <179001010368.896395.13199235602357097060.robh@kernel.org>
References: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
 <20260911-apple-a18-pro-initial-devicetrees-v2-4-08d06cf011d4@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-apple-a18-pro-initial-devicetrees-v2-4-08d06cf011d4@cyberchaos.dev>


On Fri, 11 Sep 2026 18:58:41 +0200, Yureka Lilian wrote:
> The Apple t8140 (A18 Pro) SoC uses an AIC3 as interrupt controller, same as
> the M1-M4 SoCs.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

